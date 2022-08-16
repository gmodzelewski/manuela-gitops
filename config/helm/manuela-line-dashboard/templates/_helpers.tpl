{{/*
Expand the name of the chart.
*/}}
{{- define "manuela-line-dashboard.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "manuela-line-dashboard.fullname" -}}
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
{{- define "manuela-line-dashboard.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "manuela-line-dashboard.labels" -}}
helm.sh/chart: {{ include "manuela-line-dashboard.chart" . }}
application: line-dashboard
template: openjdk18-web-basic-s2i
app.kubernetes.io/part-of: ManuELA
{{ include "manuela-line-dashboard.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "manuela-line-dashboard.selectorLabels" -}}
app.kubernetes.io/name: {{ include "manuela-line-dashboard.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
deploymentconfig: line-dashboard
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "manuela-line-dashboard.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "manuela-line-dashboard.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}
