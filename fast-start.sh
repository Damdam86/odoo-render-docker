#!/bin/bash
set -e

echo "⚡ DÉMARRAGE IMMÉDIAT - PORT 8069 EN PRIORITÉ"
echo "🎯 Objectif: Ouvrir le port AVANT tout le reste"

# Pas de vérification PostgreSQL, pas d'attente, juste démarrer !
echo "🚀 DÉMARRAGE IMMÉDIAT ODOO"
echo "🌐 Port 8069 va s'ouvrir MAINTENANT"

# Démarrage direct avec nom de base fixe
exec /usr/bin/odoo \
    --http-interface=0.0.0.0 \
    --http-port=8069 \
    --workers=0 \
    --logfile=- \
    --no-database-list