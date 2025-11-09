# Jellyfin Helm Chart Examples

This directory contains example configurations for common Jellyfin deployment scenarios.

## Available Examples

### 1. Minimal (`minimal.yaml`)

Quick start configuration with ephemeral storage for testing purposes.

```bash
helm install jellyfin jellyfin/jellyfin -f examples/minimal.yaml
```

**Use case**: Development, testing, demo environments.

**Note**: All data will be lost when the pod is restarted.

---

### 2. Production (`production.yaml`)

Production-ready configuration with persistent storage, resource limits, and optimized health probes.

```bash
helm install jellyfin jellyfin/jellyfin -f examples/production.yaml
```

**Features**:

- Persistent storage for config, media, and cache
- Resource requests and limits
- Optimized health probes for large libraries
- Security context with non-root user

---

### 3. Hardware Acceleration (`hardware-acceleration.yaml`)

Enable GPU acceleration for video transcoding (Intel QuickSync example).

```bash
helm install jellyfin jellyfin/jellyfin -f examples/hardware-acceleration.yaml
```

**Prerequisites**:

- Node with compatible GPU (Intel/AMD/NVIDIA)
- GPU device plugin installed in cluster
- Appropriate node labels/taints

**Note**: Adjust device paths and capabilities for your specific GPU type. See [Jellyfin documentation](https://jellyfin.org/docs/general/administration/hardware-acceleration/) for details.

---

### 4. Ingress with TLS (`ingress-tls.yaml`)

External access via HTTPS with automatic certificate management.

```bash
helm install jellyfin jellyfin/jellyfin -f examples/ingress-tls.yaml
```

**Prerequisites**:

- Ingress controller (e.g., ingress-nginx)
- cert-manager for automatic TLS certificates (optional)
- DNS record pointing to your cluster

**Configuration**:

- Update `jellyfin.example.com` to your actual domain
- Adjust cert-manager issuer if using different CA

---

### 5. NetworkPolicy Security (`network-policy.yaml`)

Secure deployment with network isolation and controlled traffic flow.

```bash
helm install jellyfin jellyfin/jellyfin -f examples/network-policy.yaml
```

**Prerequisites**:

- CNI plugin with NetworkPolicy support (Calico, Cilium, Weave, Canal)
- Ingress controller with known namespace/labels

**Features**:

- Restrict ingress to Ingress controller only
- Allow egress for DNS and metadata providers (HTTPS/443)
- Block unrestricted pod-to-pod communication

---

## Combining Examples

You can combine multiple example files to create custom configurations:

```bash
helm install jellyfin jellyfin/jellyfin \
  -f examples/production.yaml \
  -f examples/hardware-acceleration.yaml \
  -f examples/ingress-tls.yaml
```

Files are merged in order, with later files overriding earlier ones.

## Custom Values

All examples can be further customized by overriding specific values:

```bash
helm install jellyfin jellyfin/jellyfin \
  -f examples/production.yaml \
  --set persistence.media.size=1Ti \
  --set resources.limits.memory=16Gi
```

## Getting Help

For more configuration options, see:

- [Chart README](../README.md)
- [values.yaml](../values.yaml) - Complete configuration reference
- [Jellyfin Documentation](https://jellyfin.org/docs/)
