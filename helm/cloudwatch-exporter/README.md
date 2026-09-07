# cloudwatch-exporter

Yace - Yet Another CloudWatch Exporter

**Homepage:** <https://github.com/giantswarm/cloudwatch-exporter-app>

## Source Code

* <https://github.com/prometheus-community/yet-another-cloudwatch-exporter>

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| replicaCount | int | `1` |  |
| image.registry | string | `"gsoci.azurecr.io"` |  |
| image.repository | string | `"giantswarm/yet-another-cloudwatch-exporter"` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.tag | string | `""` |  |
| imagePullSecrets | list | `[]` |  |
| nameOverride | string | `""` |  |
| fullnameOverride | string | `""` |  |
| serviceAccount.create | bool | `true` | Specifies whether a service account should be created |
| serviceAccount.labels | object | `{}` | Labels to add to the service account |
| serviceAccount.annotations | object | `{}` | Annotations to add to the service account. Keys and values can be templated, as an example: "{{ .Values.foo }}: {{ .Values.bar }}" |
| serviceAccount.name | string | `""` | The name of the service account to use. If not set and create is true, a name is generated using the fullname template |
| serviceAccount.automountServiceAccountToken | bool | `true` |  |
| podAnnotations | object | `{}` |  |
| podLabels | object | `{}` |  |
| deployment.labels | object | `{}` |  |
| portName | string | `"http"` |  |
| containerPort | int | `5000` |  |
| podSecurityContext.runAsNonRoot | bool | `true` |  |
| podSecurityContext.runAsUser | int | `1000` |  |
| podSecurityContext.seccompProfile.type | string | `"RuntimeDefault"` |  |
| securityContext.allowPrivilegeEscalation | bool | `false` |  |
| securityContext.privileged | bool | `false` |  |
| securityContext.runAsNonRoot | bool | `true` |  |
| securityContext.runAsUser | int | `1000` |  |
| securityContext.readOnlyRootFilesystem | bool | `true` |  |
| securityContext.capabilities.drop[0] | string | `"ALL"` |  |
| securityContext.seccompProfile.type | string | `"RuntimeDefault"` |  |
| service.type | string | `"ClusterIP"` |  |
| service.port | int | `80` |  |
| service.annotations | object | `{}` | Annotations to add to the service |
| testConnection | bool | `true` |  |
| ingress.enabled | bool | `false` |  |
| ingress.className | string | `""` |  |
| ingress.annotations | object | `{}` |  |
| ingress.hosts[0].host | string | `"chart-example.local"` |  |
| ingress.hosts[0].paths[0].path | string | `"/"` |  |
| ingress.hosts[0].paths[0].pathType | string | `"ImplementationSpecific"` |  |
| ingress.tls | list | `[]` |  |
| resources.requests.cpu | string | `"100m"` |  |
| resources.requests.memory | string | `"128Mi"` |  |
| resources.limits.memory | string | `"256Mi"` |  |
| nodeSelector | object | `{}` |  |
| priorityClassName | string | `nil` |  |
| tolerations | list | `[]` |  |
| affinity | object | `{}` |  |
| podDisruptionBudget.enabled | bool | `false` |  |
| podDisruptionBudget.minAvailable | int | `1` |  |
| podDisruptionBudget.unhealthyPodEvictionPolicy | string | `"AlwaysAllow"` |  |
| extraEnv | list | `[]` |  |
| extraEnvFrom | list | `[]` |  |
| extraArgs | object | `{}` |  |
| extraVolumeMounts | list | `[]` |  |
| extraVolumes | list | `[]` |  |
| lifecycle | object | `{}` |  |
| aws.role | string | `nil` |  |
| aws.secret.name | string | `nil` |  |
| aws.secret.includesSessionToken | bool | `false` |  |
| aws.aws_access_key_id | string | `nil` |  |
| aws.aws_secret_access_key | string | `nil` |  |
| serviceMonitor.enabled | bool | `true` |  |
| prometheusRule.enabled | bool | `false` |  |
| configMap.enabled | bool | `true` |  |
| clusterID | string | `""` |  |
| region | string | `"eu-north-1"` |  |
