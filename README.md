# Express API — GKE Infrastructure

Terraform code that provisions the Google Kubernetes Engine infrastructure backing the [Express API](https://github.com/dev126712/express-api) platform.

[![My Skills](https://skillicons.dev/icons?i=terraform,gcp,kubernetes)](https://skillicons.dev)

---

## What's Provisioned

```
GCP Project
└── Custom VPC + Private Subnets + Cloud NAT
    ├── GKE Autopilot Cluster
    │     └── ArgoCD (installed via Helm)
    ├── Global External Load Balancer
    │     ├── Reserved static IP
    │     └── HTTP health check
    └── Google API Gateway
          └── OpenAPI spec → routes external traffic to GKE services
```

### Resources

| Resource | Details |
|---|---|
| **GKE Cluster** | Autopilot mode — fully managed, no node pool config needed |
| **Networking** | Custom VPC · private subnets · Cloud NAT for egress |
| **ArgoCD** | Deployed via `argo-cd` Helm chart (v3.3.2) into `argocd` namespace |
| **Load Balancer** | Global External LB with reserved static IP + HTTP health check |
| **API Gateway** | Google Cloud API Gateway with OpenAPI spec for external routing |

---

## Quick Start

```bash
git clone https://github.com/dev126712/express-api-Infrastructure
cd express-api-Infrastructure/Infrastructure

# Configure GCP credentials
gcloud auth application-default login

# Review variables
cp variables.tf.example terraform.tfvars   # if provided
# or edit variables.tf directly

terraform init
terraform plan
terraform apply
```

After `apply`, ArgoCD is running in the cluster. Point it to the [express-api-CD](https://github.com/dev126712/express-api-CD) repo to deploy the application.

---

## Key Files

| File | Purpose |
|---|---|
| `gke.tf` | GKE Autopilot cluster definition |
| `network.tf` | VPC, subnets, Cloud NAT |
| `argocd.tf` | ArgoCD Helm release |
| `gateway.tf` | Google API Gateway config |
| `load_balancer.tf` | Global LB with static IP |
| `services.tf` | GCP service enablement |
| `openapi_spec.yaml` | API Gateway routing spec |
| `variables.tf` | Input variables (project ID, region, cluster name) |
| `outputs.tf` | Cluster endpoint, static IP |
| `providers.tf` | Google and Helm provider config |

---

## Related Repos

| Repo | Role |
|---|---|
| [express-api](https://github.com/dev126712/express-api) | Application code |
| [express-api-CD](https://github.com/dev126712/express-api-CD) | Kustomize manifests + ArgoCD apps |
