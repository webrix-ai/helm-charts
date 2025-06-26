{{- define "hlmfk-0-0-9f44ad13fd.yamls" }}
{{- if .Values.overlay }}
{{- if eq .Values.overlay "overlays/on-prem" }}
manifests:
  - spec: 
      apiVersion: v1
      data:
        AUTH_SECRET: {{ if kindIs "string" .Values.env.AUTH_SECRET }}{{ .Values.env.AUTH_SECRET | quote }}{{ else }}{{ .Values.env.AUTH_SECRET }}{{ end }}
        AUTO_AUTHENTICATE_TOKEN: {{ if kindIs "string" .Values.env.AUTO_AUTHENTICATE_TOKEN }}{{ .Values.env.AUTO_AUTHENTICATE_TOKEN | quote }}{{ else }}{{ .Values.env.AUTO_AUTHENTICATE_TOKEN }}{{ end }}
        DB_AUTH_SECRET: {{ if kindIs "string" .Values.env.DB_AUTH_SECRET }}{{ .Values.env.DB_AUTH_SECRET | quote }}{{ else }}{{ .Values.env.DB_AUTH_SECRET }}{{ end }}
        DB_BASE_URL: {{ if kindIs "string" .Values.env.DB_BASE_URL }}{{ .Values.env.DB_BASE_URL | quote }}{{ else }}{{ .Values.env.DB_BASE_URL }}{{ end }}
        DEBUG: {{ if kindIs "string" .Values.env.DEBUG }}{{ .Values.env.DEBUG | quote }}{{ else }}{{ .Values.env.DEBUG }}{{ end }}
        NEXTAUTH_URL: {{ if kindIs "string" .Values.env.NEXTAUTH_URL }}{{ .Values.env.NEXTAUTH_URL | quote }}{{ else }}{{ .Values.env.NEXTAUTH_URL }}{{ end }}
        ON_PREM: {{ if kindIs "string" .Values.env.ON_PREM }}{{ .Values.env.ON_PREM | quote }}{{ else }}{{ .Values.env.ON_PREM }}{{ end }}
        ORG: {{ if kindIs "string" .Values.env.ORG }}{{ .Values.env.ORG | quote }}{{ else }}{{ .Values.env.ORG }}{{ end }}
        PORT: {{ if kindIs "string" .Values.env.PORT }}{{ .Values.env.PORT | quote }}{{ else }}{{ .Values.env.PORT }}{{ end }}
        RUN_URL: {{ if kindIs "string" .Values.env.RUN_URL }}{{ .Values.env.RUN_URL | quote }}{{ else }}{{ .Values.env.RUN_URL }}{{ end }}
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
              image: quay.io/idan-chetrit/mcp-s-connect:latest
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