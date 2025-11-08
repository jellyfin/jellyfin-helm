# jellyfin

![Version: 3.0.0](https://img.shields.io/badge/Version-3.0.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 10.11.2](https://img.shields.io/badge/AppVersion-10.11.2-informational?style=flat-square)

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
| dnsConfig | object | `{}` | Define a dnsConfig. See https://kubernetes.io/docs/concepts/services-networking/dns-pod-service/#pod-dns-config Use this to provide a custom DNS resolver configuration |
| dnsPolicy | string | `""` | Define a dnsPolicy. See https://kubernetes.io/docs/concepts/services-networking/dns-pod-service/#pod-s-dns-policy |
| extraContainers | list | `[]` | additional sidecar containers to run inside the pod. |
| extraInitContainers | list | `[]` | Additional init containers to run inside the pod. Init containers run before the main application container starts. See: https://kubernetes.io/docs/concepts/workloads/pods/init-containers/ Example: extraInitContainers:   - name: init-config     image: busybox:1.35     command: ['sh', '-c', 'echo "Initializing..." && sleep 5']     volumeMounts:       - name: config         mountPath: /config |
| fullnameOverride | string | `""` | Override the default full name of the chart. |
| httpRoute | object | `{"annotations":{},"enabled":false,"hostnames":[],"parentRefs":[],"rules":[{"matches":[{"path":{"type":"PathPrefix","value":"/"}}]}]}` | HTTPRoute configuration for Gateway API. See: https://gateway-api.sigs.k8s.io/ |
| httpRoute.hostnames | list | `[]` | Hostnames to match for this HTTPRoute |
| httpRoute.parentRefs | list | `[]` | Gateway references to attach this HTTPRoute to |
| httpRoute.rules | list | `[{"matches":[{"path":{"type":"PathPrefix","value":"/"}}]}]` | Rules for routing traffic |
| image.pullPolicy | string | `"IfNotPresent"` | Image pull policy (Always, IfNotPresent, or Never). |
| image.repository | string | `"docker.io/jellyfin/jellyfin"` | Container image repository for Jellyfin. |
| image.tag | string | `""` | Jellyfin container image tag. Leave empty to automatically use the Chart's app version. |
| imagePullSecrets | list | `[]` | Image pull secrets to authenticate with private repositories. See: https://kubernetes.io/docs/tasks/configure-pod-container/pull-image-private-registry/ |
| ingress | object | `{"annotations":{},"className":"","enabled":false,"hosts":[{"host":"chart-example.local","paths":[{"path":"/","pathType":"ImplementationSpecific"}]}],"tls":[]}` | Ingress configuration. See: https://kubernetes.io/docs/concepts/services-networking/ingress/ |
| initContainers | list | `[]` | DEPRECATED: Use extraInitContainers instead. Will be removed after 2030. @deprecated - This parameter is deprecated, use extraInitContainers instead |
| jellyfin.args | list | `[]` | Additional arguments for the entrypoint command. |
| jellyfin.command | list | `[]` | Custom command to use as container entrypoint. |
| jellyfin.enableDLNA | bool | `false` | Enable DLNA. Requires host network. See: https://jellyfin.org/docs/general/networking/dlna.html |
| jellyfin.env | list | `[]` | Additional environment variables for the container. Example: Workaround for inotify limits (see Troubleshooting section in README) Example: env:   - name: JELLYFIN_CACHE_DIR     value: /cache |
| jellyfin.envFrom | list | `[]` | Load environment variables from ConfigMap or Secret. See: https://kubernetes.io/docs/tasks/configure-pod-container/configure-pod-configmap/#configure-all-key-value-pairs-in-a-configmap-as-container-environment-variables Example: envFrom:   - configMapRef:       name: jellyfin-config   - secretRef:       name: jellyfin-secrets |
| livenessProbe | object | `{"httpGet":{"path":"/health","port":"http"},"initialDelaySeconds":10}` | Configure liveness probe for Jellyfin. This probe is disabled during startup (startup probe handles initial checks). Uses httpGet for compatibility with both IPv4 and IPv6. |
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
| persistence.cache.accessMode | string | `"ReadWriteOnce"` | PVC specific settings, only used if type is 'pvc'. |
| persistence.cache.annotations | object | `{}` | Custom annotations to be added to the PVC |
| persistence.cache.enabled | bool | `false` | set to false to use emptyDir |
| persistence.cache.hostPath | string | `""` | Path on the host node for cache storage, only used if type is 'hostPath'. |
| persistence.cache.size | string | `"10Gi"` |  |
| persistence.cache.storageClass | string | `""` | If undefined (the default) or set to null, no storageClassName spec is set, choosing the default provisioner. |
| persistence.cache.type | string | `"pvc"` | Type of volume for cache storage (pvc, hostPath, emptyDir). If 'enabled' is false, 'emptyDir' is used regardless of this setting. |
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
| podPrivileges | object | `{"hostIPC":false,"hostNetwork":false,"hostPID":false}` | Privileged pod settings for advanced use cases |
| podPrivileges.hostIPC | bool | `false` | Enable hostIPC namespace. Required for NVIDIA MPS (Multi-Process Service) GPU sharing. See: https://docs.nvidia.com/deploy/mps/index.html |
| podPrivileges.hostNetwork | bool | `false` | Enable hostNetwork. Allows pod to use the host's network namespace. |
| podPrivileges.hostPID | bool | `false` | Enable hostPID namespace. Allows pod to see processes on the host. |
| podSecurityContext | object | `{}` | Security context for the pod. |
| priorityClassName | string | `""` | Define a priorityClassName for the pod. |
| readinessProbe | object | `{"httpGet":{"path":"/health","port":"http"},"initialDelaySeconds":10}` | Configure readiness probe for Jellyfin. This probe is disabled during startup (startup probe handles initial checks). Uses httpGet for compatibility with both IPv4 and IPv6. |
| replicaCount | int | `1` | Number of Jellyfin replicas to start. Should be left at 1. |
| resources | object | `{}` | Resource requests and limits for the Jellyfin container. |
| revisionHistoryLimit | int | `3` | Number of old ReplicaSets to retain for rollback history. Set to 0 to disable revision history (not recommended). If not specified, Kubernetes defaults to 10. See: https://kubernetes.io/docs/concepts/workloads/controllers/deployment/#revision-history-limit |
| runtimeClassName | string | `""` | Define a custom runtimeClassName for the pod. |
| securityContext | object | `{}` | Security context for the container. |
| service.annotations | object | `{}` | Annotations for the service. |
| service.ipFamilies | list | `[]` | Supported IP families (IPv4, IPv6). Examples:   IPv4 only: ["IPv4"]   IPv6 only: ["IPv6"]   Dual-stack (IPv4 primary): ["IPv4", "IPv6"]   Dual-stack (IPv6 primary): ["IPv6", "IPv4"] Note: When using IPv6, ensure your health checks are compatible (consider using httpGet instead of tcpSocket) |
| service.ipFamilyPolicy | string | `""` | Configure dual-stack IP family policy. See: https://kubernetes.io/docs/concepts/services-networking/dual-stack/ Options: SingleStack, PreferDualStack, RequireDualStack For IPv6-only clusters, use "SingleStack" with ipFamilies: ["IPv6"] For dual-stack, use "PreferDualStack" or "RequireDualStack" with ipFamilies: ["IPv4", "IPv6"] or ["IPv6", "IPv4"] |
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
| startupProbe | object | `{"failureThreshold":30,"initialDelaySeconds":0,"periodSeconds":10,"tcpSocket":{"port":"http"}}` | Configure startup probe for Jellyfin. This probe gives Jellyfin enough time to start, especially with large media libraries. After the startup probe succeeds once, liveness and readiness probes take over. |
| tolerations | list | `[]` | Tolerations for pod scheduling. |
| volumeMounts | list | `[]` | Additional volume mounts for the Jellyfin container. |
| volumes | list | `[]` | Additional volumes to mount in the Jellyfin pod. |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.14.2](https://github.com/norwoodj/helm-docs/releases/v1.14.2)

## Gateway API HTTPRoute

This chart supports the Kubernetes Gateway API HTTPRoute resource as a modern alternative to Ingress.

To use HTTPRoute, you need to have Gateway API CRDs installed in your cluster and a Gateway resource configured.

Example configuration:

```yaml
httpRoute:
  enabled: true
  annotations: {}
  parentRefs:
    - name: my-gateway
      namespace: gateway-system
      sectionName: https
  hostnames:
    - jellyfin.example.com
  rules:
    - matches:
        - path:
            type: PathPrefix
            value: /
```

For more information about Gateway API, see: <https://gateway-api.sigs.k8s.io/>

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

## Troubleshooting

### inotify Instance Limit Reached

**Problem:** Jellyfin crashes with error:
```
System.IO.IOException: The configured user limit (128) on the number of inotify instances has been reached
```

**Root cause:** The Linux kernel has a limit on inotify instances (file system watchers) per user. Jellyfin uses inotify to monitor media libraries for changes.

**Proper solution (recommended):**

Increase the inotify limit on the Kubernetes nodes:

```bash
# Temporary (until reboot)
sysctl -w fs.inotify.max_user_instances=512

# Permanent
echo "fs.inotify.max_user_instances=512" >> /etc/sysctl.conf
sysctl -p
```

Recommended values:
- `fs.inotify.max_user_instances`: 512 or higher
- `fs.inotify.max_user_watches`: 524288 or higher (if you have large media libraries)

**Workaround (if you cannot modify host settings):**

If you're running on a managed Kubernetes cluster where you cannot modify node-level settings, you can force Jellyfin to use polling instead of inotify. **Note: This is less efficient and may increase CPU usage and delay change detection.**

```yaml
jellyfin:
  env:
    - name: DOTNET_USE_POLLING_FILE_WATCHER
      value: "1"
```

This workaround disables inotify file watching in favor of periodic polling, which doesn't require inotify instances but is less efficient.

## IPv6 Configuration

This chart supports IPv6 and dual-stack networking configurations out of the box. Health probes use httpGet by default for compatibility with both IPv4 and IPv6.

### IPv6-only Configuration

For IPv6-only clusters:

```yaml
service:
  ipFamilyPolicy: SingleStack
  ipFamilies:
    - IPv6
```

### Dual-stack Configuration

For dual-stack clusters (both IPv4 and IPv6):

```yaml
service:
  ipFamilyPolicy: PreferDualStack  # or RequireDualStack
  ipFamilies:
    - IPv4
    - IPv6  # First family in the list is the primary
```

For more information about Kubernetes dual-stack networking, see: <https://kubernetes.io/docs/concepts/services-networking/dual-stack/>
