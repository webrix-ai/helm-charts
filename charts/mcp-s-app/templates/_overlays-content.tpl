{{- define "rkgxvrmvlu.yamls" }}
{{- if .Values.overlay }}
{{- if eq .Values.overlay "overlays/on-prem" }}
manifests:
  - spec: 
      apiVersion: v1
      data:
        AUTH_SECRET: {{ .Values.AUTH_SECRET }}
        DB_AUTH_SECRET: {{ .Values.DB_AUTH_SECRET }}
        DB_BASE_URL: {{ .Values.DB_BASE_URL }}
        NEXT_PUBLIC_CONNECT_URL: {{ .Values.NEXT_PUBLIC_CONNECT_URL }}
        NEXTAUTH_DEBUG: {{ .Values.NEXTAUTH_DEBUG }}
        NEXTAUTH_SECRET: {{ .Values.NEXTAUTH_SECRET }}
        NEXTAUTH_URL: {{ .Values.NEXTAUTH_URL }}
        ON_PREM: {{ .Values.ON_PREM }}
        PORT: {{ .Values.PORT }}
      kind: ConfigMap
      metadata:
        labels:
          app: mcp-s-app
          app.kubernetes.io/version: ""
        name: mcp-s-app-container-vars
        namespace: webrix
  - spec: 
      apiVersion: v1
      kind: ConfigMap
      metadata:
        labels:
          app: mcp-s-app
          app.kubernetes.io/version: ""
        name: mcp-s-app-environment-values
        namespace: webrix
  - spec: 
      apiVersion: v1
      kind: Service
      metadata:
        labels:
          app: mcp-s-app
          app.kubernetes.io/version: ""
        name: mcp-s-app
        namespace: webrix
      spec:
        ports:
        - port: 80
          protocol: TCP
          targetPort: 3000
        selector:
          app: mcp-s-app
  - spec: 
      apiVersion: apps/v1
      kind: Deployment
      metadata:
        labels:
          app: mcp-s-app
          app.kubernetes.io/version: ""
        name: mcp-s-app
        namespace: webrix
      spec:
        replicas: 1
        selector:
          matchLabels:
            app: mcp-s-app
        template:
          metadata:
            labels:
              app: mcp-s-app
          spec:
            containers:
            - envFrom:
              - configMapRef:
                  name: mcp-s-app-container-vars
              image: 992382826040.dkr.ecr.us-east-2.amazonaws.com/mcp-s-app:latest
              name: mcp-s-app
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