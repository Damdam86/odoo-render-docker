#!/bin/bash
echo "🚀 Starting Odoo with custom Render configuration..."

# Si vous avez DATABASE_URL (plus simple)
if [ -n "$DATABASE_URL" ]; then
    echo "✅ Using DATABASE_URL"
    exec odoo \
      --db_url="$DATABASE_URL" \
      -i base \
      --without-demo=all \
      --log-level=info \
      --http-port=8069 \
      --http-interface=0.0.0.0
else
    # Sinon utiliser les variables séparées
    echo "⏳ Waiting for database to be ready..."
    until pg_isready -h ${PGHOST} -p ${PGPORT} -U ${PGUSER}; do
      echo "Database not ready, waiting..."
      sleep 2
    done

    echo "✅ Database is ready!"
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
fi
