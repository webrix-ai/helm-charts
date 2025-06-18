{{/*
Create a default fullname using release name and chart name
*/}}
{{- define "webrix.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else if .Values.nameOverride }}
{{- printf "%s-%s" .Release.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name .Chart.Name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "webrix.labels" -}}
helm.sh/chart: {{ .Chart.Name }}-{{ .Chart.Version | replace "+" "_" }}
app.kubernetes.io/name: {{ .Chart.Name }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/version: {{ .Chart.AppVersion }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}


{{/*
Render an ingress block from a passed ingress definition
Usage:
{{ include "webrix.ingress" (dict "ingress" $ingress "context" $) }}
*/}}

{{- define "webrix.ingress" -}}
{{- $ := .context -}}
{{- $ingress := .ingress -}}
{{- if $ingress.enabled }}
---
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: {{ include "webrix.fullname" $ }}-{{ $ingress.name }}
  labels:
    {{- include "webrix.labels" $ | nindent 4 }}
  annotations:
    {{- range $key, $value := $ingress.annotations }}
    {{ $key }}: {{ $value | quote }}
    {{- end }}
spec:
  {{- if $ingress.className }}
  ingressClassName: {{ $ingress.className }}
  {{- end }}
  rules:
    {{- range $ingress.hosts }}
    - host: {{.subdomain }}{{ .host | default $.Values.host}}
      http:
        paths:
          {{- range .paths }}
          - path: {{ .path }}
            pathType: {{ .pathType }}
            backend:
              service:
                name: {{ include "webrix.fullname" $ }}
                port:
                  number: {{ .port | default 80 }}
          {{- end }}
    {{- end }}
  {{- if $ingress.tls }}
  tls:
    {{- range $ingress.tls }}
    - hosts:
        {{- range .hosts }}
        - {{ . }}
        {{- end }}
      secretName: {{ .secretName }}
    {{- end }}
  {{- end }}
{{- end }}
{{- end }}

