# 🚀 kube-local

Environnement Kubernetes local prêt à l’emploi avec Kind, incluant :

- Ingress NGINX via Gateway API
- PostgreSQL avec mot de passe et configuration pg_hba
- NATS (messagerie CNCF) avec JetStream activé
- Dashboard Kubernetes sans authentification

## 📁 Structure du dépôt

```
kube-local/
├── bootstrap/          # Scripts d'initialisation du cluster
│   ├── cluster.sh      # Création du cluster Kind
│   └── gateway.sh      # Installation de Kong Gateway (Gateway API)
│
├── nats/               # Déploiement de NATS
│   └── nats.sh         # Installation via Helm avec JetStream
│
├── postgres/           # Déploiement de PostgreSQL
│   └── postgres.sh     # Installation via Helm avec pgHBA configuré
│
├── <service>/           # Déploiement de <service>
│   └── service.sh       # Script sh pour le déploiement de <service>
│
├── kind-cluster.yaml   # Configuration du cluster Kind (avec port mapping)
├── LICENSE
└── README.md           # Ce fichier
```

## 🛠 Prérequis

- [Kind](https://kind.sigs.k8s.io/docs/user/quick-start/)
- [kubectl](https://kubernetes.io/docs/tasks/tools/)
- [Helm](https://helm.sh/docs/intro/install/)

---

## ⚙️ Étapes d’installation

### 1. Créer le cluster Kind

```bash
./bootstrap/cluster.sh
```

### 2. Installer Kong Gateway (Gateway API)

```bash
./bootstrap/gateway.sh
```

### 3. Installer PostgreSQL

```bash
./postgres/postgres.sh
```

### 4. Installer NATS (JetStream activé)

```bash
./nats/nats.sh
```