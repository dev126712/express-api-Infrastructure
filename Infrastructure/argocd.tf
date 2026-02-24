resource "helm_release" "argocd" {
  name             = "argocd"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  namespace        = "argocd"
  create_namespace = true
  version          = "v3.3.2"

  # We point ArgoCD to our "Root" application in Git
  values = [file("values/argocd.yaml")]
}
