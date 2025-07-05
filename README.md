# 🚀 Odoo CRM - Déploiement Complet (Local & Cloud)

> **Solution complète pour déployer Odoo CRM 17 localement et en ligne**

## 🎯 Options de déploiement

### 💻 **Déploiement local**
```bash
./deploy_odoo.sh        # Déploiement automatique
./deploy_manual.sh      # Guide étape par étape
```

### 🌐 **Déploiement en ligne**
| Plateforme | Coût | Facilité | Temps |
|------------|------|----------|--------|
| **Render** | Gratuit | ⭐⭐⭐⭐⭐ | 5 min |
| **Railway** | $5/mois | ⭐⭐⭐⭐⭐ | 3 min |
| **Heroku** | $7/mois | ⭐⭐⭐⭐ | 10 min |
| **DigitalOcean** | $12/mois | ⭐⭐⭐ | 15 min |
| **VPS** | €5/mois | ⭐⭐ | 30 min |

## 🔗 Déploiement en un clic

### 🚀 Render (Gratuit)
[![Deploy to Render](https://render.com/images/deploy-to-render-button.svg)](https://render.com/deploy)

### 🚄 Railway (Moderne)
[![Deploy on Railway](https://railway.app/button.svg)](https://railway.app/new/template)

### 🟣 Heroku (Classique)
[![Deploy to Heroku](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy)

## 📦 Contenu du Projet

### 🏠 Déploiement Local
- `docker-compose.yml` : Configuration Docker complète
- `config/odoo.conf` : Configuration Odoo locale
- `deploy_odoo.sh` : Script de déploiement automatique
- `deploy_manual.sh` : Guide de déploiement étape par étape

### 🌐 Déploiement Cloud
- `Dockerfile` : Image Docker pour le cloud
- `entrypoint.sh` : Script d'initialisation
- `railway.json` : Configuration Railway
- `app.json` : Configuration Heroku
- `app.yaml` : Configuration DigitalOcean
- `deploy_vps.sh` : Script de déploiement VPS avec SSL

### 📚 Documentation
- `README.md` : Ce fichier
- `DEPLOIEMENT_CLOUD.md` : Guide des options cloud
- `DEPLOIEMENT_ETAPE_PAR_ETAPE.md` : Guide détaillé
- `DEPLOIEMENT_ODOO_RESUME.md` : Résumé complet

## 🚀 Démarrage Rapide

### 1. **Déploiement local (Docker)**
```bash
# Cloner le projet
git clone https://github.com/votre-username/odoo-crm.git
cd odoo-crm

# Déployer automatiquement
./deploy_odoo.sh

# Accéder à Odoo
http://localhost:8069
```

### 2. **Déploiement cloud (Render)**
1. Fork ce repository
2. Créer un compte sur [Render](https://render.com)
3. Créer une base PostgreSQL gratuite
4. Déployer le service web avec ce repository
5. Configurer les variables d'environnement
6. Accéder à votre URL Render

### 3. **Déploiement VPS (avec SSL)**
```bash
# Sur votre VPS
git clone https://github.com/votre-username/odoo-crm.git
cd odoo-crm

# Configurer le domaine dans deploy_vps.sh
nano deploy_vps.sh

# Déployer avec SSL automatique
./deploy_vps.sh

# Accéder à votre domaine
https://votre-domaine.com
```

## 🌐 Accès à Odoo CRM

### 📊 Informations de connexion
- **Database**: `odoo` (ou créer une nouvelle)
- **Username**: `admin`
- **Password**: `admin` (par défaut)

### 🎯 Fonctionnalités CRM incluses
- ✅ Gestion des contacts et leads
- ✅ Suivi des opportunités commerciales
- ✅ Devis et commandes
- ✅ Facturation intégrée
- ✅ Calendrier et activités
- ✅ Rapports et analyses
- ✅ Emails et communications
- ✅ Gestion des équipes commerciales

## 🛠️ Personnalisation

### 🔧 Configuration
- Modifier `config/odoo.conf` pour les paramètres locaux
- Adapter les variables d'environnement pour le cloud
- Ajouter des modules dans le dossier `addons/`

### 📈 Performances
- **Local**: 2GB RAM minimum
- **Cloud**: Plans recommandés configurés
- **VPS**: 2GB RAM, 1 CPU, 20GB SSD

## 📝 Commandes Utiles

### 🐳 Docker (Local)
```bash
docker-compose ps              # Voir le statut
docker-compose logs -f         # Voir les logs
docker-compose down           # Arrêter
docker-compose restart        # Redémarrer
```

### 🌐 Cloud
```bash
# Render
render logs -s votre-service

# Railway
railway logs

# Heroku
heroku logs --tail
```

## 🎯 Recommandations

### 💡 **Pour débuter**
→ **Render** (gratuit, facile, 5 minutes)

### 🏢 **Pour une entreprise**
→ **Railway** ou **DigitalOcean** (fiable, support)

### 🚀 **Pour des performances**
→ **VPS** (contrôle total, SSL inclus)

### 💰 **Pour un budget serré**
→ **Render** (gratuit) ou **Contabo VPS** (€5/mois)

## � Support

### 📚 Guides détaillés
- `DEPLOIEMENT_CLOUD.md` : Comparaison des plateformes
- `DEPLOIEMENT_ETAPE_PAR_ETAPE.md` : Guide complet
- `DEPLOIEMENT_ODOO_RESUME.md` : Résumé technique

### 🔧 Dépannage
- Vérifiez les logs de votre plateforme
- Contrôlez les variables d'environnement
- Assurez-vous que la base de données est accessible

## � Félicitations !

Votre CRM Odoo est maintenant accessible ! 🚀

**Prochaines étapes :**
1. Configurer vos modules CRM
2. Importer vos contacts
3. Personnaliser les workflows
4. Former votre équipe

---

## 🏆 Fonctionnalités

### ✅ **Déploiement local**
- Docker Compose prêt à l'emploi
- PostgreSQL inclus
- Configuration optimisée
- Scripts automatisés

### ✅ **Déploiement cloud**
- 5 plateformes supportées
- Configurations prêtes
- SSL automatique (VPS)
- Bases de données incluses

### ✅ **CRM complet**
- Odoo 17 dernière version
- Tous les modules CRM
- Interface moderne
- Rapports intégrés

**Votre solution CRM professionnelle est prête !** 🎊

---

*Pour plus d'informations, consultez la [documentation officielle Odoo](https://www.odoo.com/documentation/17.0/)*
