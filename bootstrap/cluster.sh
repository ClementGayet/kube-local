#!/bin/bash

cat <<EOF | kind create cluster --config=-
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
nodes:
  - role: control-plane
    extraPortMappings:
      - containerPort: 31437
        hostPort: 80
        protocol: TCP
      - containerPort: 31438
        hostPort: 443
        protocol: TCP
  - role: worker
  - role: worker
EOF

kubectl apply -f - <<EOF
apiVersion: v1
kind: Namespace
metadata:
  name: local
  labels:
    env: local
EOF