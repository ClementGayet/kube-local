#!/bin/bash

cat <<EOF | kind create cluster --name m2devweb --config=-
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
nodes:
  - role: control-plane
    extraPortMappings:
      - containerPort: 80
        hostPort: 8080
      - containerPort: 443
        hostPort: 8443
  - role: worker
  - role: worker
EOF

# Wait for the cluster to be ready
echo "Waiting for the cluster to be ready..."
until kubectl get nodes | grep -q "Ready"; do
  sleep 5
done