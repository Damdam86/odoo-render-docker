# 🚀 Déploiement Odoo CRM - Configuration Complète

Ce projet vous permet de déployer facilement Odoo CRM avec PostgreSQL en utilisant Docker et docker-compose.

## 🎯 Déploiement Rapide

### Option 1: Script automatique (Recommandé)
```bash
./deploy_odoo.sh
```

### Option 2: Commandes manuelles
```bash
# Démarrer Docker si nécessaire
sudo dockerd --host=unix:///var/run/docker.sock --host=tcp://0.0.0.0:2376 &

# Démarrer les services
docker-compose up -d

# Voir les logs
docker-compose logs -f
```

## 📦 Contenu du Projet

- `docker-compose.yml` : Configuration complète Odoo + PostgreSQL
- `config/odoo.conf` : Configuration Odoo optimisée
- `deploy_odoo.sh` : Script de déploiement automatique
- `.env` : Variables d'environnement personnalisables
- `addons/` : Dossier pour vos modules personnalisés
- `Dockerfile` : Image Odoo personnalisée (pour Render)
- `entrypoint.sh` : Script d'entrée pour Render
- `odoo.conf` : Configuration Odoo pour Render

## 🌐 Accès à Odoo CRM

Une fois déployé, accédez à votre instance Odoo :

- **URL** : http://localhost:8069
- **Base de données** : odoo
- **Utilisateur** : admin
- **Mot de passe** : admin (par défaut)

## 🗄️ Accès à PostgreSQL

- **Host** : localhost
- **Port** : 5432
- **Database** : odoo
- **User** : odoo
- **Password** : odoo_password

## 📝 Commandes Utiles

```bash
# Voir le statut des services
docker-compose ps

# Voir les logs en temps réel
docker-compose logs -f

# Arrêter les services
docker-compose down

# Redémarrer les services
docker-compose restart

# Supprimer complètement (données incluses)
docker-compose down -v
```

## 🛠️ Personnalisation

### Modifier les variables d'environnement
Éditez le fichier `.env` pour changer les mots de passe et ports.

### Ajouter des modules
Placez vos modules personnalisés dans le dossier `addons/`.

### Modifier la configuration
Éditez `config/odoo.conf` pour ajuster les paramètres d'Odoo.

## 🔧 Déploiement sur Render

Cette configuration inclut aussi les fichiers nécessaires pour déployer sur Render :

1. Créer un nouveau service Web sur Render
2. Sélectionner ce repo comme source
3. Port : `8069`
4. Commande de démarrage : **laisser vide**

## 📋 Pré-requis

- Docker et docker-compose installés
- Ports 8069 et 5432 disponibles
- Au moins 2GB de RAM disponible

## 🆘 Dépannage

### Docker ne démarre pas
```bash
sudo dockerd --host=unix:///var/run/docker.sock --host=tcp://0.0.0.0:2376 &
```

### Problème de permissions
```bash
sudo chown -R $USER:$USER ./addons ./config
```

### Réinitialiser la base de données
```bash
docker-compose down -v
docker-compose up -d
```

## 🎉 Félicitations !

Votre instance Odoo CRM est maintenant prête à être utilisée ! 🎊

Pour plus d'informations sur l'utilisation d'Odoo, consultez la [documentation officielle](https://www.odoo.com/documentation/17.0/).
