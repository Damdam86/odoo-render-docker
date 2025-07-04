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

echo "🚀 Starting Odoo with SSL configuration..."

exec odoo \
  --db_host=${PGHOST} \
  --db_port=${PGPORT} \
  --db_user=${PGUSER} \
  --db_password=${PGPASSWORD} \
  --database=${PGDATABASE} \
  --db_sslmode=require \
  -i base \
  --without-demo=all \
  --log-level=info \
  --http-port=8069 \
  --http-interface=0.0.0.0
