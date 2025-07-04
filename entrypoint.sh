#!/bin/bash
set -e

INIT_FILE="/var/lib/odoo/.initialized"

# Vérifie si Odoo a déjà été initialisé
if [ ! -f "$INIT_FILE" ]; then
    echo "🔧 Initialisation de Odoo avec le module 'base'..."
    /usr/bin/odoo -i base --without-demo=all --no-xmlrpc --stop-after-init
    touch "$INIT_FILE"
fi

# Lancement normal d'Odoo
echo "🚀 Lancement standard de Odoo"
/usr/bin/odoo
