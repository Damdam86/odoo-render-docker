#!/bin/bash
set -e

echo "🔧 SCRIPT DE CORRECTION FORCÉE - Odoo CRM"

# Variables
DB_HOST="${DB_HOST:-localhost}"
DB_PORT="${DB_PORT:-5432}"
DB_USER="${DB_USER:-odoo}"
ODOO_RC="${ODOO_RC:-/etc/odoo/odoo.conf}"

echo "⏳ Attente PostgreSQL..."
while ! pg_isready -h "$DB_HOST" -p "$DB_PORT" -U "$DB_USER" >/dev/null 2>&1; do
    sleep 1
done
echo "✅ PostgreSQL OK"

# Détecter le nom de la base
DB_NAME=$(psql -h "$DB_HOST" -p "$DB_PORT" -U "$DB_USER" -l -t | grep -v template | grep -v postgres | head -1 | awk '{print $1}' | xargs)
echo "🎯 Base détectée: $DB_NAME"

# Vérifier si les tables Odoo existent
TABLE_COUNT=$(psql -h "$DB_HOST" -p "$DB_PORT" -U "$DB_USER" -d "$DB_NAME" -t -c "SELECT COUNT(*) FROM information_schema.tables WHERE table_name LIKE 'ir_%';" 2>/dev/null | xargs || echo "0")

echo "📊 Tables Odoo trouvées: $TABLE_COUNT"

if [ "$TABLE_COUNT" -lt "10" ]; then
    echo "🚨 PROBLÈME DÉTECTÉ: Base mal initialisée"
    echo "🔧 SOLUTION: Suppression et recréation complète"
    
    # Supprimer toutes les tables pour forcer la réinitialisation
    echo "�️  Nettoyage des tables existantes..."
    psql -h "$DB_HOST" -p "$DB_PORT" -U "$DB_USER" -d "$DB_NAME" -c "DROP SCHEMA public CASCADE; CREATE SCHEMA public;" 2>/dev/null || true
    
    echo "🔧 ÉTAPE 1: Initialisation base avec module BASE"
    /usr/bin/odoo \
        -c "$ODOO_RC" \
        -d "$DB_NAME" \
        -i base \
        --without-demo=all \
        --stop-after-init \
        --db-filter=".*" \
        --log-level=warn
    
    echo "🔧 ÉTAPE 2: Installation module WEB (essentiel pour ir.http)"
    /usr/bin/odoo \
        -c "$ODOO_RC" \
        -d "$DB_NAME" \
        -i web \
        --without-demo=all \
        --stop-after-init \
        --db-filter=".*" \
        --log-level=warn
    
    echo "🔧 ÉTAPE 3: Installation modules CRM"
    /usr/bin/odoo \
        -c "$ODOO_RC" \
        -d "$DB_NAME" \
        -i mail,contacts,crm \
        --without-demo=all \
        --stop-after-init \
        --db-filter=".*" \
        --log-level=warn
    
    # Vérification finale
    FINAL_COUNT=$(psql -h "$DB_HOST" -p "$DB_PORT" -U "$DB_USER" -d "$DB_NAME" -t -c "SELECT COUNT(*) FROM information_schema.tables WHERE table_name LIKE 'ir_%';" 2>/dev/null | xargs || echo "0")
    echo "� Tables après initialisation: $FINAL_COUNT"
    
    if [ "$FINAL_COUNT" -gt "10" ]; then
        echo "✅ SUCCÈS: Base correctement initialisée"
    else
        echo "❌ ÉCHEC: Problème persistant"
        exit 1
    fi
else
    echo "✅ Base déjà correctement initialisée"
fi

echo "🚀 DÉMARRAGE FINAL du serveur Odoo..."
echo "🌐 URL: Votre URL Render"
echo "📊 Base: $DB_NAME"
echo "🔑 Login: admin / admin"

exec /usr/bin/odoo \
    -c "$ODOO_RC" \
    -d "$DB_NAME" \
    --db-filter=".*" \
    --log-level=info