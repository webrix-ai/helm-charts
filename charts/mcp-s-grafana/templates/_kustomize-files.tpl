{{- define "hlmfk-0-0-5d80547625.kustomizeFiles" }}
manifests:
  - metadata:
      folder: base
      filePath: base/kustomization.yaml
    spec:
      apiVersion: kustomize.config.k8s.io/v1beta1
      kind: Kustomization
      resources:
        - deployment.yaml
        - service.yaml
      configMapGenerator:
        - name: mcp-s-grafana-container-vars
          envs:
            - container.env
      images:
        - name: mcp/grafana
          newTag: latest
  - metadata:
      folder: overlays/dev
      filePath: overlays/dev/kustomization.yaml
    spec:
      apiVersion: kustomize.config.k8s.io/v1beta1
      kind: Kustomization
      resources:
        - ../../base
      namespace: webrix-mcp-s-dev
      namePrefix: dev-
      configMapGenerator:
        - name: mcp-s-grafana-container-vars
          envs:
            - container.env
            - environment-values.env
          behavior: replace
      images:
        - name: mcp/grafana
          newTag: latest
  - metadata:
      folder: overlays/on-prem
      filePath: overlays/on-prem/kustomization.yaml
    spec:
      apiVersion: kustomize.config.k8s.io/v1beta1
      kind: Kustomization
      resources:
        - ../../base
      namespace: webrix-mcp-s
      namePrefix: on-prem-
      configMapGenerator:
        - name: mcp-s-grafana-container-vars
          envs:
            - container.env
            - environment-values.env
          behavior: replace
      images:
        - name: mcp/grafana
          newTag: latest
  - metadata:
      folder: overlays/prod
      filePath: overlays/prod/kustomization.yaml
    spec:
      apiVersion: kustomize.config.k8s.io/v1beta1
      kind: Kustomization
      resources:
        - ../../base
      namespace: webrix-mcp-s-prod
      namePrefix: prod-
      configMapGenerator:
        - name: mcp-s-grafana-container-vars
          envs:
            - container.env
            - environment-values.env
          behavior: replace
      images:
        - name: mcp/grafana
          newTag: latest
{{- end }}