# Kubernetes Ingress & MetalLB Project

A Kubernetes setup to run multiple applications with host-based routing and external access using MetalLB and NGINX Ingress.

---

## Project Overview

This project demonstrates:

- Running multiple applications inside a Kubernetes cluster.
- Exposing applications via NGINX Ingress with path-based routing.
- Using MetalLB to provide external LoadBalancer IPs in bare-metal or local environments.
- Applying basic RBAC for secure access.

---

## Architecture 
<img width="1606" height="838" alt="image" src="https://github.com/user-attachments/assets/ce2a2a37-9eb5-4034-95e0-66783b926ea1" />


### Traffic Flow
User → MetalLB (LoadBalancer IP) → Ingress Controller (NGINX) → Services → Pods

### Key Components

1. **MetalLB**
   - Provides external IP addresses for services.
   - Handles load balancing for incoming traffic.
   - Configured with an IP pool and L2 advertisement.

2. **Ingress Controller (NGINX)**
   - Handles HTTP/HTTPS requests from MetalLB.
   - Routes traffic based on paths to Service-A or Service-B.

3. **Applications**
   - **Service-A**: Nginx demo application.
   - **Service-B**: Nginx demo application.
   - Both services are exposed internally via ClusterIP.

4. **Ingress Rules**
   - `/service-a` → routes to Service-A
   - `/service-b` → routes to Service-B

---

## Quick Start

Make sure you have a working Kubernetes cluster and `kubectl` installed.

Deploy the full setup:

```bash
cd scripts
./deploy.sh 
```

### Accessing the Services

Get the external IP from MetalLB for the Ingress controller:
```bash
kubectl get svc ingress-controller-service
```
Then access the services:
```bash
curl http://<EXTERNAL-IP>/service-a
curl http://<EXTERNAL-IP>/service-b
```
