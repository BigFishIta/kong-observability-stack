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

🔐 Sicurezza API: HTTPS + JWT
L’infrastruttura è già predisposta per gestire connessioni sicure (HTTPS) e autenticazione tramite JWT, usando plugin nativi di Kong Gateway.

✅ HTTPS (locale)
Kong espone anche una porta HTTPS (8443) configurata con un certificato self-signed, utile in fase di sviluppo e test.

📁 File certificati (self-signed):
./certs/kong.crt

./certs/kong.key

🔧 I certificati vengono montati nel container Kong e configurati tramite le variabili d’ambiente:

env
Copia
Modifica
KONG_SSL_CERT=/etc/kong/kong.crt  
KONG_SSL_CERT_KEY=/etc/kong/kong.key
🔍 Accesso API sicuro:
Esempio richiesta via HTTPS:

bash
Copia
Modifica
curl -k https://localhost:8443/my-api \
  -H "Host: localhost"
L'opzione -k serve per ignorare il certificato non verificato (in ambiente dev).

🔐 JWT Plugin (JSON Web Token)
Kong è configurato per autenticare automaticamente le richieste API usando token JWT firmati con algoritmo HS256.

✍️ Esempio kong.yml:
yaml
Copia
Modifica
consumers:
  - username: my-client
    custom_id: client-001

jwt_secrets:
  - consumer: my-client
    key: my-client-key
    secret: my-very-super-secret-key-1234567890abcdef
    algorithm: HS256

services:
  - name: auth-service
    url: http://auth-service:3000
    routes:
      - name: auth-route
        paths:
          - /auth
        plugins:
          - name: jwt
🔐 Come funziona
Per autenticarsi, il client deve inviare un header HTTP con il token:

http
Copia
Modifica
Authorization: Bearer <token_jwt>
Il token deve essere firmato con secret e includere il campo iss uguale a my-client-key.

🛠 Generazione token (esempio payload):
json
Copia
Modifica
{
  "iss": "my-client-key"
}
👉 Puoi generare token JWT validi per test locali tramite https://jwt.io oppure script con jsonwebtoken in Node.js.

🧪 Esempio test con curl:
bash
Copia
Modifica
curl -k https://localhost:8443/auth \
  -H "Host: localhost" \
  -H "Authorization: Bearer <TOKEN_GENERATO>"
Se il token è valido, Kong proxy inoltrerà la richiesta al microservizio.

Se è assente o errato, risponderà con:

arduino
Copia
Modifica
HTTP/1.1 401 Unauthorized
{"message":"Unauthorized"}