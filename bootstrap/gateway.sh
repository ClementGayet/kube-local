#!/bin/bash

# Ajouter le repo Helm officiel de Kong
helm repo add kong https://charts.konghq.com
helm repo update

# Créer le namespace kong
kubectl create namespace kong

# Installer Kong Gateway avec Gateway API activée
helm install kong kong/kong \
  --namespace kong \
  --set ingressController.enabled=false \
  --set gateway.enabled=true \
  --set admin.enabled=false \
  --set env.controller_log_level=info

# Wait for Kong Gateway to be ready
echo "Waiting for Kong Gateway to be ready..."

until kubectl get pods -n kong | grep -q "1/1"; do
  sleep 5
done