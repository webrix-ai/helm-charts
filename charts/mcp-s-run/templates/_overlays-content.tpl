{{- define "yvdafnmbea.yamls" }}
{{- if .Values.overlay }}
{{- if eq .Values.overlay "overlays/on-prem" }}
manifests:
  - spec: 
      apiVersion: v1
      data:
        AUTH_SECRET: {{ .Values.AUTH_SECRET }}
        DB_SERVICE_URL: {{ .Values.DB_SERVICE_URL }}
        PORT: {{ .Values.PORT }}
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
              image: 992382826040.dkr.ecr.us-east-2.amazonaws.com/mcp-s-run:latest
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
{{- else}}
{{- end }}
{{- else }}
manifests: []
{{- end }}{{- end }}