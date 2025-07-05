#!/bin/bash

echo "🚀 Déploiement Odoo CRM sur VPS"
echo "================================"

# Variables à personnaliser
DOMAIN="votre-domaine.com"
EMAIL="votre-email@example.com"
ODOO_PASSWORD="votre-mot-de-passe-secure"

echo "📋 Configuration détectée :"
echo "   Domaine: $DOMAIN"
echo "   Email: $EMAIL"
echo ""

# Vérifier les prérequis
echo "🔍 Vérification des prérequis..."

# Installer Docker si nécessaire
if ! command -v docker &> /dev/null; then
    echo "🐳 Installation de Docker..."
    curl -fsSL https://get.docker.com -o get-docker.sh
    sudo sh get-docker.sh
    sudo usermod -aG docker $USER
    rm get-docker.sh
else
    echo "✅ Docker est déjà installé"
fi

# Installer Docker Compose si nécessaire
if ! command -v docker-compose &> /dev/null; then
    echo "🐳 Installation de Docker Compose..."
    sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
else
    echo "✅ Docker Compose est déjà installé"
fi

# Installer Nginx si nécessaire
if ! command -v nginx &> /dev/null; then
    echo "🌐 Installation de Nginx..."
    sudo apt update
    sudo apt install -y nginx
else
    echo "✅ Nginx est déjà installé"
fi

# Installer Certbot si nécessaire
if ! command -v certbot &> /dev/null; then
    echo "🔒 Installation de Certbot..."
    sudo apt install -y certbot python3-certbot-nginx
else
    echo "✅ Certbot est déjà installé"
fi

# Créer le fichier de configuration Nginx
echo "🌐 Configuration de Nginx..."
sudo tee /etc/nginx/sites-available/odoo << EOF
server {
    listen 80;
    server_name $DOMAIN;
    
    location / {
        proxy_pass http://localhost:8069;
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto \$scheme;
        proxy_redirect off;
    }
    
    location /longpolling {
        proxy_pass http://localhost:8072;
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto \$scheme;
        proxy_redirect off;
    }
}
EOF

# Activer le site
sudo ln -sf /etc/nginx/sites-available/odoo /etc/nginx/sites-enabled/
sudo nginx -t && sudo systemctl reload nginx

# Créer docker-compose.yml pour VPS
echo "🐳 Création de docker-compose.yml pour VPS..."
cat > docker-compose-vps.yml << EOF
version: '3.8'

services:
  postgres:
    image: postgres:15
    environment:
      - POSTGRES_DB=odoo
      - POSTGRES_USER=odoo
      - POSTGRES_PASSWORD=$ODOO_PASSWORD
    volumes:
      - postgres_data:/var/lib/postgresql/data
    restart: unless-stopped
    
  odoo:
    image: odoo:17
    depends_on:
      - postgres
    environment:
      - HOST=postgres
      - USER=odoo
      - PASSWORD=$ODOO_PASSWORD
    volumes:
      - odoo_data:/var/lib/odoo
      - ./addons:/mnt/extra-addons
      - ./config:/etc/odoo
    ports:
      - "8069:8069"
      - "8072:8072"
    restart: unless-stopped
    command: odoo -d odoo

volumes:
  postgres_data:
  odoo_data:
EOF

# Démarrer les services
echo "🚀 Démarrage des services..."
docker-compose -f docker-compose-vps.yml up -d

echo "⏳ Attente du démarrage d'Odoo..."
sleep 30

# Configurer SSL avec Let's Encrypt
echo "🔒 Configuration SSL avec Let's Encrypt..."
sudo certbot --nginx -d $DOMAIN --email $EMAIL --agree-tos --non-interactive

# Configurer le renouvellement automatique
echo "🔄 Configuration du renouvellement automatique SSL..."
echo "0 12 * * * /usr/bin/certbot renew --quiet" | sudo crontab -

echo ""
echo "🎉 Déploiement terminé avec succès !"
echo ""
echo "🌐 Votre Odoo CRM est accessible à :"
echo "   https://$DOMAIN"
echo ""
echo "📊 Informations de connexion :"
echo "   Base de données: odoo"
echo "   Utilisateur: admin"
echo "   Mot de passe: admin"
echo ""
echo "🔒 SSL configuré avec Let's Encrypt"
echo "🔄 Renouvellement automatique activé"
echo ""
echo "📝 Commandes utiles :"
echo "   docker-compose -f docker-compose-vps.yml ps"
echo "   docker-compose -f docker-compose-vps.yml logs -f"
echo "   docker-compose -f docker-compose-vps.yml restart"
echo "   sudo nginx -t && sudo systemctl reload nginx"
echo ""
echo "🎊 Votre CRM Odoo est prêt à être utilisé !"