#!/bin/bash

cat <<EOF | kind create cluster --config=-
apiVersion: kind.x-k8s.io/v1alpha4
kind: Cluster
nodes:
  - role: control-plane
    extraPortMappings:
      - containerPort: 31437
        hostPort: 80
        protocol: TCP
EOF

kubectl apply -f - <<EOF
apiVersion: v1
kind: Namespace
metadata:
  name: local
  labels:
    env: local
EOF