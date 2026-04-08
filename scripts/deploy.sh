#!/bin/bash
set -e

echo "==> Downloading MetalLB components..."
curl -o ../metallb/metallb-components.yaml https://raw.githubusercontent.com/metallb/metallb/v0.14.5/config/manifests/metallb-native.yaml

echo "==> Applying MetalLB namespace..."
kubectl apply -f ../metallb/namespace.yaml

echo "==> Applying MetalLB components..."
kubectl apply -f ../metallb/metallb-components.yaml

echo "==> Waiting for MetalLB to be ready..."
kubectl rollout status deployment/controller -n metallb-system --timeout=60s

echo "==> Applying MetalLB IP pool..."
kubectl apply -f ../metallb/ip-pool.yaml
kubectl apply -f ../metallb/l2-advertisment.yaml

echo "==> Applying Ingress-NGINX..."
kubectl apply -f ../ingress-nginx/

echo "==> Waiting for Ingress controller..."
kubectl rollout status deployment/ingress-controller --timeout=60s

echo "==> Applying services..."
kubectl apply -f ../service-a/
kubectl apply -f ../service-b/
kubectl apply -f ../ingress/

echo ""
echo "✓ Done! Getting external IP..."
kubectl get svc ingress-controller-service
