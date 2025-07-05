THIS SHOULD BE A LINTER ERROR#!/bin/bash
set -e

# Configuration
ODOO_RC="${ODOO_RC:-/etc/odoo/odoo.conf}"
INIT_MARKER="/var/lib/odoo/.initialized"

# Fonction pour attendre que PostgreSQL soit prêt
wait_for_postgres() {
    echo "⏳ Attente de la base de données PostgreSQL..."
    until pg_isready -h "${DB_HOST:-localhost}" -p "${DB_PORT:-5432}" -U "${DB_USER:-odoo}"; do
        echo "En attente de PostgreSQL..."
        sleep 2
    done
    echo "✅ PostgreSQL est prêt !"
}

# Fonction d'initialisation
init_odoo() {
    echo "🔧 Initialisation de Odoo avec le module 'base'..."
    
    # Créer la base de données et installer le module base
    /usr/bin/odoo \
        -c "$ODOO_RC" \
        -d "${DB_NAME:-odoo}" \
        -i base \
        --without-demo=all \
        --stop-after-init \
        --db-filter="^${DB_NAME:-odoo}$"
    
    if [ $? -eq 0 ]; then
        echo "✅ Initialisation terminée avec succès"
        touch "$INIT_MARKER"
        return 0
    else
        echo "❌ Échec de l'initialisation"
        return 1
    fi
}

# Démarrage principal
echo "🚀 Démarrage d'Odoo CRM..."
echo "📋 Configuration utilisée : $ODOO_RC"

# Attendre PostgreSQL
wait_for_postgres

# Initialiser si nécessaire
if [ ! -f "$INIT_MARKER" ]; then
    init_odoo
    if [ $? -ne 0 ]; then
        echo "❌ Impossible d'initialiser Odoo. Arrêt."
        exit 1
    fi
else
    echo "✅ Odoo déjà initialisé"
fi

# Démarrer Odoo
echo "🌐 Lancement du serveur Odoo..."
exec /usr/bin/odoo \
    -c "$ODOO_RC" \
    -d "${DB_NAME:-odoo}" \
    --db-filter="^${DB_NAME:-odoo}$"
