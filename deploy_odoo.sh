#!/bin/bash

echo "🚀 Démarrage du déploiement d'Odoo CRM..."

# Vérifier si Docker est en cours d'exécution
if ! docker version > /dev/null 2>&1; then
    echo "❌ Docker n'est pas en cours d'exécution. Tentative de démarrage..."
    sudo dockerd --host=unix:///var/run/docker.sock --host=tcp://0.0.0.0:2376 > /dev/null 2>&1 &
    sleep 5
    
    if ! docker version > /dev/null 2>&1; then
        echo "❌ Impossible de démarrer Docker. Veuillez le démarrer manuellement."
        exit 1
    fi
fi

echo "✅ Docker est opérationnel"

# Arrêter les conteneurs existants si ils existent
echo "🔄 Arrêt des conteneurs existants..."
docker-compose down 2>/dev/null || true

# Démarrer les services
echo "🔄 Démarrage des services Odoo CRM..."
docker-compose up -d

echo "⏳ Attente du démarrage des services..."
sleep 10

# Vérifier le statut des services
echo "📊 Statut des services:"
docker-compose ps

echo ""
echo "🎉 Déploiement terminé !"
echo ""
echo "🌐 Accès à Odoo CRM:"
echo "   URL: http://localhost:8069"
echo "   Base de données: odoo"
echo "   Utilisateur: admin"
echo "   Mot de passe: admin (par défaut)"
echo ""
echo "🗄️ Accès PostgreSQL:"
echo "   Host: localhost"
echo "   Port: 5432"
echo "   Database: odoo"
echo "   User: odoo"
echo "   Password: odoo_password"
echo ""
echo "📝 Commandes utiles:"
echo "   - Voir les logs: docker-compose logs -f"
echo "   - Arrêter: docker-compose down"
echo "   - Redémarrer: docker-compose restart"
echo "   - Voir le statut: docker-compose ps"
echo ""
echo "📚 Pour configurer Odoo CRM, accédez à http://localhost:8069"
echo "   et suivez l'assistant de configuration."