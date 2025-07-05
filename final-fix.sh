#!/bin/bash
set -e

echo "🔥 SOLUTION DÉFINITIVE - FORCE INITIALISATION"
echo "🎯 Nom de base FIXE: odoo_w4ch_h23r (pas de détection)"

# Pas de détection, on SAIT que la base s'appelle odoo_w4ch_h23r
DB_NAME="odoo_w4ch_h23r"

echo "⚡ ÉTAPE 1: Initialisation FORCÉE de la base"
echo "🎯 Base: $DB_NAME"

# FORCE l'initialisation avec le nom correct
/usr/bin/odoo \
    --database="$DB_NAME" \
    --init=base \
    --stop-after-init \
    --without-demo=all \
    --workers=0 \
    --logfile=- || echo "Initialisation échouée, on continue..."

echo "✅ ÉTAPE 2: Démarrage serveur web"
echo "🌐 Port: 8069 - Interface: 0.0.0.0"

# Démarrage du serveur avec la base initialisée
exec /usr/bin/odoo \
    --database="$DB_NAME" \
    --http-interface=0.0.0.0 \
    --http-port=8069 \
    --workers=0 \
    --logfile=- \
    --no-database-list