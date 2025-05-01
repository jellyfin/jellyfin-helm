# jellyfin

![Version: 2.3.0](https://img.shields.io/badge/Version-2.3.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 10.10.7](https://img.shields.io/badge/AppVersion-10.10.7-informational?style=flat-square)

A Helm chart for Jellyfin Media Server

**Homepage:** <https://jellyfin.org/>

## Steps to Use a Helm Chart

### 1. Add a Helm Repository

Helm repositories contain collections of charts. You can add an existing repository using the following command:

```bash
helm repo add jellyfin https://jellyfin.github.io/jellyfin-helm
```

### 2. Install the Helm Chart

To install a chart, use the following command:

```bash
helm install my-jellyfin jellyfin/jellyfin
```

### 3. View the Installation

You can check the status of the release using:

```bash
helm status my-jellyfin
```

## Customizing the Chart

Helm charts come with default values, but you can customize them by using the --set flag or by providing a custom values.yaml file.

### 1. Using --set to Override Values
```bash
helm install my-jellyfin jellyfin/jellyfin --set key1=value1,key2=value2
```

### 2. Using a values.yaml File
You can create a custom values.yaml file and pass it to the install command:

```bash
helm install my-jellyfin jellyfin/jellyfin -f values.yaml
```

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` | Affinity rules for pod scheduling. |
| deploymentAnnotations | object | `{}` | Annotations to add to the deployment. |
| deploymentStrategy | object | `{"type":"RollingUpdate"}` | Deployment strategy configuration. See `kubectl explain deployment.spec.strategy`. |
| extraContainers | list | `[]` | additional sidecar containers to run inside the pod. |
| extraInitContainers | list | `[]` | additional init containers to run inside the pod. |
| fullnameOverride | string | `""` | Override the default full name of the chart. |
| image.pullPolicy | string | `"IfNotPresent"` | Image pull policy (Always, IfNotPresent, or Never). |
| image.repository | string | `"docker.io/jellyfin/jellyfin"` | Container image repository for Jellyfin. |
| image.tag | string | `""` | Jellyfin container image tag. Leave empty to automatically use the Chart's app version. |
| imagePullSecrets | list | `[]` | Image pull secrets to authenticate with private repositories. See: https://kubernetes.io/docs/tasks/configure-pod-container/pull-image-private-registry/ |
| ingress | object | `{"annotations":{},"className":"","enabled":false,"hosts":[{"host":"chart-example.local","paths":[{"path":"/","pathType":"ImplementationSpecific"}]}],"tls":[]}` | Ingress configuration. See: https://kubernetes.io/docs/concepts/services-networking/ingress/ |
| jellyfin.args | list | `[]` | Additional arguments for the entrypoint command. |
| jellyfin.command | list | `[]` | Custom command to use as container entrypoint. |
| jellyfin.enableDLNA | bool | `false` | Enable DLNA. Requires host network. See: https://jellyfin.org/docs/general/networking/dlna.html |
| jellyfin.env | list | `[]` | Additional environment variables for the container. |
| livenessProbe | object | `{"initialDelaySeconds":10,"tcpSocket":{"port":"http"}}` | Configure liveness probe for Jellyfin. |
| metrics | object | `{"enabled":false,"serviceMonitor":{"enabled":false,"interval":"30s","labels":{},"metricRelabelings":[],"namespace":"","path":"/metrics","port":8096,"relabelings":[],"scheme":"http","scrapeTimeout":"30s","targetLabels":[],"tlsConfig":{}}}` | Configuration for metrics collection and monitoring |
| metrics.enabled | bool | `false` | Enable or disable metrics collection |
| metrics.serviceMonitor | object | `{"enabled":false,"interval":"30s","labels":{},"metricRelabelings":[],"namespace":"","path":"/metrics","port":8096,"relabelings":[],"scheme":"http","scrapeTimeout":"30s","targetLabels":[],"tlsConfig":{}}` | Configuration for the Prometheus ServiceMonitor |
| metrics.serviceMonitor.enabled | bool | `false` | Enable or disable the creation of a ServiceMonitor resource |
| metrics.serviceMonitor.interval | string | `"30s"` | Interval at which metrics should be scraped |
| metrics.serviceMonitor.labels | object | `{}` | Labels to add to the ServiceMonitor resource |
| metrics.serviceMonitor.metricRelabelings | list | `[]` | Relabeling rules for the metrics before ingestion |
| metrics.serviceMonitor.namespace | string | `""` | Namespace where the ServiceMonitor resource should be created. Defaults to Release.Namespace |
| metrics.serviceMonitor.path | string | `"/metrics"` | Path to scrape for metrics |
| metrics.serviceMonitor.port | int | `8096` | Port to scrape for metrics |
| metrics.serviceMonitor.relabelings | list | `[]` | Relabeling rules for the scraped metrics |
| metrics.serviceMonitor.scheme | string | `"http"` | Scheme to use for scraping metrics (http or https) |
| metrics.serviceMonitor.scrapeTimeout | string | `"30s"` | Timeout for scraping metrics |
| metrics.serviceMonitor.targetLabels | list | `[]` | Target labels to add to the scraped metrics |
| metrics.serviceMonitor.tlsConfig | object | `{}` | TLS configuration for scraping metrics |
| nameOverride | string | `""` | Override the default name of the chart. |
| nodeSelector | object | `{}` | Node selector for pod scheduling. |
| persistence.config.accessMode | string | `"ReadWriteOnce"` |  |
| persistence.config.annotations | object | `{}` | Custom annotations to be added to the PVC |
| persistence.config.enabled | bool | `true` | set to false to use emptyDir |
| persistence.config.size | string | `"5Gi"` |  |
| persistence.config.storageClass | string | `""` | If undefined (the default) or set to null, no storageClassName spec is set, choosing the default provisioner. |
| persistence.media.accessMode | string | `"ReadWriteOnce"` | PVC specific settings, only used if type is 'pvc'. |
| persistence.media.annotations | object | `{}` | Custom annotations to be added to the PVC |
| persistence.media.enabled | bool | `true` | set to false to use emptyDir |
| persistence.media.hostPath | string | `""` | Path on the host node for media storage, only used if type is 'hostPath'. |
| persistence.media.size | string | `"25Gi"` |  |
| persistence.media.storageClass | string | `""` | If undefined (the default) or set to null, no storageClassName spec is set, choosing the default provisioner. |
| persistence.media.type | string | `"pvc"` | Type of volume for media storage (pvc, hostPath, emptyDir). If 'enabled' is false, 'emptyDir' is used regardless of this setting. |
| podAnnotations | object | `{}` | Annotations to add to the pod. |
| podLabels | object | `{}` | Additional labels to add to the pod. |
| podSecurityContext | object | `{}` | Security context for the pod. |
| priorityClassName | string | `""` | Define a priorityClassName for the pod. |
| readinessProbe | object | `{"initialDelaySeconds":10,"tcpSocket":{"port":"http"}}` | Configure readiness probe for Jellyfin. |
| replicaCount | int | `1` | Number of Jellyfin replicas to start. Should be left at 1. |
| resources | object | `{}` | Resource requests and limits for the Jellyfin container. |
| runtimeClassName | string | `""` | Define a custom runtimeClassName for the pod. |
| securityContext | object | `{}` | Security context for the container. |
| service.annotations | object | `{}` | Annotations for the service. |
| service.ipFamilies | list | `[]` | Supported IP families (IPv4, IPv6). |
| service.ipFamilyPolicy | string | `""` | Configure dual-stack IP family policy. See: https://kubernetes.io/docs/concepts/services-networking/dual-stack/ |
| service.labels | object | `{}` | Labels for the service. |
| service.loadBalancerClass | string | `""` | Class of the LoadBalancer. |
| service.loadBalancerIP | string | `""` | Specific IP address for the LoadBalancer. |
| service.loadBalancerSourceRanges | list | `[]` | Source ranges allowed to access the LoadBalancer. |
| service.port | int | `8096` | Port for the Jellyfin service. |
| service.portName | string | `"service"` | Name of the port in the service. |
| service.type | string | `"ClusterIP"` | Service type (ClusterIP, NodePort, or LoadBalancer). |
| serviceAccount | object | `{"annotations":{},"automount":true,"create":true,"name":""}` | Service account configuration. See: https://kubernetes.io/docs/concepts/security/service-accounts/ |
| serviceAccount.annotations | object | `{}` | Annotations for the service account. |
| serviceAccount.automount | bool | `true` | Automatically mount API credentials for the service account. |
| serviceAccount.create | bool | `true` | Specifies whether to create a service account. |
| serviceAccount.name | string | `""` | Custom name for the service account. If left empty, the name will be autogenerated. |
| tolerations | list | `[]` | Tolerations for pod scheduling. |
| volumeMounts | list | `[]` | Additional volume mounts for the Jellyfin container. |
| volumes | list | `[]` | Additional volumes to mount in the Jellyfin pod. |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.14.2](https://github.com/norwoodj/helm-docs/releases/v1.14.2)

## Hardware acceleration

Out of the box the pod does not have the necessary permissions to enable hardware acceleration (HWA) in Jellyfin.
Adding the following Helm values should make it enable you to use hardware acceleration features.
Some settings may need to be tweaked depending on the type of device (Intel/AMD/NVIDIA/...) and your container runtime.

Please refer to the Jellyfin upstream documentation for more information about hardware acceleration: <https://jellyfin.org/docs/general/administration/hardware-acceleration/>

```yaml
securityContext:
  capabilities:
    add:
      - "SYS_ADMIN"
    drop:
      - "ALL"
  privileged: false

extraVolumes:
  - name: hwa
    hostPath:
      path: /dev/dri

extraVolumeMounts:
  - name: hwa
    mountPath: /dev/dri
```
