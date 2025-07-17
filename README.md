## Kong Observability Stack (Docker Compose)

Infrastruttura completa per l'**osservabilità di Kong Gateway OSS** con uno **stack 100% open source**, eseguibile via Docker Compose.

---

## 📦 Componenti inclusi

| Servizio        | Porta (default)          | Funzione                                   |
|-----------------|--------------------------|--------------------------------------------|
| Kong            | `${KONG_PROXY_PORT}`     | Proxy (ingresso richieste API)             |
| Kong Admin API  | `${KONG_ADMIN_PORT}`     | API REST di gestione Kong                  |
| Kong Manager    | `${KONG_MANAGER_PORT}`   | Interfaccia web GUI                        |
| Prometheus      | `${PROMETHEUS_PORT}`     | Metriche e monitoring                      |
| Grafana         | `${GRAFANA_PORT}`        | Dashboard unificata (log, metriche, trace) |
| Loki            | `${LOKI_PORT}`           | Backend log strutturati                    |
| Fluent Bit      | `2020`                   | Collector dei log HTTP da Kong             |
| OTEL Collector  | `4317`, `4318`           | Riceve trace OTLP da app e microservizi    |
| Jaeger          | `16686`                  | Backend tracing distribuito (UI + storage) |

---

## 🚀 Avvio rapido

1. Clona il repository

```bash
git clone https://github.com/<TUO-USERNAME>/kong-observability-stack.git
cd kong-observability-stack
Crea il file .env partendo dal template

bash
Copia
Modifica
cp .env.example .env
Avvia l’infrastruttura

bash
Copia
Modifica
docker compose up -d
Accedi ai servizi:

Grafana: http://localhost:3000

Prometheus: http://localhost:9090

Jaeger UI: http://localhost:16686

Kong Manager: http://localhost:8002

🧪 Monitoraggio dei microservizi
I microservizi (NestJS) sono tracciati via OTEL + Jaeger e monitorati da Prometheus.
Ogni servizio può esporre metriche su /metrics e tracing automatico OTLP.

🔒 Sicurezza e CI/CD (in progress)
Il progetto include già i container base. A breve saranno aggiunti:

Automazioni GitHub Actions

Supporto a HTTPS e JWT

Dashboard personalizzate provisioning-ready

yaml
Copia
Modifica

---

## 📁 `.gitignore` consigliato

```gitignore
# Node.js
node_modules/
dist/
.env
npm-debug.log*
yarn-debug.log*
yarn-error.log*

# Docker
**/.DS_Store
docker-compose.override.yml

# VSCode
.vscode/