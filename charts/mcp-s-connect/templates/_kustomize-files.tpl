{{- define "hlmfk-0-0-7dfd7dcbdd.kustomizeFiles" }}
manifests:
  - metadata:
      folder: base
      filePath: base/kustomization.yaml
    spec:
      apiVersion: kustomize.config.k8s.io/v1beta1
      labels:
        - pairs:
            app: mcp-s-connect
      configMapGenerator:
        - name: mcp-s-connect-environment-values
          envs:
            - environment-values.env
        - name: mcp-s-connect-container-vars
          envs:
            - container.env
      generatorOptions:
        disableNameSuffixHash: true
      kind: Kustomization
      resources:
        - deployment.yaml
        - service.yaml
  - metadata:
      folder: overlays/dev
      filePath: overlays/dev/kustomization.yaml
    spec:
      apiVersion: kustomize.config.k8s.io/v1beta1
      configMapGenerator:
        - behavior: merge
          envs:
            - environment-values.env
          name: mcp-s-connect-environment-values
        - behavior: merge
          envs:
            - container.env
          name: mcp-s-connect-container-vars
      images:
        - name: 992382826040.dkr.ecr.us-east-2.amazonaws.com/mcp-s-connect
      kind: Kustomization
      labels:
        - pairs:
            app.kubernetes.io/version: ""
      namespace: dev
      resources:
        - ../../base
  - metadata:
      folder: overlays/on-prem
      filePath: overlays/on-prem/kustomization.yaml
    spec:
      apiVersion: kustomize.config.k8s.io/v1beta1
      configMapGenerator:
        - behavior: merge
          name: mcp-s-connect-environment-values
          envs:
            - environment-values.env
        - behavior: merge
          name: mcp-s-connect-container-vars
          envs:
            - container.env
      kind: Kustomization
      labels:
        - pairs:
            app.kubernetes.io/version: null
      namespace: webrix
      resources:
        - ../../base
      images:
        - name: quay.io/idan-chetrit/mcp-s-connect
          newTag: null
  - metadata:
      folder: overlays/prod
      filePath: overlays/prod/kustomization.yaml
    spec:
      apiVersion: kustomize.config.k8s.io/v1beta1
      configMapGenerator:
        - behavior: merge
          envs:
            - environment-values.env
          name: mcp-s-connect-environment-values
        - behavior: merge
          envs:
            - container.env
          name: mcp-s-connect-container-vars
      images:
        - name: 992382826040.dkr.ecr.us-east-2.amazonaws.com/mcp-s-connect
      kind: Kustomization
      labels:
        - pairs:
            app.kubernetes.io/version: ""
      namespace: prod
      resources:
        - ../../base
{{- end }}