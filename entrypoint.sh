#!/bin/bash
set -e

# Vérifie si Odoo a déjà été initialisé
if [ ! -f "/etc/odoo/.initialized" ]; then
    echo "🔧 Initialisation de Odoo avec le module 'base'..."
    /usr/bin/odoo -i base --without-demo=all --no-xmlrpc --stop-after-init
    touch /etc/odoo/.initialized
fi

# Lancement normal d'Odoo
echo "🚀 Lancement standard de Odoo"
/usr/bin/odoo
