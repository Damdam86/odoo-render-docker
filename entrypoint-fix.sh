#!/bin/bash
set -e

echo "🔧 Script de correction Odoo CRM"

# Variables
DB_HOST="${DB_HOST:-localhost}"
DB_PORT="${DB_PORT:-5432}"
DB_USER="${DB_USER:-odoo}"
ODOO_RC="${ODOO_RC:-/etc/odoo/odoo.conf}"

# Attendre PostgreSQL
echo "⏳ Attente PostgreSQL..."
while ! pg_isready -h "$DB_HOST" -p "$DB_PORT" -U "$DB_USER" >/dev/null 2>&1; do
    sleep 1
done
echo "✅ PostgreSQL OK"

# Détecter le nom de la base
DB_NAME=$(psql -h "$DB_HOST" -p "$DB_PORT" -U "$DB_USER" -l -t | grep -v template | grep -v postgres | head -1 | awk '{print $1}' | xargs)
echo "🎯 Base détectée: $DB_NAME"

# FORCER la réinitialisation complète
echo "🔧 FORCE: Réinitialisation complète..."
/usr/bin/odoo \
    -c "$ODOO_RC" \
    -d "$DB_NAME" \
    -i base \
    --without-demo=all \
    --stop-after-init \
    --db-filter=".*"

echo "🔧 FORCE: Installation modules CRM..."
/usr/bin/odoo \
    -c "$ODOO_RC" \
    -d "$DB_NAME" \
    -i crm,contacts,mail,web \
    --without-demo=all \
    --stop-after-init \
    --db-filter=".*"

echo "🚀 Démarrage final..."
exec /usr/bin/odoo \
    -c "$ODOO_RC" \
    -d "$DB_NAME" \
    --db-filter=".*"