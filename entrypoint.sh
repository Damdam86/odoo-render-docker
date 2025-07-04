#!/bin/bash
set -e

# Première initialisation si la base est vide
if [ ! -f "/etc/odoo/.initialized" ]; then
    echo "🔧 Initialisation de Odoo avec tous les modules..."
    /usr/bin/odoo -i all --without-demo=all
    touch /etc/odoo/.initialized
else
    echo "🚀 Lancement standard de Odoo"
    /usr/bin/odoo
fi
