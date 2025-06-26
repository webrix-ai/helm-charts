{{- define "hlmfk-0-0-26fc23bef9.yamls" }}
{{- if .Values.overlay }}
{{- if eq .Values.overlay "overlays/on-prem" }}
manifests:
  - spec: 
      apiVersion: v1
      data:
        AUTH_KEYCLOAK_ID: {{ if kindIs "string" .Values.env.AUTH_KEYCLOAK_ID }}{{ .Values.env.AUTH_KEYCLOAK_ID | quote }}{{ else }}{{ .Values.env.AUTH_KEYCLOAK_ID }}{{ end }}
        AUTH_KEYCLOAK_ISSUER: {{ if kindIs "string" .Values.env.AUTH_KEYCLOAK_ISSUER }}{{ .Values.env.AUTH_KEYCLOAK_ISSUER | quote }}{{ else }}{{ .Values.env.AUTH_KEYCLOAK_ISSUER }}{{ end }}
        AUTH_KEYCLOAK_SECRET: {{ if kindIs "string" .Values.env.AUTH_KEYCLOAK_SECRET }}{{ .Values.env.AUTH_KEYCLOAK_SECRET | quote }}{{ else }}{{ .Values.env.AUTH_KEYCLOAK_SECRET }}{{ end }}
        AUTH_PROVIDER: {{ if kindIs "string" .Values.env.AUTH_PROVIDER }}{{ .Values.env.AUTH_PROVIDER | quote }}{{ else }}{{ .Values.env.AUTH_PROVIDER }}{{ end }}
        AUTH_SECRET: {{ if kindIs "string" .Values.env.AUTH_SECRET }}{{ .Values.env.AUTH_SECRET | quote }}{{ else }}{{ .Values.env.AUTH_SECRET }}{{ end }}
        CONNECT_URL: {{ if kindIs "string" .Values.env.CONNECT_URL }}{{ .Values.env.CONNECT_URL | quote }}{{ else }}{{ .Values.env.CONNECT_URL }}{{ end }}
        DB_AUTH_SECRET: {{ if kindIs "string" .Values.env.DB_AUTH_SECRET }}{{ .Values.env.DB_AUTH_SECRET | quote }}{{ else }}{{ .Values.env.DB_AUTH_SECRET }}{{ end }}
        DB_BASE_URL: {{ if kindIs "string" .Values.env.DB_BASE_URL }}{{ .Values.env.DB_BASE_URL | quote }}{{ else }}{{ .Values.env.DB_BASE_URL }}{{ end }}
        NEXTAUTH_DEBUG: {{ if kindIs "string" .Values.env.NEXTAUTH_DEBUG }}{{ .Values.env.NEXTAUTH_DEBUG | quote }}{{ else }}{{ .Values.env.NEXTAUTH_DEBUG }}{{ end }}
        NEXTAUTH_SECRET: {{ if kindIs "string" .Values.env.NEXTAUTH_SECRET }}{{ .Values.env.NEXTAUTH_SECRET | quote }}{{ else }}{{ .Values.env.NEXTAUTH_SECRET }}{{ end }}
        NEXTAUTH_URL: {{ if kindIs "string" .Values.env.NEXTAUTH_URL }}{{ .Values.env.NEXTAUTH_URL | quote }}{{ else }}{{ .Values.env.NEXTAUTH_URL }}{{ end }}
        ON_PREM: {{ if kindIs "string" .Values.env.ON_PREM }}{{ .Values.env.ON_PREM | quote }}{{ else }}{{ .Values.env.ON_PREM }}{{ end }}
        ORG: {{ if kindIs "string" .Values.env.ORG }}{{ .Values.env.ORG | quote }}{{ else }}{{ .Values.env.ORG }}{{ end }}
        PORT: {{ if kindIs "string" .Values.env.PORT }}{{ .Values.env.PORT | quote }}{{ else }}{{ .Values.env.PORT }}{{ end }}
        RUN_URL: {{ if kindIs "string" .Values.env.RUN_URL }}{{ .Values.env.RUN_URL | quote }}{{ else }}{{ .Values.env.RUN_URL }}{{ end }}
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