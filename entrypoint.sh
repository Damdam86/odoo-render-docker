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
    exit 1
fi

# Forcer SSL avec paramètres spécifiques pour Render
export PGSSLMODE=require
export PGSSLCERT=""
export PGSSLKEY=""
export PGSSLROOTCERT=""
export PGSSLCRL=""

echo "🚀 Starting Odoo with FORCED SSL configuration..."

# Nouvelle approche : créer un DSN complet
DSN="host=${PGHOST} port=${PGPORT} user=${PGUSER} password=${PGPASSWORD} dbname=${PGDATABASE} sslmode=require"

echo "DSN: ${DSN}"

# Démarrer Odoo en spécifiant explicitement le DSN
exec odoo \
  -d ${PGDATABASE} \
  --without-demo=all \
  --log-level=debug \
  --http-port=8069 \
  --http-interface=0.0.0.0
