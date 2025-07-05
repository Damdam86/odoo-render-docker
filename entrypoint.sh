#!/bin/bash
set -e

echo "🚀 Démarrage d'Odoo CRM..."

# Variables d'environnement
DB_HOST="${DB_HOST:-localhost}"
DB_PORT="${DB_PORT:-5432}"
DB_USER="${DB_USER:-odoo}"
DB_PASSWORD="${DB_PASSWORD:-}"
ODOO_RC="${ODOO_RC:-/etc/odoo/odoo.conf}"

# Attendre que PostgreSQL soit prêt
echo "⏳ Attente de PostgreSQL..."
until pg_isready -h "$DB_HOST" -p "$DB_PORT" -U "$DB_USER" >/dev/null 2>&1; do
    echo "En attente de PostgreSQL..."
    sleep 2
done
echo "✅ PostgreSQL est prêt !"

# Obtenir le nom de la base de données automatiquement
echo "🔍 Détection du nom de la base de données..."
DB_NAME=$(psql -h "$DB_HOST" -p "$DB_PORT" -U "$DB_USER" -t -c "SELECT datname FROM pg_database WHERE datname != 'template0' AND datname != 'template1' AND datname != 'postgres' LIMIT 1;" 2>/dev/null | xargs || echo "odoo")

echo "🎯 Base de données détectée : $DB_NAME"

# Vérifier si la base est initialisée
TABLE_COUNT=$(psql -h "$DB_HOST" -p "$DB_PORT" -U "$DB_USER" -d "$DB_NAME" -t -c "SELECT COUNT(*) FROM information_schema.tables WHERE table_name = 'ir_module_module';" 2>/dev/null | xargs || echo "0")

if [ "$TABLE_COUNT" -eq "0" ]; then
    echo "🔧 Base de données non initialisée - Initialisation en cours..."
    
    # Forcer l'initialisation avec tous les modules essentiels
    /usr/bin/odoo \
        -c "$ODOO_RC" \
        -d "$DB_NAME" \
        -i base,web,mail,contacts,crm,sale,account,calendar,hr,project \
        --without-demo=all \
        --stop-after-init \
        --db-filter=".*" \
        --log-level=info
    
    if [ $? -eq 0 ]; then
        echo "✅ Initialisation terminée avec succès"
    else
        echo "❌ Échec de l'initialisation - Tentative avec base seulement"
        /usr/bin/odoo \
            -c "$ODOO_RC" \
            -d "$DB_NAME" \
            -i base \
            --without-demo=all \
            --stop-after-init \
            --db-filter=".*" \
            --log-level=info
    fi
else
    echo "✅ Base de données déjà initialisée"
fi

# Démarrer Odoo
echo "🌐 Démarrage du serveur Odoo..."
echo "🔗 URL : http://localhost:8069"
echo "📊 Base : $DB_NAME"

exec /usr/bin/odoo \
    -c "$ODOO_RC" \
    -d "$DB_NAME" \
    --db-filter=".*"
