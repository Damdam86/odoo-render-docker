#!/bin/bash
echo "🚀 Starting Odoo with custom Render configuration..."

echo "Database config:"
echo "Host: $PGHOST"
echo "Port: $PGPORT" 
echo "User: $PGUSER"
echo "Database: $PGDATABASE"

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
  --http-port=8069 \
  --http-interface=0.0.0.0
