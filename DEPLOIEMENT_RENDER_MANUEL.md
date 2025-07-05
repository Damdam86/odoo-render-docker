# 🚀 Déploiement Odoo CRM sur Render - Guide Manuel

## ❗ Problème avec le bouton "Deploy to Render"

Si vous avez le message "Missing Blueprint repository URL", voici la solution :

## 🔗 **URL du repository**
```
https://github.com/Damdam86/odoo-render-docker
```

## 📋 **Étapes de déploiement manuel**

### 1. **Créer un compte Render**
- Aller sur https://render.com
- S'inscrire gratuitement
- Confirmer votre email

### 2. **Créer la base de données PostgreSQL**
1. Dans votre Dashboard Render → cliquer sur **"New"**
2. Sélectionner **"PostgreSQL"**
3. Configuration :
   - **Name** : `odoo-postgres`
   - **Database** : `odoo`
   - **User** : `odoo`
   - **Region** : `Frankfurt` (Europe)
   - **Plan** : `Free`
4. Cliquer sur **"Create Database"**
5. **⚠️ IMPORTANT** : Noter les informations de connexion :
   - **Hostname** : `dpg-xxxxx-a.frankfurt-postgres.render.com`
   - **Port** : `5432`
   - **Database** : `odoo`
   - **Username** : `odoo`
   - **Password** : `xxxxxxxxxxxxxxxx`

### 3. **Créer le service Web Odoo**
1. Dans votre Dashboard → cliquer sur **"New"**
2. Sélectionner **"Web Service"**
3. Dans "Public Git repository" :
   - **Repository URL** : `https://github.com/Damdam86/odoo-render-docker`
   - Cliquer sur **"Continue"**
4. Configuration du service :
   - **Name** : `odoo-crm`
   - **Region** : `Frankfurt`
   - **Branch** : `cursor/d-ployer-le-crm-odoo-1ac7`
   - **Runtime** : `Docker`
   - **Plan** : `Free`
   - **Dockerfile Path** : `./Dockerfile`

### 4. **Configurer les variables d'environnement**
Dans la section "Environment Variables", ajouter :

```
DB_HOST=dpg-xxxxx-a.frankfurt-postgres.render.com
DB_PORT=5432
DB_USER=odoo
DB_PASSWORD=xxxxxxxxxxxxxxxx
DB_NAME=odoo
ADMIN_PASSWORD=admin123
PORT=8069
```

**⚠️ Remplacez les valeurs par celles de votre base de données PostgreSQL créée à l'étape 2**

### 5. **Déployer**
1. Cliquer sur **"Create Web Service"**
2. Render va :
   - Cloner le repository
   - Construire l'image Docker
   - Déployer l'application
   - Configurer l'URL publique

### 6. **Attendre le déploiement**
- Le déploiement prend environ **5-10 minutes**
- Suivre les logs en temps réel
- Attendre que le statut soit **"Live"**

### 7. **Accéder à Odoo**
- Votre URL sera : `https://odoo-crm-xxxx.onrender.com`
- **Database** : `odoo` (ou créer une nouvelle)
- **Username** : `admin`
- **Password** : `admin`

## 🔧 **Solution alternative : render.yaml**

J'ai également créé un fichier `render.yaml` qui automatise tout le processus :

1. **Fork le repository** vers votre compte GitHub
2. **Connecter GitHub** à Render
3. **Sélectionner le repository** qui contient `render.yaml`
4. Render **détectera automatiquement** la configuration

## 🆘 **Dépannage**

### Problème de connexion à la base de données
```bash
# Vérifier les logs
# Dans Render Dashboard → votre service → "Logs"
```

### Service qui ne démarre pas
```bash
# Vérifier les variables d'environnement
# S'assurer que toutes les variables DB_ sont correctes
```

### Problème de mémoire
```bash
# Le plan Free a 512MB RAM
# Odoo peut être lent au démarrage
# Attendre 10-15 minutes pour le premier démarrage
```

## 🎯 **Pourquoi le bouton ne fonctionne pas ?**

Le bouton "Deploy to Render" nécessite :
1. **Un fichier render.yaml** (✅ créé)
2. **Une URL publique** (✅ disponible)
3. **Des permissions GitHub** (peut nécessiter un fork)

## 🚀 **Résultat final**

Une fois déployé, vous aurez :
- ✅ **URL publique** : `https://odoo-crm-xxxx.onrender.com`
- ✅ **SSL automatique** 
- ✅ **Base de données PostgreSQL** gratuite
- ✅ **Odoo CRM 17** complet
- ✅ **Déploiement automatique** à chaque commit

## 📞 **Besoin d'aide ?**

Si vous avez des problèmes :
1. Vérifiez les logs dans Render
2. Assurez-vous que la base de données est créée
3. Vérifiez les variables d'environnement
4. Attendez le premier démarrage (peut prendre 15 min)

**Votre CRM Odoo sera bientôt en ligne !** 🎉