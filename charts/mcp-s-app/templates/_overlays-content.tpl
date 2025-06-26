{{- define "hlmfk-0-0-7baf95b9f1.yamls" }}
{{- if .Values.overlay }}
{{- if eq .Values.overlay "overlays/on-prem" }}
manifests:
  - spec: 
      apiVersion: v1
      data:
        AUTH_SECRET: {{ if kindIs "string" .Values.env.AUTH_SECRET }}{{ .Values.env.AUTH_SECRET | quote }}{{ else }}{{ .Values.env.AUTH_SECRET }}{{ end }}
        DB_AUTH_SECRET: {{ if kindIs "string" .Values.env.DB_AUTH_SECRET }}{{ .Values.env.DB_AUTH_SECRET | quote }}{{ else }}{{ .Values.env.DB_AUTH_SECRET }}{{ end }}
        DB_BASE_URL: {{ if kindIs "string" .Values.env.DB_BASE_URL }}{{ .Values.env.DB_BASE_URL | quote }}{{ else }}{{ .Values.env.DB_BASE_URL }}{{ end }}
        NEXT_PUBLIC_CONNECT_URL: {{ if kindIs "string" .Values.env.NEXT_PUBLIC_CONNECT_URL }}{{ .Values.env.NEXT_PUBLIC_CONNECT_URL | quote }}{{ else }}{{ .Values.env.NEXT_PUBLIC_CONNECT_URL }}{{ end }}
        NEXTAUTH_DEBUG: {{ if kindIs "string" .Values.env.NEXTAUTH_DEBUG }}{{ .Values.env.NEXTAUTH_DEBUG | quote }}{{ else }}{{ .Values.env.NEXTAUTH_DEBUG }}{{ end }}
        NEXTAUTH_SECRET: {{ if kindIs "string" .Values.env.NEXTAUTH_SECRET }}{{ .Values.env.NEXTAUTH_SECRET | quote }}{{ else }}{{ .Values.env.NEXTAUTH_SECRET }}{{ end }}
        NEXTAUTH_URL: {{ if kindIs "string" .Values.env.NEXTAUTH_URL }}{{ .Values.env.NEXTAUTH_URL | quote }}{{ else }}{{ .Values.env.NEXTAUTH_URL }}{{ end }}
        ON_PREM: {{ if kindIs "string" .Values.env.ON_PREM }}{{ .Values.env.ON_PREM | quote }}{{ else }}{{ .Values.env.ON_PREM }}{{ end }}
        PORT: {{ if kindIs "string" .Values.env.PORT }}{{ .Values.env.PORT | quote }}{{ else }}{{ .Values.env.PORT }}{{ end }}
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
              image: quay.io/idan-chetrit/mcp-s-app:latest
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