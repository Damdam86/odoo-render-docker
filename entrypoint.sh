#!/bin/bash
echo "🚀 Starting Odoo with optimized configuration..."

echo "Database config:"
echo "Host: $PGHOST"
echo "Port: $PGPORT"
echo "User: $PGUSER"
echo "Database: $PGDATABASE"

echo "🚀 Starting optimized Odoo..."

exec odoo \
  --db_host=${PGHOST} \
  --db_port=${PGPORT} \
  --db_user=${PGUSER} \
  --db_password=${PGPASSWORD} \
  --database=${PGDATABASE} \
  --without-demo=all \
  --log-level=warn \
  --http-port=8069 \
  --http-interface=0.0.0.0 \
  --workers=2 \
  --max-cron-threads=1 \
  --limit-memory-hard=1073741824 \
  --limit-memory-soft=838860800 \
  --limit-request=8192 \
  --limit-time-cpu=600 \
  --limit-time-real=1200 \
  --db-filter=^${PGDATABASE}$ \
  --proxy-mode
