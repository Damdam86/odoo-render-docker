#!/bin/bash
set -e

echo "⚡ DÉMARRAGE IMMÉDIAT - PORT 8069 EN PRIORITÉ"
echo "🎯 Objectif: Ouvrir le port AVANT tout le reste"

echo "🚀 DÉMARRAGE IMMÉDIAT ODOO"
echo "🌐 Port 8069 va s'ouvrir MAINTENANT"

# Attendre PostgreSQL très rapidement (10 secondes max)
timeout=10
while [ $timeout -gt 0 ]; do
    if pg_isready -h "${DB_HOST:-localhost}" -p "${DB_PORT:-5432}" -U "${DB_USER:-odoo}" >/dev/null 2>&1; then
        echo "✅ PostgreSQL OK"
        break
    fi
    sleep 1
    timeout=$((timeout - 1))
done

# Obtenir le nom de la base
DB_NAME=$(psql -h "${DB_HOST:-localhost}" -p "${DB_PORT:-5432}" -U "${DB_USER:-odoo}" -l -t 2>/dev/null | grep -v template | grep -v postgres | head -1 | awk '{print $1}' | xargs || echo "odoo")
echo "🎯 Base: $DB_NAME"

# Démarrage d'Odoo avec base explicite
exec /usr/bin/odoo \
    --database="$DB_NAME" \
    --http-interface=0.0.0.0 \
    --http-port=8069 \
    --workers=0 \
    --logfile=- \
    --no-database-list