#!/bin/bash
set -e

echo "🚀 DÉMARRAGE DIRECT ODOO - PORT 8069"

# Attendre PostgreSQL rapidement
echo "⏳ PostgreSQL..."
while ! pg_isready -h "${DB_HOST:-localhost}" -p "${DB_PORT:-5432}" -U "${DB_USER:-odoo}" >/dev/null 2>&1; do
    sleep 1
done
echo "✅ PostgreSQL OK"

# Nom de base
DB_NAME=$(psql -h "${DB_HOST:-localhost}" -p "${DB_PORT:-5432}" -U "${DB_USER:-odoo}" -l -t 2>/dev/null | grep -v template | grep -v postgres | head -1 | awk '{print $1}' | xargs || echo "odoo")
echo "🎯 Base: $DB_NAME"

# Vérifier si la base est initialisée
TABLES=$(psql -h "${DB_HOST:-localhost}" -p "${DB_PORT:-5432}" -U "${DB_USER:-odoo}" -d "$DB_NAME" -t -c "SELECT COUNT(*) FROM information_schema.tables WHERE table_name = 'res_users';" 2>/dev/null | xargs || echo "0")

if [ "$TABLES" = "0" ]; then
    echo "🔧 Initialisation rapide..."
    /usr/bin/odoo \
        --database="$DB_NAME" \
        --init=base \
        --stop-after-init \
        --without-demo=all \
        --logfile=- \
        --workers=0 || echo "Initialisation échouée, continuons..."
fi

# DÉMARRAGE DIRECT avec port explicite
echo "🚀 DÉMARRAGE ODOO PORT 8069"
echo "🌐 Interface: 0.0.0.0:8069"

exec /usr/bin/odoo \
    --database="$DB_NAME" \
    --http-interface=0.0.0.0 \
    --http-port=8069 \
    --xmlrpc-interface=0.0.0.0 \
    --xmlrpc-port=8069 \
    --no-database-list \
    --logfile=- \
    --workers=0