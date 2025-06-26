{{- define "hlmfk-0-0-6ca340c284.yamls" }}
{{- if .Values.overlay }}
{{- if eq .Values.overlay "overlays/on-prem" }}
manifests:
  - spec: 
      apiVersion: v1
      data:
        AUTH_SECRET: {{ if kindIs "string" .Values.env.AUTH_SECRET }}{{ .Values.env.AUTH_SECRET | quote }}{{ else }}{{ .Values.env.AUTH_SECRET }}{{ end }}
        AUTO_AUTHENTICATE_TOKEN: {{ if kindIs "string" .Values.env.AUTO_AUTHENTICATE_TOKEN }}{{ .Values.env.AUTO_AUTHENTICATE_TOKEN | quote }}{{ else }}{{ .Values.env.AUTO_AUTHENTICATE_TOKEN }}{{ end }}
        CONNECT_URL: {{ if kindIs "string" .Values.env.CONNECT_URL }}{{ .Values.env.CONNECT_URL | quote }}{{ else }}{{ .Values.env.CONNECT_URL }}{{ end }}
        DATABASE_URL: {{ if kindIs "string" .Values.env.DATABASE_URL }}{{ .Values.env.DATABASE_URL | quote }}{{ else }}{{ .Values.env.DATABASE_URL }}{{ end }}
        DEBUG_QUERIES: {{ if kindIs "string" .Values.env.DEBUG_QUERIES }}{{ .Values.env.DEBUG_QUERIES | quote }}{{ else }}{{ .Values.env.DEBUG_QUERIES }}{{ end }}
        ENCRYPTION_KEY: {{ if kindIs "string" .Values.env.ENCRYPTION_KEY }}{{ .Values.env.ENCRYPTION_KEY | quote }}{{ else }}{{ .Values.env.ENCRYPTION_KEY }}{{ end }}
        ON_PREM: {{ if kindIs "string" .Values.env.ON_PREM }}{{ .Values.env.ON_PREM | quote }}{{ else }}{{ .Values.env.ON_PREM }}{{ end }}
        PORT: {{ if kindIs "string" .Values.env.PORT }}{{ .Values.env.PORT | quote }}{{ else }}{{ .Values.env.PORT }}{{ end }}
        POSTGRES_HOST_AUTH_METHOD: {{ if kindIs "string" .Values.env.POSTGRES_HOST_AUTH_METHOD }}{{ .Values.env.POSTGRES_HOST_AUTH_METHOD | quote }}{{ else }}{{ .Values.env.POSTGRES_HOST_AUTH_METHOD }}{{ end }}
        RATE_LIMIT_MAX: {{ if kindIs "string" .Values.env.RATE_LIMIT_MAX }}{{ .Values.env.RATE_LIMIT_MAX | quote }}{{ else }}{{ .Values.env.RATE_LIMIT_MAX }}{{ end }}
        RATE_LIMIT_WINDOW: {{ if kindIs "string" .Values.env.RATE_LIMIT_WINDOW }}{{ .Values.env.RATE_LIMIT_WINDOW | quote }}{{ else }}{{ .Values.env.RATE_LIMIT_WINDOW }}{{ end }}
      kind: ConfigMap
      metadata:
        labels:
          app: mcp-s-db-service
          app.kubernetes.io/version: ""
        name: mcp-s-db-service-container-vars
        namespace: webrix
  - spec: 
      apiVersion: v1
      kind: ConfigMap
      metadata:
        labels:
          app: mcp-s-db-service
          app.kubernetes.io/version: ""
        name: mcp-s-db-service-environment-values
        namespace: webrix
  - spec: 
      apiVersion: v1
      kind: Service
      metadata:
        labels:
          app: mcp-s-db-service
          app.kubernetes.io/version: ""
        name: mcp-s-db-service
        namespace: webrix
      spec:
        ports:
        - port: 80
          protocol: TCP
          targetPort: 3000
        selector:
          app: mcp-s-db-service
  - spec: 
      apiVersion: apps/v1
      kind: Deployment
      metadata:
        labels:
          app: mcp-s-db-service
          app.kubernetes.io/version: ""
        name: mcp-s-db-service
        namespace: webrix
      spec:
        replicas: 1
        selector:
          matchLabels:
            app: mcp-s-db-service
        template:
          metadata:
            labels:
              app: mcp-s-db-service
          spec:
            containers:
            - envFrom:
              - configMapRef:
                  name: mcp-s-db-service-container-vars
              image: quay.io/idan-chetrit/db-service:latest
              name: mcp-s-db-service
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