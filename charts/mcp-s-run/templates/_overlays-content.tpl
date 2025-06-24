{{- define "fdsxtuuzdd.yamls" }}
{{- if .Values.overlay }}
{{- if eq .Values.overlay "overlays/on-prem" }}
manifests:
  - spec: 
      apiVersion: v1
      data:
        AUTH_SECRET: {{ .Values.AUTH_SECRET  | quote }}
        DB_SERVICE_URL: {{ .Values.DB_SERVICE_URL  | quote }}
        PORT: {{ .Values.PORT  | quote }}
      kind: ConfigMap
      metadata:
        labels:
          app: mcp-s-run
          app.kubernetes.io/version: ""
        name: mcp-s-run-container-vars
        namespace: webrix
  - spec: 
      apiVersion: v1
      kind: ConfigMap
      metadata:
        labels:
          app: mcp-s-run
          app.kubernetes.io/version: ""
        name: mcp-s-run-environment-values
        namespace: webrix
  - spec: 
      apiVersion: v1
      kind: Service
      metadata:
        labels:
          app: mcp-s-run
          app.kubernetes.io/version: ""
        name: mcp-s-run
        namespace: webrix
      spec:
        ports:
        - port: 80
          protocol: TCP
          targetPort: 3000
        selector:
          app: mcp-s-run
  - spec: 
      apiVersion: apps/v1
      kind: Deployment
      metadata:
        labels:
          app: mcp-s-run
          app.kubernetes.io/version: ""
        name: mcp-s-run
        namespace: webrix
      spec:
        replicas: 1
        selector:
          matchLabels:
            app: mcp-s-run
        template:
          metadata:
            labels:
              app: mcp-s-run
          spec:
            containers:
            - envFrom:
              - configMapRef:
                  name: mcp-s-run-container-vars
              image: quay.io/idan-chetrit/run:latest
              name: mcp-s-run
              ports:
              - containerPort: 3000
              resources:
                limits:
                  cpu: 1000m
                  memory: 2048Mi
                requests:
                  cpu: 100m
                  memory: 200Mi
{{- if .Values.sidecars.grafana.enabled }}
            - name: grafana-mcp
              image: {{ .Values.sidecars.grafana.image | quote }}
              ports:
              - containerPort: {{ .Values.sidecars.grafana.port }}
              env:
              - name: GRAFANA_URL
                value: {{ .Values.sidecars.grafana.env.GRAFANA_URL | quote }}
              - name: GRAFANA_API_KEY
                value: {{ .Values.sidecars.grafana.env.GRAFANA_API_KEY | quote }}
              resources:
                requests:
                  cpu: {{ .Values.sidecars.grafana.resources.requests.cpu | quote }}
                  memory: {{ .Values.sidecars.grafana.resources.requests.memory | quote }}
                limits:
                  cpu: {{ .Values.sidecars.grafana.resources.limits.cpu | quote }}
                  memory: {{ .Values.sidecars.grafana.resources.limits.memory | quote }}
{{- end }}
{{- else}}
{{- end }}
{{- else }}
manifests: []
{{- end }}{{- end }}
