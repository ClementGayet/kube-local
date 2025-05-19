#/bin/bash

helm repo add nats https://nats-io.github.io/k8s/helm/charts/

helm repo update

helm install nats nats/nats \
  --set nats.jetstream.enabled=true \
  --set cluster.enabled=false \
  --namespace infra \
  --create-namespace