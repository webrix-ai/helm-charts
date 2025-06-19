{{- define "xucznadvvl.yamls" }}
{{- if .Values.overlay }}
{{- if eq .Values.overlay "overlays/on-prem" }}
manifests:
  - spec: 
      apiVersion: v1
      data:
        AUTH_SECRET: {{ .Values.AUTH_SECRET  | quote }}
        AUTO_AUTHENTICATE_TOKEN: {{ .Values.AUTO_AUTHENTICATE_TOKEN  | quote }}
        CONNECT_URL: {{ .Values.CONNECT_URL  | quote }}
        DATABASE_URL: {{ .Values.DATABASE_URL  | quote }}
        DEBUG_QUERIES: {{ .Values.DEBUG_QUERIES  | quote }}
        ENCRYPTION_KEY: {{ .Values.ENCRYPTION_KEY  | quote }}
        ON_PREM: {{ .Values.ON_PREM  | quote }}
        PORT: {{ .Values.PORT  | quote }}
        POSTGRES_HOST_AUTH_METHOD: {{ .Values.POSTGRES_HOST_AUTH_METHOD  | quote }}
        RATE_LIMIT_MAX: {{ .Values.RATE_LIMIT_MAX  | quote }}
        RATE_LIMIT_WINDOW: {{ .Values.RATE_LIMIT_WINDOW  | quote }}
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
              image: 992382826040.dkr.ecr.us-east-2.amazonaws.com/mcp-s-db-service:latest
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
