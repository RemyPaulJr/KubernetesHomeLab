## Step 1: Create argocd namespace
```bash
kubectl create namespace -n argocd
```

## Step 2: Add the Argo Helm repo
```bash
helm repo add argo https://argoproj.github.io/argo-helm
helm repo update
```

## Step 3: Install Argo CD via Helm
```bash
helm install argocd argo/argo-cd -n argocd
```

## Step 4: Verify Install
```bash
helm list -n argocd
kubectl get pods -n argocd
```

## Step 5: Access Argo CD server
Username will be admin.
Generate Password:
```bash
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
```

```bash
kubectl port-forward svc/argocd-server -n argocd 8080:443
```
Then open a browser and go to https://localhost:8080 to login.