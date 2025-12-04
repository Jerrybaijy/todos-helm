{{- define "todo-chart.name" }}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "todo-chart.chart" }}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "todo-chart.fullname" }}
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

{{- define "todo-chart.mysql.fullname" }}
{{- printf "%s-mysql" (include "todo-chart.fullname" .) | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "todo-chart.backend.fullname" }}
{{- printf "%s-backend" (include "todo-chart.fullname" .) | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "todo-chart.frontend.fullname" }}
{{- printf "%s-frontend" (include "todo-chart.fullname" .) | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "todo-chart.labels" }}
helm.sh/chart: {{ include "todo-chart.chart" . }}
helm.sh/version: {{ .Chart.Version | quote }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- if .Values.commonLabels }}
{{- toYaml .Values.commonLabels | nindent 2 }}
{{- end }}
{{- end }}

{{- define "todo-chart.mysql.labels" }}
{{- include "todo-chart.labels" . }}
app.kubernetes.io/name: {{ include "todo-chart.name" . }}-mysql
app.kubernetes.io/component: mysql
{{- end }}

{{- define "todo-chart.mysql.selectorLabels" }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/name: {{ include "todo-chart.name" . }}-mysql
app.kubernetes.io/component: mysql
{{- end }}

{{- define "todo-chart.backend.labels" }}
{{- include "todo-chart.labels" . }}
app.kubernetes.io/name: {{ include "todo-chart.name" . }}-backend
app.kubernetes.io/component: backend
{{- end }}

{{- define "todo-chart.backend.selectorLabels" }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/name: {{ include "todo-chart.name" . }}-backend
app.kubernetes.io/component: backend
{{- end }}

{{- define "todo-chart.frontend.labels" }}
{{- include "todo-chart.labels" . }}
app.kubernetes.io/name: {{ include "todo-chart.name" . }}-frontend
app.kubernetes.io/component: frontend
{{- end }}

{{- define "todo-chart.frontend.selectorLabels" }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/name: {{ include "todo-chart.name" . }}-frontend
app.kubernetes.io/component: frontend
{{- end }}
