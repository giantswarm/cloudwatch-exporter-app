#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

repo_dir=$(git rev-parse --show-toplevel) ; readonly repo_dir
script_dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd ) ; readonly script_dir

cd "${repo_dir}"

readonly script_dir_rel=".${script_dir#"${repo_dir}"}"

# values.schema.json is NOT copied here: it is generated from values.yaml and
# .schema.yaml by the helm-schema pre-commit hook. Copying a stored copy would
# fight that hook -- sync.sh would revert the generated schema and the hook
# would regenerate it, so neither pre-commit nor validate-sync-diffs could pass.
set -x
cp "${script_dir_rel}/values.yaml" ./helm/cloudwatch-exporter/values.yaml

{ set +x; } 2>/dev/null
