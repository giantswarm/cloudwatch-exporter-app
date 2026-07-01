#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd ) ; readonly dir
cd "${dir}/.."

# Stage 1 sync
set -x
vendir sync
{ set +x; } 2>/dev/null

# Remove trailing whitespace end of lines (hack to fix vendir bug). Strip both
# the raw vendored copy and the chart copy vendir writes into helm/, so the
# diffs below capture real customizations only and not whitespace noise.
find vendor/ -type f -exec sed -i 's/[[:space:]]*$//' {} \;
find helm/cloudwatch-exporter/ -type f -exec sed -i 's/[[:space:]]*$//' {} \;

# Patches
./sync/patches/values/patch.sh

# Store diffs
rm -f ./diffs/*
for f in $(git --no-pager diff --no-exit-code --no-color --no-index vendor/cloudwatch-exporter helm/cloudwatch-exporter --name-only) ; do
        # Skip /dev/null.
        [[ "$f" == "/dev/null" ]] && continue
        # Skip helm/cloudwatch-exporter/Chart.yaml; as we take it as our own.
        [[ "$f" == "helm/cloudwatch-exporter/Chart.yaml" ]] && continue
        [[ "$f" == "helm/cloudwatch-exporter/Chart.lock" ]] && continue

        base_file="vendor/cloudwatch-exporter/${f#"helm/cloudwatch-exporter/"}"
        [[ ! -e $base_file ]] && base_file="/dev/null"

        set +e
        set -x

        git --no-pager diff --no-exit-code --no-color --no-index "$base_file" "${f}" \
                > "./diffs/${f//\//__}.patch" # ${f//\//__} replaces all "/" with "__"

        { set +x; } 2>/dev/null
        set -e

        ret=$?
        if [ $ret -ne 0 ] && [ $ret -ne 1 ] ; then
                exit $ret
        fi
done
