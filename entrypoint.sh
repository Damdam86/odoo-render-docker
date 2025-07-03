#!/bin/bash

echo "🚀 Starting Odoo with custom Supabase configuration..."

exec odoo \
  --db_host=db.dkdrcflwmdkngitketzm.supabase.co \
  --db_port=5432 \
  --db_user=odoo_user \
  --db_password=OdooSafe123! \
  -i base \
  --without-demo=all
