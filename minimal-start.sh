#!/bin/bash
set -e

echo "🚀 ODOO MINIMAL - PARAMÈTRES RÉSEAU TESTÉS ✅"
echo "🌐 Interface: 0.0.0.0:8069 (VALIDÉ PAR LE TEST)"

# Démarrage IMMÉDIAT avec paramètres réseau IDENTIQUES au test qui fonctionne
echo "⚡ DÉMARRAGE ODOO - MÊMES PARAMÈTRES QUE LE TEST"

exec /usr/bin/odoo \
    --http-interface=0.0.0.0 \
    --http-port=8069 \
    --workers=0 \
    --logfile=- \
    --no-database-list