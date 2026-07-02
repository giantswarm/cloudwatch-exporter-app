#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

repo_dir=$(git rev-parse --show-toplevel) ; readonly repo_dir

cd "${repo_dir}"

readonly helpers="./helm/cloudwatch-exporter/templates/_helpers.tpl"
readonly team_label='application.giantswarm.io/team: {{ index .Chart.Annotations "io.giantswarm.application.team" | quote }}'

# Inject the Giant Swarm team label into the common labels helper so all
# rendered resources carry it. Idempotent: skip if already present.
if ! grep -qF 'application.giantswarm.io/team' "${helpers}" ; then
        sed -i "/helm.sh\/chart: {{ include \"yet-another-cloudwatch-exporter.chart\" . }}/a ${team_label}" "${helpers}"
fi
