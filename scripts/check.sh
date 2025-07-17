#!/bin/bash

echo "🔍 Controllo Kong Admin API..."
curl -s http://localhost:8001/status | grep -q '"total_requests":' && echo "✅ Kong Admin API OK" || echo "❌ NON RISPONDE"

echo "🔍 Controllo Kong Proxy (HTTPS)..."
curl -sk https://localhost:8443 | grep -q "no Route matched" && echo "✅ Kong Proxy OK" || echo "❌ Proxy NON RISPONDE"

echo "🔍 Controllo Kong Manager..."
curl -s http://localhost:8002 | grep -q "<!DOCTYPE html>" && echo "✅ Kong Manager OK" || echo "❌ NON RISPONDE"

echo "🔍 Controllo Prometheus..."
curl -s http://localhost:9090/graph | grep -q "<title>Prometheus" && echo "✅ Prometheus OK" || echo "❌ NON RISPONDE"

echo "🔍 Controllo Grafana..."
curl -sL http://localhost:3000 | grep -q "<title>Grafana" && echo "✅ Grafana OK" || echo "❌ NON RISPONDE"

echo "🔍 Controllo Jaeger..."
curl -s http://localhost:16686 | grep -q "<html" && echo "✅ Jaeger OK" || echo "❌ NON RISPONDE"

echo "🔍 Controllo auth-service..."
curl -s http://localhost:3001 | grep -q "Hello World" && echo "✅ auth-service OK" || echo "❌ NON RISPONDE"

