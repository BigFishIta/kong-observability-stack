# Kong Observability Stack (Docker Compose)

Infrastruttura completa per l'**osservabilità di Kong Gateway OSS** con **stack 100% open source**, eseguibile via Docker Compose.

## 📦 Componenti inclusi

| Servizio     | Porta  | Funzione                              |
|--------------|--------|---------------------------------------|
| Kong         | 8000   | Proxy (ingresso richieste API)        |
| Kong Admin   | 8001   | API REST di gestione                  |
| Kong Manager | 8002   | Interfaccia Web GUI                   |
| Prometheus   | 9090   | Metriche da Kong                      |
| Grafana      | 3000   | Dashboard unificata                   |
| Loki         | 3100   | Backend log strutturati               |
| Fluent Bit   | 9880   | Log collector per Kong                |
| OTEL Collector | 4317 | Tracing distribuito (facoltativo)     |
| Tempo        | 3200   | Traces (distribuiti via OTLP)         |

---

## 🚀 Avvio rapido

1. Clona il repository:

```bash
git clone https://github.com/<TUO-USERNAME>/kong-observability-stack.git
cd kong-observability-stack
