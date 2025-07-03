#!/bin/bash

echo "🚀 Starting Odoo with custom Render configuration..."

exec odoo \
  -d ${PGDATABASE} \
  --db_host=${PGHOST} \
  --db_port=${PGPORT} \
  --db_user=${PGUSER} \
  --db_password=${PGPASSWORD} \
  -i base \
  --without-demo=all \
  --log-level=debug
