#!/bin/bash
set -e

INIT_MARKER="/var/lib/odoo/.initialized"

if [ ! -f "$INIT_MARKER" ]; then
    echo "🔧 Initialisation de Odoo avec le module 'base'..."
    /usr/bin/odoo -i base --without-demo=all --stop-after-init
    echo "✅ Initialisation terminée"
    touch "$INIT_MARKER"
fi

echo "🚀 Lancement standard de Odoo"
/usr/bin/odoo
