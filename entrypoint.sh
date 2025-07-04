#!/bin/bash
echo "🚀 Starting Odoo with Render configuration..."

# Affichage de la config (sans password pour sécurité)
echo "🔒 PostgreSQL SSL config:"
echo "PGHOST=$PGHOST"
echo "PGPORT=$PGPORT"
echo "PGUSER=$PGUSER"
echo "PGDATABASE=$PGDATABASE"

# Vérification des variables essentielles
if [ -z "$PGHOST" ] || [ -z "$PGPORT" ] || [ -z "$PGUSER" ] || [ -z "$PGPASSWORD" ] || [ -z "$PGDATABASE" ]; then
  echo "❌ Missing one or more required database environment variables!"
  exit 1
fi

# Forcer SSL pour PostgreSQL
export PGSSLMODE=require

# Attente que PostgreSQL soit prêt
echo "📡 Waiting for PostgreSQL to be ready..."
until pg_isready -h "$PGHOST" -p "$PGPORT" -U "$PGUSER" > /dev/null 2>&1; do
  echo "⏳ Still waiting for PostgreSQL at $PGHOST:$PGPORT..."
  sleep 2
done
echo "✅ PostgreSQL is available, starting Odoo..."

# Lancer Odoo avec les bons paramètres
exec odoo \
  --db_host="$PGHOST" \
  --db_port="$PGPORT" \
  --db_user="$PGUSER" \
  --db_password="$PGPASSWORD" \
  --db_name="$PGDATABASE" \
  --log-level=debug \
  --http-port=8069 \
  --http-interface=0.0.0.0
