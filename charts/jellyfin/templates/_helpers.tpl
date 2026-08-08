{{/*
Fail if command and metrics are set
*/}}
{{- if and .Values.image.command .Values.metrics.enabled }}
{{- fail "Can't use custom command and metrics in combination. They are exclusive features" }}
{{- end }}

{{/*
Expand the name of the chart.
*/}}
{{- define "jellyfin.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "jellyfin.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "jellyfin.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create the image path for the .Values.image field
Source: https://blog.andyserver.com/2021/09/adding-image-digest-references-to-your-helm-charts/
*/}}
{{- define "jellyfin.image" -}}
{{- if and .Values.image.registry .Values.image.repository ( or .Values.image.version .Chart.AppVersion ) -}}
    {{- if eq (substr 0 7 .Values.image.version) "sha256:" -}}
    {{- printf "%s/%s@%s" .Values.image.registry .Values.image.repository .Values.image.version -}}
    {{- else -}}
    {{- printf "%s/%s:%s" .Values.image.registry .Values.image.repository ( .Values.image.version | default .Chart.AppVersion ) -}}
    {{- end -}}
{{- else -}}
    {{- printf "%s:%s" .Values.image.repository ( .Values.image.tag | default .Chart.AppVersion ) -}}
{{- end -}}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "jellyfin.labels" -}}
helm.sh/chart: {{ include "jellyfin.chart" . }}
{{ include "jellyfin.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "jellyfin.selectorLabels" -}}
app.kubernetes.io/name: {{ include "jellyfin.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "jellyfin.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "jellyfin.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}
