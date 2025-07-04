#!/bin/bash
echo "🚀 Starting Odoo with Render configuration..."

echo "🔒 PostgreSQL SSL config:"
echo "PGHOST=$PGHOST"
echo "PGPORT=$PGPORT"
echo "PGUSER=$PGUSER"
echo "PGPASSWORD=$PGPASSWORD"
echo "PGDATABASE=$PGDATABASE"

# Vérification
if [ -z "$PGHOST" ] || [ -z "$PGPORT" ] || [ -z "$PGUSER" ] || [ -z "$PGPASSWORD" ]; then
  echo "❌ Missing database environment variables!"
  exit 1
fi

# Forcer SSL
export PGSSLMODE=require

exec odoo \
  --db_uri="postgresql://${PGUSER}:${PGPASSWORD}@${PGHOST}:${PGPORT}/${PGDATABASE}?sslmode=require" \
  --log-level=debug \
  --http-port=8069 \
  --http-interface=0.0.0.0
