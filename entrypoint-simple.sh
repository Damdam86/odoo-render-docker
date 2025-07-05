#!/bin/bash
set -e

echo "🚨 ODOO CRM - DÉMARRAGE GARANTI"

# Variables avec valeurs par défaut
DB_HOST="${DB_HOST:-localhost}"
DB_PORT="${DB_PORT:-5432}"
DB_USER="${DB_USER:-odoo}"
ODOO_RC="${ODOO_RC:-/etc/odoo/odoo.conf}"
PORT="${PORT:-8069}"

echo "📋 Configuration:"
echo "   - Port: $PORT"
echo "   - DB: $DB_USER@$DB_HOST:$DB_PORT"
echo "   - Config: $ODOO_RC"

# Attendre PostgreSQL avec timeout
echo "⏳ Attente PostgreSQL (max 60s)..."
timeout=60
while [ $timeout -gt 0 ]; do
    if pg_isready -h "$DB_HOST" -p "$DB_PORT" -U "$DB_USER" >/dev/null 2>&1; then
        echo "✅ PostgreSQL connecté!"
        break
    fi
    echo "   Tentative dans $timeout secondes..."
    sleep 2
    timeout=$((timeout - 2))
done

if [ $timeout -le 0 ]; then
    echo "❌ TIMEOUT PostgreSQL - Arrêt"
    exit 1
fi

# Détecter le nom de la base de données
echo "🔍 Détection de la base de données..."
DB_NAME=$(psql -h "$DB_HOST" -p "$DB_PORT" -U "$DB_USER" -l -t 2>/dev/null | grep -v template | grep -v postgres | head -1 | awk '{print $1}' | xargs || echo "odoo")
echo "🎯 Base détectée: '$DB_NAME'"

# Nettoyer et réinitialiser complètement
echo "🗑️  NETTOYAGE RADICAL de la base de données..."
psql -h "$DB_HOST" -p "$DB_PORT" -U "$DB_USER" -d "$DB_NAME" -c "DROP SCHEMA IF EXISTS public CASCADE; CREATE SCHEMA public;" 2>/dev/null || true

# Installation massive avec gestion d'erreur
echo "🔧 INSTALLATION COMPLÈTE des modules Odoo..."
echo "   (Cette étape peut prendre 10-15 minutes)"

/usr/bin/odoo \
    --config="$ODOO_RC" \
    --database="$DB_NAME" \
    --init=base,web,mail,contacts,crm,sale,account \
    --without-demo=all \
    --stop-after-init \
    --db-filter=".*" \
    --logfile=- \
    || {
        echo "❌ Échec installation complète, tentative BASE seulement..."
        /usr/bin/odoo \
            --config="$ODOO_RC" \
            --database="$DB_NAME" \
            --init=base \
            --without-demo=all \
            --stop-after-init \
            --db-filter=".*" \
            --logfile=-
    }

echo "✅ Installation terminée!"

# Vérification que la base est bien initialisée
echo "🔍 Vérification de l'installation..."
TABLE_COUNT=$(psql -h "$DB_HOST" -p "$DB_PORT" -U "$DB_USER" -d "$DB_NAME" -t -c "SELECT COUNT(*) FROM information_schema.tables WHERE table_schema = 'public';" 2>/dev/null | xargs || echo "0")
echo "📊 Tables créées: $TABLE_COUNT"

if [ "$TABLE_COUNT" -lt "10" ]; then
    echo "❌ ERREUR: Installation incomplète"
    exit 1
fi

# Démarrage final avec binding explicite du port
echo "🚀 DÉMARRAGE FINAL d'Odoo CRM"
echo "🌐 Port: $PORT"
echo "📊 Base: $DB_NAME"
echo "🔑 Accès: admin / admin"

exec /usr/bin/odoo \
    --config="$ODOO_RC" \
    --database="$DB_NAME" \
    --db-filter=".*" \
    --logfile=- \
    --http-interface=0.0.0.0 \
    --http-port="$PORT"