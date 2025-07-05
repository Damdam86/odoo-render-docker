#!/bin/bash
set -e

echo "🚀 MINIMAL START - PORT 8069 IMMÉDIAT"

# Pas d'attente PostgreSQL, pas de vérification, juste démarrer !
echo "⚡ DÉMARRAGE IMMÉDIAT ODOO"

# Démarrage direct avec paramètres minimaux
exec /usr/bin/odoo \
    --http-interface=0.0.0.0 \
    --http-port=8069 \
    --workers=0 \
    --logfile=- \
    --no-database-list