#!/bin/bash

kubectl kustomize "https://github.com/nginx/nginx-gateway-fabric/config/crd/gateway-api/standard?ref=v1.6.2" | kubectl apply -f -

helm install ngf oci://ghcr.io/nginx/charts/nginx-gateway-fabric --create-namespace -n nginx-gateway --set service.create=false

kubectl apply -f - <<EOF

apiVersion: v1
kind: Service
metadata:
  name: nginx-gateway
  namespace: nginx-gateway
  labels:
    app.kubernetes.io/name: nginx-gateway-fabric
    app.kubernetes.io/instance: ngf
    app.kubernetes.io/version: "1.6.2"
spec:
  type: NodePort
  selector:
    app.kubernetes.io/name: nginx-gateway-fabric
    app.kubernetes.io/instance: ngf
  ports:
    - name: http
      port: 80
      protocol: TCP
      targetPort: 80
      nodePort: 31437
    - name: https
      port: 443
      protocol: TCP
      targetPort: 443
      nodePort: 31438
EOF

kubectl apply -f - <<EOF
apiVersion: gateway.networking.k8s.io/v1
kind: Gateway
metadata:
  name: gateway
  namespace: local
spec:
  gatewayClassName: nginx
  listeners:
    - name: http
      port: 80
      allowedRoutes:
        namespaces:
          from: All
      protocol: HTTP
      hostname: "*.fbi.com"
EOF