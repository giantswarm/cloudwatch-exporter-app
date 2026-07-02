# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

- added: Initial chart, wrapping the upstream `prometheus-yet-another-cloudwatch-exporter` chart (`0.46.1`, appVersion `v0.65.0`) from the `prometheus-community` Helm repository. The upstream chart is vendored with `vendir` and customized through the values patch in `sync/patches/values/`.
- changed: Default the image registry to the Giant Swarm mirror `gsoci.azurecr.io` and enable the `ServiceMonitor` by default.
- changed: Replaced the generated dynamic-config `.circleci` with a static `config.yml` (architect orb v9.5.5) that packages and pushes the chart to the app catalog on tag.
- changed: Harden `securityContext` defaults for PSS restricted compliance on the Deployment and test pod, and reject non-compliant overrides in the schema.
- added: `application.giantswarm.io/team` label on all resources, sourced from the `io.giantswarm.application.team` chart annotation.
- added: Default resource requests (`100m` CPU, `128Mi` memory) and a `256Mi` memory limit.
- fixed: Pin the test pod's `busybox` image to a tagged mirror and set its CPU request and memory limit to satisfy kube-linter.

[Unreleased]: https://github.com/giantswarm/cloudwatch-exporter-app/tree/main
