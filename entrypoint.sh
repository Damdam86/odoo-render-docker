#!/bin/bash

echo "⚙️ Installing Odoo base module..."

exec odoo \
  -d odoo_w4ch \
  --db_host=${PGHOST} \
  --db_port=${PGPORT} \
  --db_user=${PGUSER} \
  --db_password=${PGPASSWORD} \
  -i base \
  --without-demo=all \
  --log-level=debug
