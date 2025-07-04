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

# TEST SANS SSL (temporaire)
export PGSSLMODE=disable

echo "🚀 Testing Odoo WITHOUT SSL..."

exec odoo \
  --db_host=${PGHOST} \
  --db_port=${PGPORT} \
  --db_user=${PGUSER} \
  --db_password=${PGPASSWORD} \
  --database=${PGDATABASE} \
  -i base \
  --without-demo=all \
  --log-level=info \
  --http-port=8069 \
  --http-interface=0.0.0.0
