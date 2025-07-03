#!/bin/bash

echo "🚀 Starting Odoo with custom Supabase configuration..."

exec odoo \
  --db_host=db.dkdrcflwmdkngitketzm.supabase.co \
  --db_port=5432 \
  --db_user=postgres \
  --db_password=Damdam86!? \
  --db_name=postgres \
  -i base \
  --without-demo=all
