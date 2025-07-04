#!/bin/bash
echo "🚀 Starting Odoo with custom Render configuration..."

# Attendre que la base de données soit disponible
echo "⏳ Waiting for database to be ready..."
until pg_isready -h ${PGHOST} -p ${PGPORT} -U ${PGUSER}; do
  echo "Database not ready, waiting..."
  sleep 2
done

echo "✅ Database is ready!"

# Démarrer Odoo
exec odoo \
  --db_host=${PGHOST} \
  --db_port=${PGPORT} \
  --db_user=${PGUSER} \
  --db_password=${PGPASSWORD} \
  --database=${PGDATABASE} \
  -i base \
  --without-demo=all \
  --log-level=info \
  --limit-time-cpu=600 \
  --limit-time-real=1200
