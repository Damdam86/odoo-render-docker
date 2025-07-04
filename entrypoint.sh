#!/bin/bash
echo "🚀 Starting Odoo with Render configuration..."

echo "🔒 PostgreSQL SSL config:"
echo "PGHOST=$PGHOST"
echo "PGPORT=$PGPORT"
echo "PGUSER=$PGUSER"
echo "PGDATABASE=$PGDATABASE"

# Vérification des variables essentielles
if [ -z "$PGHOST" ] || [ -z "$PGPORT" ] || [ -z "$PGUSER" ] || [ -z "$PGPASSWORD" ]; then
  echo "❌ Missing database environment variables!"
  exit 1
fi

# Forcer SSL
export PGSSLMODE=require

# Attendre que PostgreSQL soit dispo (max 30s)
echo "📡 Waiting for PostgreSQL to be ready..."
for i in {1..30}; do
    pg_isready -h "$PGHOST" -p "$PGPORT" -U "$PGUSER" > /dev/null 2>&1 && break
    echo -n "⏳ Still waiting for PostgreSQL at $PGHOST:$PGPORT..."
    sleep 1
done

echo "✅ PostgreSQL is available, starting Odoo..."

exec odoo \
  --db_host="$PGHOST" \
  --db_port="$PGPORT" \
  --db_user="$PGUSER" \
  --db_password="$PGPASSWORD" \
  --log-level=debug \
  --http-port=8069 \
  --http-interface=0.0.0.0
