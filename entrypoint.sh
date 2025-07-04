#!/bin/bash
echo "🚀 Starting Odoo with Render configuration..."

echo "🔒 PostgreSQL SSL config:"
echo "PGHOST=$PGHOST"
echo "PGPORT=$PGPORT"
echo "PGUSER=$PGUSER"
echo "PGPASSWORD=$PGPASSWORD"
echo "PGDATABASE=$PGDATABASE"

if [ -z "$PGHOST" ] || [ -z "$PGPORT" ] || [ -z "$PGUSER" ] || [ -z "$PGPASSWORD" ] || [ -z "$PGDATABASE" ]; then
  echo "❌ Missing database environment variables!"
  exit 1
fi

# Génération du fichier odoo.conf à la volée
cat <<EOF > /etc/odoo/odoo.conf
[options]
db_host = ${PGHOST}
db_port = ${PGPORT}
db_user = ${PGUSER}
db_password = ${PGPASSWORD}
db_name = ${PGDATABASE}
db_sslmode = require
addons_path = /mnt/extra-addons,/usr/lib/python3/dist-packages/odoo/addons
without_demo = all
admin_passwd = admin
log_level = debug
EOF

# Démarrage d'Odoo
exec odoo --config=/etc/odoo/odoo.conf
