#!/bin/bash
set -e

echo "🚨 SCRIPT SIMPLE ET RADICAL - Odoo CRM"

# Attendre PostgreSQL
until pg_isready -h "${DB_HOST:-localhost}" -p "${DB_PORT:-5432}" -U "${DB_USER:-odoo}" >/dev/null 2>&1; do
    echo "⏳ Attente PostgreSQL..."
    sleep 2
done

# Obtenir le nom de la base
DB_NAME=$(psql -h "${DB_HOST:-localhost}" -p "${DB_PORT:-5432}" -U "${DB_USER:-odoo}" -l -t | grep -v template | grep -v postgres | head -1 | awk '{print $1}' | xargs)

echo "🗑️  NETTOYAGE RADICAL de la base $DB_NAME"
psql -h "${DB_HOST:-localhost}" -p "${DB_PORT:-5432}" -U "${DB_USER:-odoo}" -d "$DB_NAME" -c "DROP SCHEMA public CASCADE; CREATE SCHEMA public;" 2>/dev/null || true

echo "🔧 INSTALLATION MASSIVE de tous les modules"
/usr/bin/odoo \
    -c "${ODOO_RC:-/etc/odoo/odoo.conf}" \
    -d "$DB_NAME" \
    -i base,web,mail,contacts,crm,sale,account,calendar,hr,project \
    --without-demo=all \
    --stop-after-init \
    --db-filter=".*"

echo "🚀 DÉMARRAGE"
exec /usr/bin/odoo \
    -c "${ODOO_RC:-/etc/odoo/odoo.conf}" \
    -d "$DB_NAME" \
    --db-filter=".*"