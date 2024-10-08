# jellyfin

![Version: 1.3.0](https://img.shields.io/badge/Version-1.3.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 10.9.11](https://img.shields.io/badge/AppVersion-10.9.11-informational?style=flat-square)

Jellyfin Media Server

**Homepage:** <https://jellyfin.org/>

## Steps to Use a Helm Chart

### 1. Add a Helm Repository

Helm repositories contain collections of charts. You can add an existing repository using the following command:

```bash
helm repo add <repo-name> <repo-url>
```

### 2. Install the Helm Chart

To install a chart, use the following command:

```bash
helm install <release-name> <repo-name>/jellyfin
```

### 3. View the Installation

You can check the status of the release using:

```bash
helm status <release-name>
```

## Customizing the Chart

Helm charts come with default values, but you can customize them by using the --set flag or by providing a custom values.yaml file.

### 1. Using --set to Override Values
```bash
helm install <release-name> <chart-name> --set key1=value1,key2=value2
```

### 2. Using a values.yaml File
You can create a custom values.yaml file and pass it to the install command:

```bash
helm install <release-name> <chart-name> -f values.yaml
```

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` |  |
| enableDLNA | bool | `false` | Setting this to true enables DLNA which requires the pod to be attached to the host network in order to be useful - this can break things like ingress to the service https://jellyfin.org/docs/general/networking/dlna.html |
| extraContainers | object | `{}` | additional sidecar containers to run inside the pod. |
| extraEnvVars | list | `[]` | aditional environment variables passed to the pod |
| extraInitContainers | object | `{}` | additional init containers to run inside the pod. |
| extraPodAnnotations | object | `{}` | additional annotations applied to the pod |
| extraPodLabels | object | `{}` | additional pod labels. Not used as a selector label. |
| extraVolumeMounts | list | `[]` | Define mount points for additional volumes. |
| extraVolumes | list | `[]` | Define additional volumes to mount to the pod. |
| fullnameOverride | string | `""` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"docker.io/jellyfin/jellyfin"` | Set cutom repository for jellyfin image |
| image.tag | string | `""` | Set jellyfin version which should be required since chart is updated with new versions automatically |
| ingress.annotations | object | `{}` |  |
| ingress.enabled | bool | `false` |  |
| ingress.hosts[0] | string | `"chart-example.local"` |  |
| ingress.labels | object | `{}` |  |
| ingress.path | string | `"/"` |  |
| ingress.tls | list | `[]` |  |
| livenessProbe | object | `{"enabled":true,"initialDelaySeconds":10}` | Larger libraries may need to increase the readinessProbe and livenessProbe timeouts. Start by increasing the initialDelaySeconds. |
| nameOverride | string | `""` |  |
| nodeSelector | object | `{}` |  |
| persistence.config.accessMode | string | `"ReadWriteOnce"` |  |
| persistence.config.annotations | object | `{}` | Custom annotations to be added to the PVC |
| persistence.config.enabled | bool | `false` |  |
| persistence.config.labels | object | `{}` | Custom labels to be added to the PVC |
| persistence.config.size | string | `"1Gi"` |  |
| persistence.config.storageClass | string | `"-"` | If undefined (the default) or set to null, no storageClassName spec is set, choosing the default provisioner. |
| persistence.extraExistingClaimMounts | list | `[]` | Add aditional PVs/PVCs to our container. Check values.yaml to see an example. |
| persistence.media.accessMode | string | `"ReadWriteOnce"` |  |
| persistence.media.annotations | object | `{}` | Custom annotations to be added to the PVC |
| persistence.media.enabled | bool | `false` |  |
| persistence.media.labels | object | `{}` | Custom labels to be added to the PVC |
| persistence.media.size | string | `"10Gi"` |  |
| persistence.media.storageClass | string | `"-"` | If undefined (the default) or set to null, no storageClassName spec is set, choosing the default provisioner. |
| podSecurityContext | object | `{}` | SecurityContext configuration for the Jellyfin pod |
| readinessProbe | object | `{"enabled":true,"initialDelaySeconds":10}` | Larger libraries may need to increase the readinessProbe and livenessProbe timeouts. Start by increasing the initialDelaySeconds. |
| replicaCount | int | `1` | Number of jellyfin replicas to start. Should be left at 1 |
| resources | object | `{}` |  |
| securityContext | object | `{}` | SecurityContext configuration for the Jellyfin container |
| service.annotations | object | `{}` |  |
| service.labels | object | `{}` |  |
| service.loadBalancerIP | string | `nil` |  |
| service.port | int | `8096` |  |
| service.type | string | `"ClusterIP"` |  |
| tolerations | list | `[]` |  |

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
