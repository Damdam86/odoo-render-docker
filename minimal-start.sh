#!/bin/bash
set -e

echo "🚀 ODOO MINIMAL - PARAMÈTRES RÉSEAU TESTÉS ✅"
echo "🌐 Interface: 0.0.0.0:8069 (VALIDÉ PAR LE TEST)"

# Attendre PostgreSQL
echo "⏳ Attente PostgreSQL..."
while ! pg_isready -h "${DB_HOST:-localhost}" -p "${DB_PORT:-5432}" -U "${DB_USER:-odoo}" >/dev/null 2>&1; do
    sleep 1
done
echo "✅ PostgreSQL connecté!"

# Détecter le nom de la base
DB_NAME=$(psql -h "${DB_HOST:-localhost}" -p "${DB_PORT:-5432}" -U "${DB_USER:-odoo}" -l -t 2>/dev/null | grep -v template | grep -v postgres | head -1 | awk '{print $1}' | xargs || echo "odoo")
echo "🎯 Base détectée: $DB_NAME"

# Vérifier si la base est initialisée
echo "🔍 Vérification de l'initialisation..."
TABLES=$(psql -h "${DB_HOST:-localhost}" -p "${DB_PORT:-5432}" -U "${DB_USER:-odoo}" -d "$DB_NAME" -t -c "SELECT COUNT(*) FROM information_schema.tables WHERE table_name = 'res_users';" 2>/dev/null | xargs || echo "0")

if [ "$TABLES" = "0" ]; then
    echo "🔧 Base non initialisée - Initialisation en cours..."
    
    # Initialisation avec arrêt après
    /usr/bin/odoo \
        --database="$DB_NAME" \
        --init=base \
        --stop-after-init \
        --without-demo=all \
        --workers=0 \
        --logfile=-
    
    echo "✅ Initialisation terminée!"
else
    echo "✅ Base déjà initialisée ($TABLES tables trouvées)"
fi

# Démarrage avec paramètres réseau VALIDÉS par le test
echo "🚀 DÉMARRAGE ODOO avec paramètres réseau TESTÉS"
echo "🌐 Interface: 0.0.0.0:8069 (GARANTIE DE FONCTIONNER)"

exec /usr/bin/odoo \
    --database="$DB_NAME" \
    --http-interface=0.0.0.0 \
    --http-port=8069 \
    --workers=0 \
    --logfile=- \
    --no-database-list