{{- define "wcjsssejxg.yamls" }}
{{- if .Values.overlay }}
{{- if eq .Values.overlay "overlays/on-prem" }}
manifests:
  - spec: 
      apiVersion: v1
      data:
        AUTH_SECRET: {{ .Values.AUTH_SECRET  | quote }}
        AUTO_AUTHENTICATE_TOKEN: {{ .Values.AUTO_AUTHENTICATE_TOKEN  | quote }}
        DB_AUTH_SECRET: {{ .Values.DB_AUTH_SECRET  | quote }}
        DB_BASE_URL: {{ .Values.DB_BASE_URL  | quote }}
        DEBUG: {{ .Values.DEBUG  | quote }}
        NEXTAUTH_URL: {{ .Values.NEXTAUTH_URL  | quote }}
        ON_PREM: {{ .Values.ON_PREM  | quote }}
        PORT: {{ .Values.PORT  | quote }}
      kind: ConfigMap
      metadata:
        labels:
          app: mcp-s-connect
          app.kubernetes.io/version: ""
        name: mcp-s-connect-container-vars
        namespace: webrix
  - spec: 
      apiVersion: v1
      kind: ConfigMap
      metadata:
        labels:
          app: mcp-s-connect
          app.kubernetes.io/version: ""
        name: mcp-s-connect-environment-values
        namespace: webrix
  - spec: 
      apiVersion: v1
      kind: Service
      metadata:
        labels:
          app: mcp-s-connect
          app.kubernetes.io/version: ""
        name: mcp-s-connect
        namespace: webrix
      spec:
        ports:
        - port: 80
          protocol: TCP
          targetPort: 3000
        selector:
          app: mcp-s-connect
  - spec: 
      apiVersion: apps/v1
      kind: Deployment
      metadata:
        labels:
          app: mcp-s-connect
          app.kubernetes.io/version: ""
        name: mcp-s-connect
        namespace: webrix
      spec:
        replicas: 1
        selector:
          matchLabels:
            app: mcp-s-connect
        template:
          metadata:
            labels:
              app: mcp-s-connect
          spec:
            containers:
            - envFrom:
              - configMapRef:
                  name: mcp-s-connect-container-vars
              image: 992382826040.dkr.ecr.us-east-2.amazonaws.com/mcp-s-connect:latest
              name: mcp-s-connect
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
