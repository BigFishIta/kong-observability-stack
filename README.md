🚀 Kong Observability Stack (Docker Compose)
Infrastruttura completa e riutilizzabile per l’osservabilità di Kong Gateway OSS tramite uno stack 100% open source, eseguibile con Docker Compose.

📦 Componenti inclusi
Servizio	Porta (default)	Funzione
Kong Gateway	${KONG_PROXY_PORT}	API Gateway + reverse proxy
Kong Admin API	${KONG_ADMIN_PORT}	Configurazione e gestione
Kong Manager	${KONG_MANAGER_PORT}	Interfaccia web GUI
Prometheus	${PROMETHEUS_PORT}	Raccolta metriche
Grafana	${GRAFANA_PORT}	Dashboard unificata
Loki	${LOKI_PORT}	Log strutturati
Fluent Bit	9880	Log collector da Kong
OTEL Collector	4317, 4318	Tracing da app e microservizi
Jaeger	16686	Tracing distribuito (UI + storage)

⚡ Avvio rapido
Clona il repository

bash
Copia
Modifica
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
I microservizi (es. in NestJS) sono tracciati via OTEL + Jaeger e monitorati tramite Prometheus.

Ogni microservizio può:

Esportare metriche su /metrics

Generare trace OTLP

Scrivere log in formato JSON per Fluent Bit / Loki

🔐 Sicurezza API: HTTPS + JWT
✅ HTTPS in locale
Kong è configurato per esporre anche HTTPS sulla porta 8443, con certificati self-signed utili per test locali.

bash
Copia
Modifica
curl -k https://localhost:8443/my-api \
  -H "Host: localhost"
📁 Certificati:

./certs/kong.crt

./certs/kong.key

Configurati via:

env
Copia
Modifica
KONG_SSL_CERT=/etc/kong/kong.crt  
KONG_SSL_CERT_KEY=/etc/kong/kong.key
🔐 Autenticazione con JWT
Kong protegge le API tramite JWT Plugin. Solo i client che inviano un token valido possono accedere alle rotte protette.

🧱 Esempio in kong.yml:
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
📤 Come funziona:
Il client invia il token JWT via header:

http
Copia
Modifica
Authorization: Bearer <token>
Il token deve contenere il campo iss uguale a my-client-key e usare la secret specificata.

🛠 Generazione token (esempio payload):
json
Copia
Modifica
{
  "iss": "my-client-key"
}
Puoi generarlo via:

https://jwt.io

oppure via jsonwebtoken in Node.js

🧪 Test via curl:
bash
Copia
Modifica
curl -k https://localhost:8443/auth \
  -H "Host: localhost" \
  -H "Authorization: Bearer <TOKEN_GENERATO>"
Se il token è valido → proxy verso il microservizio.
Se è assente o errato → 401 Unauthorized.

📊 Dashboard Grafana provisioning
Le dashboard vengono caricate automaticamente da:

bash
Copia
Modifica
grafana/provisioning/dashboards/
e collegate al datasource Prometheus, configurato in:

bash
Copia
Modifica
grafana/provisioning/datasources/
🛠 Comandi utili (Makefile)
bash
Copia
Modifica
make up         # Avvia tutti i container
make down       # Ferma tutto
make check      # Controlla salute dei servizi (Kong, Grafana, Prometheus...)
make logs       # Log di Kong in tempo reale
📁 .gitignore consigliato
gitignore
Copia
Modifica
# Node.js
node_modules/
dist/
.env

# Docker
**/.DS_Store
docker-compose.override.yml

# VSCode
.vscode/
🚧 Work in progress
Prossimi step (facoltativi ma consigliati):

 CI/CD con GitHub Actions

 Template GitHub per progetti derivati

 Integrazione database (PostgreSQL, MongoDB)

 Supporto a rate limiting, ACL, OAuth2