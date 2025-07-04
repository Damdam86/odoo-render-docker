#!/bin/bash
echo "🚀 Starting Odoo with Render configuration..."

echo "🔒 PostgreSQL SSL config:"
echo "PGHOST=$PGHOST"
echo "PGPORT=$PGPORT"
echo "PGUSER=$PGUSER"
echo "PGPASSWORD=$PGPASSWORD"
echo "PGDATABASE=$PGDATABASE"

# Vérifier que toutes les variables sont là
if [ -z "$PGHOST" ] || [ -z "$PGPORT" ] || [ -z "$PGUSER" ] || [ -z "$PGPASSWORD" ] || [ -z "$PGDATABASE" ]; then
  echo "❌ Missing database environment variables!"
  exit 1
fi

# Forcer SSL (mais sans variables vides)
export PGSSLMODE=require

exec odoo \
  --db_host="$PGHOST" \
  --db_port="$PGPORT" \
  --db_user="$PGUSER" \
  --db_password="$PGPASSWORD" \
  --db_name="$PGDATABASE" \
  --log-level=debug \
  --http-port=8069 \
  --http-interface=0.0.0.0
