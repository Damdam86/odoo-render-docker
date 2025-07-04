#!/bin/bash
echo "🚀 Starting Odoo with custom Render configuration..."

echo "Database config:"
echo "Host: $PGHOST"
echo "Port: $PGPORT"
echo "User: $PGUSER"
echo "Database: $PGDATABASE"

# Vérifier que les variables sont définies
if [ -z "$PGHOST" ] || [ -z "$PGPORT" ] || [ -z "$PGUSER" ] || [ -z "$PGPASSWORD" ] || [ -z "$PGDATABASE" ]; then
    echo "❌ Missing database environment variables!"
    echo "Required: PGHOST, PGPORT, PGUSER, PGPASSWORD, PGDATABASE"
    exit 1
fi

# Configurer SSL via variables d'environnement PostgreSQL
export PGSSLMODE=require
export PGSSLCERT=""
export PGSSLKEY=""
export PGSSLROOTCERT=""

echo "🚀 Starting Odoo with PostgreSQL SSL environment variables..."

# Utiliser directement les variables d'environnement au lieu des paramètres --db_*
exec odoo \
  -d ${PGDATABASE} \
  -i base \
  --without-demo=all \
  --log-level=info \
  --http-port=8069 \
  --http-interface=0.0.0.0
