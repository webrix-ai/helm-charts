{{- define "gwnuepxrco.yamls" }}
{{- if .Values.overlay }}
{{- if eq .Values.overlay "overlays/on-prem" }}
manifests:
  - spec: 
      apiVersion: v1
      data:
        PORT: {{ .Values.PORT  | quote }}
        GRAFANA_URL: {{ .Values.GRAFANA_URL  | quote }}
        GRAFANA_API_KEY: {{ .Values.GRAFANA_API_KEY  | quote }}
      kind: ConfigMap
      metadata:
        labels:
          app: mcp-s-grafana
          app.kubernetes.io/version: ""
        name: mcp-s-grafana-container-vars
        namespace: webrix
  - spec: 
      apiVersion: v1
      kind: ConfigMap
      metadata:
        labels:
          app: mcp-s-grafana
          app.kubernetes.io/version: ""
        name: mcp-s-grafana-environment-values
        namespace: webrix
  - spec: 
      apiVersion: v1
      kind: Service
      metadata:
        labels:
          app: mcp-s-grafana
          app.kubernetes.io/version: ""
        name: mcp-s-grafana
        namespace: webrix
      spec:
        ports:
        - port: 80
          protocol: TCP
          targetPort: 3000
        selector:
          app: mcp-s-grafana
  - spec: 
      apiVersion: apps/v1
      kind: Deployment
      metadata:
        labels:
          app: mcp-s-grafana
          app.kubernetes.io/version: ""
        name: mcp-s-grafana
        namespace: webrix
      spec:
        replicas: 1
        selector:
          matchLabels:
            app: mcp-s-grafana
        template:
          metadata:
            labels:
              app: mcp-s-grafana
          spec:
            containers:
            - envFrom:
              - configMapRef:
                  name: mcp-s-grafana-container-vars
              image: mcp/grafana
              name: mcp-s-grafana
              ports:
              - containerPort: 3000
              resources:
                limits:
                  cpu: 1000m
                  memory: 2048Mi
                requests:
                  cpu: 100m
                  memory: 200Mi
{{- else}}
{{- end }}
{{- else }}
manifests: []
{{- end }}{{- end }}
