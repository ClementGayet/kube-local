#/bin/bash

helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update

helm install postgres bitnami/postgresql \
  --namespace infra \
  --create-namespace \
  --set auth.postgresPassword=supersecure \
  --set primary.persistence.enabled=true \
  --set primary.persistence.size=1Gi \
  --set primary.pgHbaConfiguration="host all all 0.0.0.0/0 md5"