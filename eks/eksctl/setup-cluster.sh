# this script is neither chmod +x nor does it wait for eksctl-commands to complete
# therefore disable !/bin/bash
eksctl create cluster -f eks-config.yaml

kubectl apply --server-side -f https://github.com/kubernetes-sigs/gateway-api/releases/download/v1.5.0/experimental-install.yaml

eksctl utils associate-iam-oidc-provider --cluster ba-2026-eks --approve

eksctl create iamserviceaccount \
  --name ebs-csi-controller-sa \
  --namespace kube-system \
  --cluster ba-2026-eks \
  --attach-policy-arn arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy \
  --approve \
  --role-only

helm repo add prometheus-community https://prometheus-community.github.io/helm-charts

helm repo add cilium https://helm.cilium.io/

helm repo add argo https://argoproj.github.io/argo-helm

helm repo add grafana https://grafana.github.io/helm-charts

helm repo update

kubectl apply --server-side -f https://raw.githubusercontent.com/prometheus-operator/prometheus-operator/refs/tags/v0.89.0/example/prometheus-operator-crd/monitoring.coreos.com_alertmanagerconfigs.yaml
kubectl apply --server-side -f https://raw.githubusercontent.com/prometheus-operator/prometheus-operator/refs/tags/v0.89.0/example/prometheus-operator-crd/monitoring.coreos.com_alertmanagers.yaml
kubectl apply --server-side -f https://raw.githubusercontent.com/prometheus-operator/prometheus-operator/refs/tags/v0.89.0/example/prometheus-operator-crd/monitoring.coreos.com_podmonitors.yaml
kubectl apply --server-side -f https://raw.githubusercontent.com/prometheus-operator/prometheus-operator/refs/tags/v0.89.0/example/prometheus-operator-crd/monitoring.coreos.com_probes.yaml
kubectl apply --server-side -f https://raw.githubusercontent.com/prometheus-operator/prometheus-operator/refs/tags/v0.89.0/example/prometheus-operator-crd/monitoring.coreos.com_prometheusagents.yaml
kubectl apply --server-side -f https://raw.githubusercontent.com/prometheus-operator/prometheus-operator/refs/tags/v0.89.0/example/prometheus-operator-crd/monitoring.coreos.com_prometheuses.yaml
kubectl apply --server-side -f https://raw.githubusercontent.com/prometheus-operator/prometheus-operator/refs/tags/v0.89.0/example/prometheus-operator-crd/monitoring.coreos.com_prometheusrules.yaml
kubectl apply --server-side -f https://raw.githubusercontent.com/prometheus-operator/prometheus-operator/refs/tags/v0.89.0/example/prometheus-operator-crd/monitoring.coreos.com_scrapeconfigs.yaml
kubectl apply --server-side -f https://raw.githubusercontent.com/prometheus-operator/prometheus-operator/refs/tags/v0.89.0/example/prometheus-operator-crd/monitoring.coreos.com_servicemonitors.yaml
kubectl apply --server-side -f https://raw.githubusercontent.com/prometheus-operator/prometheus-operator/refs/tags/v0.89.0/example/prometheus-operator-crd/monitoring.coreos.com_thanosrulers.yaml

aws eks describe-cluster --name ba-2026-eks --region eu-central-1 --query "cluster.endpoint" --output text

# set K8s-ServiceHost in cilium-values.yaml
helm install cilium cilium/cilium --version 1.18.6 \
  --namespace kube-system \
  -f cilium-values.yaml

cilium status # errors are fine here

eksctl create nodegroup -f eks-managednodegroups.yaml

cilium status # now should be green

eksctl get iamserviceaccount --cluster ba-2026-eks --name ebs-csi-controller-sa --namespace kube-system

eksctl create addon --name aws-ebs-csi-driver --cluster ba-2026-eks --service-account-role-arn TODO:GETFROMABOVE

kubectl apply -f prom-storage.yaml

kubectl create ns monitoring

helm install kube-prometheus prometheus-community/kube-prometheus-stack \
   --namespace monitoring \
   -f prometheus-values.yaml

kubectl create namespace argo-rollouts
helm install argo-rollouts argo/argo-rollouts \
   --namespace argo-rollouts \
   --set dashboard.enabled=true \
   --wait

kubectl create namespace k6
helm install k6-operator grafana/k6-operator -f k6-values.yaml


kubectl apply -k ../kustomize

kubectl create secret docker-registry ghcr-image-pull-secret \
 --docker-server=TODO:DOCKER_REGISTRY --docker-username=TODO:DOCKER_USERNAME --docker-password=TODO:DOCKER_PASSWORD \
  -n thesis