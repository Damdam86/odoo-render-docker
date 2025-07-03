#!/bin/bash

echo "🚀 Starting Odoo with custom Render PostgreSQL config..."

exec odoo \
  --db_host=${PGHOST} \
  --db_port=${PGPORT} \
  --db_user=${PGUSER} \
  --db_password=${PGPASSWORD} \
  -i base \
  --without-demo=all
