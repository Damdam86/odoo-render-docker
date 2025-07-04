#!/bin/bash
echo "🚀 Starting Odoo with custom Render configuration..."

# Attendre que la base de données soit disponible (avec timeout)
echo "⏳ Waiting for database to be ready..."
timeout=60
counter=0
until pg_isready -h ${PGHOST} -p ${PGPORT} -U ${PGUSER} || [ $counter -eq $timeout ]; do
  echo "Database not ready, waiting... ($counter/$timeout)"
  sleep 2
  counter=$((counter + 1))
done

if [ $counter -eq $timeout ]; then
  echo "❌ Database connection timeout. Check your PostgreSQL service."
  exit 1
fi

echo "✅ Database is ready!"

# Démarrer Odoo avec exposition du port
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
