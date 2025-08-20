# K3s Monitoring Stack Runbook – ArgoCD + kube-prometheus-stack

## Overview
This runbook covers the deployment of a complete monitoring stack using **Prometheus** and **Grafana** on a K3s cluster, managed through **ArgoCD GitOps workflows**. The setup uses the `kube-prometheus-stack` Helm chart from the official Helm repository.

## Monitoring Stack Architecture

Git Repository (values.yaml)
          |
          v
      ArgoCD GitOps
          |
          v
   kube-prometheus-stack Helm Chart
       /                 \
      v                   v
Prometheus Operator &   Grafana Dashboards
     Exporters
      ^ 
      |
   K3s Cluster Metrics
   
### Diagram Explanation

- **Git Repository**: Stores your values.yaml and any configuration changes for apps.
- **ArgoCD**: Watches Git for changes and applies them to the cluster automatically.
- **Helm Chart**: kube-prometheus-stack defines all necessary Kubernetes manifests for Prometheus and Grafana.
- **K3s Cluster**: Hosts Prometheus, Grafana, node exporters, and other monitoring components.
- **Prometheus**: Collects metrics from K3s nodes and workloads.
- **Grafana**: Visualizes metrics collected by Prometheus.


### Components
- **K3s Cluster** – lightweight Kubernetes cluster running multiple VMs.
- **ArgoCD** – GitOps tool managing declarative deployments.
- **Prometheus** – collects metrics from the cluster, nodes, and workloads.
- **Grafana** – dashboard and visualization layer for metrics.
- **kube-prometheus-stack** – Helm chart combining Prometheus Operator, Grafana, CRDs, exporters, and dashboards.

---

## Setup Summary

1. **Install ArgoCD** on the K3s cluster via Helm.
2. **Create ArgoCD Application** for `kube-prometheus-stack`.
3. **Source**:
   - Helm chart: `kube-prometheus-stack` from `https://prometheus-community.github.io/helm-charts`
   - Custom overrides: `values.yaml` stored in GitHub repository
4. **Destination**:
   - K3s cluster API: `https://kubernetes.default.svc`
   - Namespace: `monitoring`
5. **Sync Policy**:
   - `automated.prune: true` – remove outdated resources automatically
   - `automated.selfHeal: true` – restore resources if drift occurs

### Example ArgoCD Application YAML
```yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: kube-prometheus-stack
  namespace: argocd
spec:
  project: default
  source:
    repoURL: https://prometheus-community.github.io/helm-charts
    chart: kube-prometheus-stack
    targetRevision: 76.4.0
    helm:
      releaseName: kube-prometheus-stack
      valueFiles:
        - https://raw.githubusercontent.com/RemyPaulJr/KubernetesHomeLab/master/k8s/apps/monitoring/values.yaml
  destination:
    server: https://kubernetes.default.svc
    namespace: monitoring
  syncPolicy:
    automated:
      prune: true
      selfHeal: true
```

## Key Benefits

### 1. GitOps Driven
- All configuration is version-controlled in Git (`values.yaml`).
- ArgoCD automatically applies any changes in Git to the cluster.
- Provides a clear audit trail of what is deployed and when.

### 2. Self-Healing and Drift Correction
- Detects and automatically corrects manual changes in the cluster.
- Ensures Prometheus and Grafana configurations remain consistent.

### 3. Automated Pruning
- Removes resources no longer defined in the Helm chart or `values.yaml`.
- Keeps the cluster clean and prevents orphaned components.

### 4. Unified Monitoring Stack
- `kube-prometheus-stack` provides:
  - Node metrics via exporters
  - Kubernetes cluster metrics via Prometheus Operator
  - Grafana dashboards for visualizing metrics
- Easy setup and maintenance using ArgoCD and Helm.

### 5. Multi-App Consistency
- Same GitOps workflow can be applied to other apps (Vault, Nginx, custom services).
- Reduces operational overhead and manual deployment errors.

---

## Operational Runbook

### Accessing Grafana
```bash
kubectl -n monitoring port-forward svc/kube-prometheus-stack-grafana 3000:80
```
- Navigate to http://localhost:3000
- Admin credentials are set in values.yaml

### Accessing ArgoCD UI
```bash
kubectl -n argocd port-forward svc/argocd-server 8080:443
```
- Navigate to https://localhost:8080
- Login using ArgoCD admin credentials.

### Syncing Changes
- Any updates in Git (values.yaml) are automatically applied.
- For manual sync:
argocd app sync kube-prometheus-stack

### Troubleshooting
- **Pods not running:**  
kubectl -n monitoring get pods  
kubectl logs <pod>

- **Sync issues in ArgoCD:**  
argocd app get kube-prometheus-stack

- **Values overrides not applied:** Ensure valueFiles points to the raw Git URL  

---

This setup ensures your monitoring stack is **fully declarative, automated, and self-healing**, with **Git as the single source of truth**