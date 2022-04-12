{{/*
Expand the name of the chart.
*/}}
{{- define "mongodb-atlas-operator.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "mongodb-atlas-operator.fullname" -}}
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
{{- define "mongodb-atlas-operator.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "mongodb-atlas-operator.labels" -}}
helm.sh/chart: {{ include "mongodb-atlas-operator.chart" . }}
{{ include "mongodb-atlas-operator.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "mongodb-atlas-operator.selectorLabels" -}}
app.kubernetes.io/name: {{ include "mongodb-atlas-operator.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "mongodb-atlas-operator.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "mongodb-atlas-operator.name" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
RBAC permissions
*/}}
{{- define "mongodb-atlas-operator.rbacRules" -}}
- apiGroups:
  - ""
  resources:
  - events
  verbs:
  - create
  - patch
- apiGroups:
  - ""
  resources:
  - secrets
  verbs:
  - create
  - delete
  - get
  - list
  - patch
  - update
  - watch
- apiGroups:
  - atlas.mongodb.com
  resources:
  - atlasclusters
  verbs:
  - create
  - delete
  - get
  - list
  - patch
  - update
  - watch
- apiGroups:
  - atlas.mongodb.com
  resources:
  - atlasclusters/status
  verbs:
  - get
  - patch
  - update
- apiGroups:
  - atlas.mongodb.com
  resources:
  - atlasdatabaseusers
  verbs:
  - create
  - delete
  - get
  - list
  - patch
  - update
  - watch
- apiGroups:
  - atlas.mongodb.com
  resources:
  - atlasdatabaseusers/status
  verbs:
  - get
  - patch
  - update
- apiGroups:
  - atlas.mongodb.com
  resources:
  - atlasprojects
  verbs:
  - create
  - delete
  - get
  - list
  - patch
  - update
  - watch
- apiGroups:
  - atlas.mongodb.com
  resources:
  - atlasprojects/finalizers
  verbs:
  - get
  - patch
  - update
- apiGroups:
  - atlas.mongodb.com
  resources:
  - atlasprojects/status
  verbs:
  - get
  - patch
  - update
- apiGroups:
  - atlas.mongodb.com
  resources:
  - atlasbackuppolicies/status
  verbs:
  - get
  - patch
  - update
- apiGroups:
  - atlas.mongodb.com
  resources:
  - atlasbackupschedules
  verbs:
  - create
  - delete
  - get
  - list
  - patch
  - update
  - watch
- apiGroups:
  - atlas.mongodb.com
  resources:
  - atlasbackupschedules/status
  verbs:
  - get
  - patch
  - update
{{- end -}}
