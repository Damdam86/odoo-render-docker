#!/bin/bash
echo "🚀 Starting Odoo with Render configuration..."

# Vérification
echo "🔒 PostgreSQL SSL config: PGHOST=$PGHOST | PGPORT=$PGPORT | PGUSER=$PGUSER | PGDATABASE=$PGDATABASE"

if [ -z "$PGHOST" ] || [ -z "$PGPORT" ] || [ -z "$PGUSER" ] || [ -z "$PGPASSWORD" ] || [ -z "$PGDATABASE" ]; then
  echo "❌ Missing database environment variables!"
  exit 1
fi

# Démarrage d'Odoo
exec odoo --config=/etc/odoo/odoo.conf
