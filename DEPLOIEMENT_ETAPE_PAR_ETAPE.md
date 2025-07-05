# 🚀 Guide de déploiement étape par étape - Odoo CRM

## 🎯 Choix de la plateforme

| Plateforme | Coût | Facilité | Recommandé pour |
|------------|------|----------|-----------------|
| **Render** | Gratuit | ⭐⭐⭐⭐⭐ | Test & développement |
| **Railway** | $5/mois | ⭐⭐⭐⭐⭐ | Petites entreprises |
| **Heroku** | $7/mois | ⭐⭐⭐⭐ | Projets standards |
| **DigitalOcean** | $12/mois | ⭐⭐⭐ | Entreprises |
| **VPS** | €5/mois | ⭐⭐ | Contrôle total |

---

## 🚀 Option 1: Render (Gratuit et simple)

### 🔗 Déploiement en un clic
[![Deploy to Render](https://render.com/images/deploy-to-render-button.svg)](https://render.com/deploy)

### 📋 Étapes détaillées

1. **Créer un compte Render**
   - Aller sur https://render.com
   - S'inscrire gratuitement
   - Confirmer l'email

2. **Préparer le repository**
   ```bash
   git add .
   git commit -m "Configuration Render"
   git push origin main
   ```

3. **Créer la base de données PostgreSQL**
   - Dans Render Dashboard → "New" → "PostgreSQL"
   - Nom: `odoo-database`
   - Plan: `Free`
   - Copier les informations de connexion

4. **Créer le service Web**
   - "New" → "Web Service"
   - Connecter votre repository GitHub
   - Configuration:
     - **Name**: `odoo-crm`
     - **Environment**: `Docker`
     - **Plan**: `Free`
     - **Port**: `8069`
     - **Build Command**: Laisser vide
     - **Start Command**: Laisser vide

5. **Configurer les variables d'environnement**
   Dans les paramètres du service:
   ```
   DB_HOST=<host-postgres-render>
   DB_PORT=5432
   DB_USER=<user-postgres>
   DB_PASSWORD=<password-postgres>
   DB_NAME=<nom-database>
   ```

6. **Déployer**
   - Cliquer sur "Deploy"
   - Attendre 5-10 minutes
   - Votre URL sera disponible: `https://odoo-crm-xxxx.onrender.com`

---

## 🚄 Option 2: Railway (Moderne et rapide)

### 🔗 Déploiement en un clic
[![Deploy on Railway](https://railway.app/button.svg)](https://railway.app/new/template)

### 📋 Étapes détaillées

1. **Créer un compte Railway**
   - Aller sur https://railway.app
   - S'inscrire avec GitHub
   - Confirmer l'email

2. **Créer un nouveau projet**
   - "New Project" → "Deploy from GitHub repo"
   - Sélectionner votre repository
   - Railway détecte automatiquement le Dockerfile

3. **Ajouter PostgreSQL**
   - Dans votre projet → "New" → "Database" → "PostgreSQL"
   - Railway crée automatiquement la base de données
   - Noter les variables d'environnement générées

4. **Configurer les variables**
   Dans les paramètres du service Odoo:
   ```
   PORT=8069
   DATABASE_HOST=${{Postgres.PGHOST}}
   DATABASE_PORT=${{Postgres.PGPORT}}
   DATABASE_USER=${{Postgres.PGUSER}}
   DATABASE_PASSWORD=${{Postgres.PGPASSWORD}}
   DATABASE_NAME=${{Postgres.PGDATABASE}}
   ADMIN_PASSWORD=admin123
   ```

5. **Déployer**
   - Railway déploie automatiquement
   - Votre URL sera disponible: `https://odoo-crm-production.railway.app`

---

## 🟣 Option 3: Heroku (Classique et fiable)

### 🔗 Déploiement en un clic
[![Deploy to Heroku](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy)

### 📋 Étapes détaillées

1. **Installer Heroku CLI**
   ```bash
   curl https://cli-assets.heroku.com/install.sh | sh
   ```

2. **Se connecter à Heroku**
   ```bash
   heroku login
   ```

3. **Créer l'application**
   ```bash
   heroku create odoo-crm-votre-nom
   ```

4. **Ajouter PostgreSQL**
   ```bash
   heroku addons:create heroku-postgresql:essential-0
   ```

5. **Configurer les variables**
   ```bash
   heroku config:set PORT=8069
   heroku config:set WEB_CONCURRENCY=1
   heroku config:set ADMIN_PASSWORD=admin123
   ```

6. **Déployer**
   ```bash
   git push heroku main
   ```

7. **Ouvrir l'application**
   ```bash
   heroku open
   ```

---

## 🌊 Option 4: DigitalOcean App Platform

### 📋 Étapes détaillées

1. **Créer un compte DigitalOcean**
   - Aller sur https://www.digitalocean.com
   - S'inscrire (bonus $100 pour les nouveaux comptes)

2. **Créer une base de données**
   - "Databases" → "Create Database"
   - PostgreSQL 15
   - Plan: Basic ($15/mois)
   - Région: Frankfurt (Europe)

3. **Créer une App**
   - "Apps" → "Create App"
   - Connecter GitHub
   - Sélectionner votre repository
   - DigitalOcean détecte automatiquement `app.yaml`

4. **Configurer les variables**
   Les variables sont automatiquement configurées via `app.yaml`

5. **Déployer**
   - Cliquer sur "Create Resources"
   - Attendre 10-15 minutes
   - Votre URL sera disponible: `https://odoo-crm-xxxx.ondigitalocean.app`

---

## 🖥️ Option 5: VPS (Contrôle total)

### 📋 Étapes détaillées

1. **Choisir un VPS**
   - **Contabo**: €4.99/mois (recommandé)
   - **Hetzner**: €4.15/mois
   - **DigitalOcean**: $12/mois

2. **Se connecter au VPS**
   ```bash
   ssh root@votre-ip-vps
   ```

3. **Télécharger les fichiers**
   ```bash
   git clone https://github.com/votre-username/odoo-crm.git
   cd odoo-crm
   ```

4. **Configurer le domaine**
   Modifier les variables dans `deploy_vps.sh`:
   ```bash
   DOMAIN="votre-domaine.com"
   EMAIL="votre-email@example.com"
   ODOO_PASSWORD="votre-mot-de-passe-secure"
   ```

5. **Déployer**
   ```bash
   ./deploy_vps.sh
   ```

6. **Pointer le domaine**
   - Configurer les DNS A records vers l'IP du VPS
   - Attendre la propagation DNS (1-24h)

---

## 🎯 Recommandations finales

### 💡 **Pour commencer rapidement**
→ **Render** (gratuit, 5 minutes)

### 🏢 **Pour une entreprise**
→ **Railway** ou **DigitalOcean** (fiable, support)

### 🚀 **Pour des performances optimales**
→ **VPS** (contrôle total, SSL inclus)

### 💰 **Pour un budget serré**
→ **Render** (gratuit) ou **Contabo VPS** (€5/mois)

---

## 🆘 Support et dépannage

### 📞 Besoin d'aide ?
- Chaque plateforme a son propre support
- Consultez les logs en cas de problème
- Vérifiez les variables d'environnement

### 🔧 Problèmes courants
- **Base de données**: Vérifiez les credentials
- **Port**: Assurez-vous que le port 8069 est exposé
- **Mémoire**: Minimum 1GB RAM requis

### 📊 Accès à Odoo
Une fois déployé:
- URL: Fournie par la plateforme
- Database: `odoo` (ou créer une nouvelle)
- User: `admin`
- Password: `admin`

---

## 🎉 Félicitations !

Votre CRM Odoo est maintenant accessible en ligne ! 🚀

**Prochaines étapes:**
1. Configurer votre CRM
2. Importer vos contacts
3. Personnaliser les modules
4. Former votre équipe

**Votre CRM professionnel est prêt !** 🎊