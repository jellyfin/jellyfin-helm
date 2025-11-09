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

## Maintainers

This chart is maintained by the [Jellyfin Project](https://jellyfin.org).

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
| networkPolicy | object | `{"egress":{"allowAllEgress":true,"allowDNS":true,"customRules":[],"dnsNamespace":"kube-system","dnsPodSelector":{"k8s-app":"kube-dns"},"restrictedEgress":{"allowInCluster":true,"allowMetadata":true,"allowedCIDRs":[]}},"enabled":false,"ingress":{"allowExternal":true,"customRules":[],"namespaceSelector":{},"podSelector":{}},"metrics":{"namespace":"","podSelector":{"app.kubernetes.io/name":"prometheus"}},"policyTypes":["Ingress","Egress"]}` | Network Policy configuration for network isolation and security. Requires a CNI plugin that supports NetworkPolicy (Calico, Cilium, Weave, etc.). WARNING: NetworkPolicy cannot be enabled when hostNetwork is used (DLNA mode). The chart will fail with an error if both are enabled simultaneously. |
| networkPolicy.egress | object | `{"allowAllEgress":true,"allowDNS":true,"customRules":[],"dnsNamespace":"kube-system","dnsPodSelector":{"k8s-app":"kube-dns"},"restrictedEgress":{"allowInCluster":true,"allowMetadata":true,"allowedCIDRs":[]}}` | Egress rules configuration - controls what external connections Jellyfin can make. |
| networkPolicy.egress.allowAllEgress | bool | `true` | Allow all egress traffic (internet access for metadata, subtitles, images). When true, Jellyfin can connect to any external destination (0.0.0.0/0). This is the recommended default as Jellyfin needs internet access for: - Downloading movie/TV show metadata (TMDB, TheTVDB, OMDb) - Fetching poster images, fanart, and other artwork - Downloading subtitles (OpenSubtitles) - Updating plugins When false, you must configure restrictedEgress or customRules. |
| networkPolicy.egress.allowDNS | bool | `true` | Allow DNS resolution (required for Jellyfin to function). This adds an egress rule for kube-system namespace with kube-dns pods. DNS is required for resolving metadata provider domains and subtitle services. It is highly recommended to keep this enabled. |
| networkPolicy.egress.customRules | list | `[]` | Additional custom egress rules. Allows for complex scenarios not covered by the standard template. These rules are added as-is to the NetworkPolicy egress section. Example - allow connections to specific database:   customRules:     - to:       - podSelector:           matchLabels:             app: postgresql       ports:       - protocol: TCP         port: 5432 |
| networkPolicy.egress.dnsNamespace | string | `"kube-system"` | DNS namespace where DNS service is running. Usually "kube-system" but can differ in some Kubernetes distributions. |
| networkPolicy.egress.dnsPodSelector | object | `{"k8s-app":"kube-dns"}` | DNS pod selector labels. Default selector is for kube-dns, but CoreDNS or other DNS providers may use different labels. Adjust if needed. Common alternatives:   k8s-app: kube-dns (default)   k8s-app: coredns   app.kubernetes.io/name: coredns |
| networkPolicy.egress.restrictedEgress | object | `{"allowInCluster":true,"allowMetadata":true,"allowedCIDRs":[]}` | Restricted egress mode for security-conscious deployments. Only used when allowAllEgress is false. Provides fine-grained control over outbound connections. |
| networkPolicy.egress.restrictedEgress.allowInCluster | bool | `true` | Allow communication within the cluster (pod-to-pod). Useful if Jellyfin needs to connect to other services in the cluster. This allows connections to any pod in any namespace. |
| networkPolicy.egress.restrictedEgress.allowMetadata | bool | `true` | Allow HTTPS (443/TCP) for metadata providers. Most metadata providers (TMDB, TheTVDB, OpenSubtitles, Fanart.tv) use HTTPS, so this covers the majority of use cases. This allows connections to any IP on port 443. |
| networkPolicy.egress.restrictedEgress.allowedCIDRs | list | `[]` | Additional IP CIDR blocks to allow egress. Useful for allowing specific IP ranges for metadata providers or other external services. Example - allow entire internet except private networks:   allowedCIDRs:     - 0.0.0.0/0 Example - allow specific metadata provider IP ranges:   allowedCIDRs:     - 13.224.0.0/14  # CloudFront (used by many CDNs) |
| networkPolicy.enabled | bool | `false` | Enable NetworkPolicy for the Jellyfin pod. By default, this is disabled to maintain backward compatibility. When enabled, you can control which pods can access Jellyfin (ingress) and what external connections Jellyfin can make (egress). |
| networkPolicy.ingress | object | `{"allowExternal":true,"customRules":[],"namespaceSelector":{},"podSelector":{}}` | Ingress rules configuration - controls which pods/namespaces can access Jellyfin. |
| networkPolicy.ingress.allowExternal | bool | `true` | Allow external access from any namespace and any pod. When true, any pod in the cluster can access Jellyfin (default behavior). When false, only pods matching podSelector/namespaceSelector can access. Set to false for production environments to restrict access. |
| networkPolicy.ingress.customRules | list | `[]` | Additional custom ingress rules. Allows for complex scenarios not covered by the standard template. These rules are added as-is to the NetworkPolicy ingress section. Example - allow from monitoring namespace:   customRules:     - from:       - namespaceSelector:           matchLabels:             name: monitoring       ports:       - protocol: TCP         port: 8096 |
| networkPolicy.ingress.namespaceSelector | object | `{}` | Namespace selector to allow cross-namespace ingress. Only used when allowExternal is false. Allows you to specify which namespaces can access Jellyfin. Example - only allow from ingress-nginx namespace:   namespaceSelector:     matchLabels:       name: ingress-nginx |
| networkPolicy.ingress.podSelector | object | `{}` | Custom pod selector for allowed ingress traffic. Only used when allowExternal is false. Allows you to specify which pods can access Jellyfin based on labels. Example - only allow pods with specific label:   podSelector:     matchLabels:       jellyfin-client: "true" |
| networkPolicy.metrics | object | `{"namespace":"","podSelector":{"app.kubernetes.io/name":"prometheus"}}` | Prometheus metrics scraping configuration. Automatically allows ingress from Prometheus when metrics.serviceMonitor.enabled is true. This ensures Prometheus can scrape metrics without additional configuration. |
| networkPolicy.metrics.namespace | string | `""` | Namespace where Prometheus is running. Leave empty to use the same namespace as Jellyfin. Set to the monitoring namespace if Prometheus is in a different namespace. Example: "monitoring" or "prometheus" |
| networkPolicy.metrics.podSelector | object | `{"app.kubernetes.io/name":"prometheus"}` | Pod selector for Prometheus pods. These labels must match your Prometheus deployment. The chart will automatically add an ingress rule for pods matching these labels. Default selector works with prometheus-operator and kube-prometheus-stack. Adjust if your Prometheus uses different labels. |
| networkPolicy.policyTypes | list | `["Ingress","Egress"]` | Policy types to enforce. Both ingress and egress policies can be enabled. See: https://kubernetes.io/docs/concepts/services-networking/network-policies/#policy-types |
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

## Network Security

Jellyfin chart supports Kubernetes NetworkPolicy for network isolation and security hardening. NetworkPolicy allows you to control which pods can access Jellyfin (ingress) and what external connections Jellyfin can make (egress).

### Requirements

- **CNI Plugin**: NetworkPolicy requires a Container Network Interface (CNI) plugin that supports NetworkPolicies, such as:
  - Calico
  - Cilium
  - Weave Net
  - Canal

  Check with your cluster administrator if NetworkPolicy is supported in your cluster.

- **DLNA Incompatibility**: NetworkPolicy cannot be enabled when `enableDLNA: true` or `podPrivileges.hostNetwork: true` is set, as pods using `hostNetwork` bypass NetworkPolicy rules. The chart will fail deployment with a clear error message if both are enabled.

### Basic Usage

By default, NetworkPolicy is disabled to maintain backward compatibility. To enable basic network isolation:

```yaml
networkPolicy:
  enabled: true
```

This will create a NetworkPolicy with the following defaults:
- **Ingress**: Allow connections from any pod in any namespace
- **Egress**: Allow DNS resolution and all internet access (required for metadata)

### Production Configuration - Restrict to Ingress Controller

For production environments, you typically want to restrict access to only allow traffic through the Ingress controller:

```yaml
networkPolicy:
  enabled: true
  ingress:
    allowExternal: false
    namespaceSelector:
      matchLabels:
        name: ingress-nginx
    podSelector:
      matchLabels:
        app.kubernetes.io/name: ingress-nginx

ingress:
  enabled: true
  className: nginx
  hosts:
    - host: jellyfin.example.com
      paths:
        - path: /
          pathType: Prefix
```

### High Security Configuration - Restricted Egress

For security-conscious deployments that need to limit outbound connections:

```yaml
networkPolicy:
  enabled: true
  ingress:
    allowExternal: false
    podSelector:
      matchLabels:
        jellyfin-client: "true"  # Only pods with this label can access
  egress:
    allowDNS: true  # Always needed
    allowAllEgress: false  # Block unrestricted internet
    restrictedEgress:
      allowMetadata: true  # Allow HTTPS/443 for metadata providers (TMDB, etc.)
      allowInCluster: false  # Block pod-to-pod communication
```

**Note**: With this configuration, Jellyfin can only:
- Resolve DNS queries
- Connect to HTTPS (port 443) endpoints for metadata providers
- Cannot connect to other pods in the cluster
- Cannot access non-HTTPS services

### Monitoring Integration

If you're using Prometheus for monitoring, the chart automatically allows ingress from Prometheus pods when metrics are enabled:

```yaml
networkPolicy:
  enabled: true
metrics:
  enabled: true
  serviceMonitor:
    enabled: true
```

By default, the chart allows ingress from pods with label `app.kubernetes.io/name: prometheus`. If your Prometheus uses different labels, customize the selector:

```yaml
networkPolicy:
  enabled: true
  metrics:
    namespace: monitoring  # If Prometheus is in a different namespace
    podSelector:
      app: my-prometheus
```

### Advanced Configuration

#### Multiple Namespaces Access

Allow access from multiple namespaces using custom rules:

```yaml
networkPolicy:
  enabled: true
  ingress:
    allowExternal: false
    customRules:
      # Frontend namespace
      - from:
          - namespaceSelector:
              matchLabels:
                name: frontend
            podSelector:
              matchLabels:
                access-jellyfin: "true"
        ports:
          - protocol: TCP
            port: 8096

      # Admin tools namespace
      - from:
          - namespaceSelector:
              matchLabels:
                name: admin-tools
        ports:
          - protocol: TCP
            port: 8096
```

#### Custom Egress Rules

Allow connections to specific external services:

```yaml
networkPolicy:
  enabled: true
  egress:
    allowAllEgress: false
    restrictedEgress:
      allowMetadata: true
      allowedCIDRs:
        - 10.0.0.0/8  # Internal network
        - 192.168.0.0/16  # Another internal network
    customRules:
      # Allow connection to external database
      - to:
          - ipBlock:
              cidr: 203.0.113.0/24
        ports:
          - protocol: TCP
            port: 5432
```

### Security Considerations

1. **Metadata Providers**: Jellyfin requires internet access to download metadata (movie posters, descriptions, etc.) from:
   - TheMovieDB (api.themoviedb.org)
   - TheTVDB (api.thetvdb.com)
   - OpenSubtitles (api.opensubtitles.com)
   - Fanart.tv (fanart.tv)

   If you use `restrictedEgress.allowMetadata: true`, these will work as they all use HTTPS (port 443).

2. **DNS Access**: DNS resolution is critical for Jellyfin operation. The chart prevents accidental DNS blocking by defaulting `allowDNS: true`.

3. **Local Metadata**: If you want to completely block internet access, you can use local metadata (NFO files and local images). This requires manual setup and is not the default Jellyfin behavior.

4. **Testing**: Always test NetworkPolicy changes in a development environment first. Misconfigured policies can block legitimate traffic.

### NetworkPolicy Troubleshooting

**Jellyfin can't download metadata/images:**
- Check that `egress.allowAllEgress: true` or `restrictedEgress.allowMetadata: true` is set
- Verify DNS egress is allowed: `egress.allowDNS: true`

**Can't access Jellyfin web interface:**
- Verify ingress rules allow traffic from your access point (Ingress controller, LoadBalancer, etc.)
- Check NOTES.txt after deployment for detailed NetworkPolicy status

**Prometheus can't scrape metrics:**
- Ensure `metrics.enabled: true` and `metrics.serviceMonitor.enabled: true`
- Verify `networkPolicy.metrics.podSelector` matches your Prometheus labels
- Set `networkPolicy.metrics.namespace` if Prometheus is in a different namespace

**Deployment fails with "NetworkPolicy cannot be enabled...":**
- You have both `networkPolicy.enabled: true` and `hostNetwork: true` (or `enableDLNA: true`)
- NetworkPolicy doesn't work with host networking
- Either disable NetworkPolicy or disable host networking

For more configuration options, see the full values documentation in [values.yaml](values.yaml).
## Troubleshooting

### inotify Instance Limit Reached

**Problem:** Jellyfin crashes with error:

```text
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
