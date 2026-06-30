# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Giant Swarm Helm chart wrapper for [Yet Another CloudWatch Exporter (yace)](https://github.com/prometheus-community/yet-another-cloudwatch-exporter), maintained by the `cabbage` team. It syncs the upstream `prometheus-yet-another-cloudwatch-exporter` chart from the `prometheus-community` Helm repository using **vendir** and applies a values patch for Giant Swarm defaults.

## Common Commands

```bash
# Sync from upstream and apply patches
./sync/sync.sh

# Lint / render the chart
helm lint helm/cloudwatch-exporter
helm template cw helm/cloudwatch-exporter
```

## Upstream Sync Pattern

The core pattern is **vendir + patches**:

- `vendir.yml` — pins the upstream chart version (fetched from `https://prometheus-community.github.io/helm-charts`)
- `vendor/` — raw upstream chart after `vendir sync` (git-ignored)
- `helm/cloudwatch-exporter/` — the published chart; populated by vendir from `vendor/`, except `Chart.yaml` which is ours (kept via `ignorePaths`)
- `sync/sync.sh` — runs vendir, strips vendir's trailing-whitespace noise, applies patches, regenerates `diffs/`
- `sync/patches/values/` — the only patch for now. `patch.sh` copies `values.yaml` and `values.schema.json` into the chart. These are our owned baseline and may diverge from upstream.
- `diffs/` — generated record of how the published chart diverges from raw upstream (do not hand-edit)

Never edit files under `helm/cloudwatch-exporter/` directly (except `Chart.yaml`); they are regenerated on every sync. Edit the patch source in `sync/patches/` and re-run `sync.sh`.

## Updating from Upstream

1. Check the latest upstream chart: `curl -s https://prometheus-community.github.io/helm-charts/index.yaml | yq e '.entries.prometheus-yet-another-cloudwatch-exporter[0] | {"version": .version, "appVersion": .appVersion}' -`
2. Branch, then bump `version` in `vendir.yml`.
3. Run `./sync/sync.sh`.
4. Diff `sync/patches/values/values.yaml` against `vendor/cloudwatch-exporter/values.yaml` to fold in new or removed upstream fields; update `values.schema.json` accordingly.
5. Update `appVersion` in `helm/cloudwatch-exporter/Chart.yaml` to match the new upstream appVersion.
6. Re-run `./sync/sync.sh` if you changed the patch.
7. Add a `## [Unreleased]` entry to `CHANGELOG.md`. Do not bump `Chart.yaml` `version` or create a versioned section; CI handles that.
8. Commit `vendir.yml`, `vendir.lock.yml`, `sync/patches/`, `helm/`, `diffs/`, and `CHANGELOG.md`.

## Release Process

- Releases are triggered by pushing a git tag matching `/^v.*/`.
- CircleCI (`architect/push-to-app-catalog`) packages and pushes to `giantswarm-catalog` and `giantswarm-test-catalog`.
