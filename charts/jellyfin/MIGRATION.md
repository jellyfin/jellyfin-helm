# Migration Guide

## v1.x to v2.x

### General

1. The `enableDLNA` key has been moved from the top level to the `jellyfin` subkey.
2. Some renames have occurred to align with the standard:
```yaml
extraPodLabels -> podLabels
extraPodAnnotations -> podAnnotations
```
3. The `extraEnvVars` key has been moved and renamed to `jellyfin.env`.
4. `extraVolumes` has been moved to `volumes`, and `extraVolumeMounts` has been moved to `volumeMounts`.
5. The `extraExistingClaimMounts` key has been removed, as it can now be represented with `volumes` and `volumeMounts`.

### Service

1. The `name` field has been renamed to `portName` for consistency.
2. The following fields have been added:
```yaml
# -- Configure dual-stack IP family policy. See: https://kubernetes.io/docs/concepts/services-networking/dual-stack/
ipFamilyPolicy: ""
# -- Supported IP families (IPv4, IPv6).
ipFamilies: []
# -- Class of the LoadBalancer.
loadBalancerClass: ""
# -- External traffic policy (Cluster or Local).
# externalTrafficPolicy: Cluster
```

### Ingress

1. The `className` field has been added for ingress class, as annotations are deprecated.
2. The `path` field has been moved under the `hosts` key to better represent the actual CRD, providing more fine-grained control.
3. The `labels` field has been added for additional labels.

### Persistence

PVC creation is now enabled by default to prevent data loss when the chart is used without a specific configuration.

### Probes

The liveness and readiness probes are now always enabled to ensure proper Kubernetes lifecycle management. Adjust the values accordingly if you have a large library.