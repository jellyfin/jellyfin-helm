# Jellyfin Helm Charts Repository

This repository contains Helm charts for the jellyfin project.

## Repository Structure

Each Helm chart is stored in its own directory. Each chart follows the standard Helm chart structure:

```plaintext
jellyfin-helm/
├── jellyfin/
│   ├── Chart.yaml
│   ├── values.yaml
│   ├── templates/
│   └── ...
├── chart2/
│   ├── Chart.yaml
│   ├── values.yaml
│   ├── templates/
│   └── ...
└── ...
```

- `Chart.yaml`: Contains metadata about the chart (name, version, app version, etc.).
- `values.yaml`: Default configuration values for the chart.
- `templates/`: The Kubernetes resource templates (YAML files) that Helm uses to deploy the chart.

## How to Use the Charts

### 1. Add this Repository

To use the charts in this repository, first add the repository to Helm:

```bash
helm repo add jellyfin https://jellyfin.github.io/jellyfin-helm
helm repo update
```

### 2. Install a Chart

To install a chart from this repository, use the following command:

```bash
helm install <release-name> jellyfin/<chart-name>
```

### 3. Customize Installation

You can customize the installation by passing in custom values via the `--set` flag or by using a `values.yaml` file:

```bash
helm install <release-name> jellyfin/<chart-name> --set key=value
```

or

```bash
helm install <release-name> jellyfin/<chart-name> -f custom-values.yaml
```

## Contributing

Feel free to contribute to this repository by:

- Submitting new charts.
- Fixing bugs or issues.
- Improving documentation.

To contribute, fork this repository, create a new branch, and submit a pull request with your changes.

## License

This repository is licensed under the MIT License. See the [LICENSE](LICENSE) file for more details.
