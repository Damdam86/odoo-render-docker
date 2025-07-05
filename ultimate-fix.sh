#!/bin/bash
set -e

echo "🚀 SOLUTION ULTIME - DÉMARRAGE AVEC AUTO-INIT"
echo "🎯 Base: odoo_w4ch_h23r"
echo "🌐 Port 8069 OUVERT immédiatement"

# Démarrage IMMÉDIAT avec auto-initialisation
# Le port s'ouvre immédiatement, l'initialisation se fait en arrière-plan
exec /usr/bin/odoo \
    --database=odoo_w4ch_h23r \
    --http-interface=0.0.0.0 \
    --http-port=8069 \
    --workers=0 \
    --logfile=- \
    --no-database-list \
    --without-demo=all