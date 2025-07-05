#!/bin/bash

echo "🔍 TEST DE PORT - Vérification que le service écoute"

PORT="${PORT:-8069}"
MAX_WAIT=60
count=0

echo "⏳ Attente du port $PORT (max ${MAX_WAIT}s)..."

while [ $count -lt $MAX_WAIT ]; do
    if netstat -tln 2>/dev/null | grep -q ":$PORT " || \
       ss -tln 2>/dev/null | grep -q ":$PORT " || \
       lsof -i :$PORT 2>/dev/null | grep -q LISTEN; then
        echo "✅ Port $PORT est OUVERT et en écoute!"
        exit 0
    fi
    
    echo "   Tentative $count/$MAX_WAIT..."
    sleep 1
    count=$((count + 1))
done

echo "❌ TIMEOUT: Port $PORT non accessible après ${MAX_WAIT}s"
echo "🔧 Vérification des processus en cours:"
ps aux | grep odoo || echo "Aucun processus odoo trouvé"
echo "🔧 Ports en écoute:"
netstat -tln 2>/dev/null || ss -tln 2>/dev/null || echo "Impossible de lister les ports"
exit 1