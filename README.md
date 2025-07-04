# 🚀 Odoo 17 + PostgreSQL sur Render

## 📦 Contenu

- `Dockerfile` : Image Odoo + wkhtmltopdf + PostgreSQL client
- `entrypoint.sh` : Script d'init qui installe tous les modules Odoo au premier démarrage
- `odoo.conf` : Configuration Odoo connectée à PostgreSQL Render
- `README.md` : Ce fichier

## 🛠️ Instructions Render

1. Créer un nouveau service Web sur Render
2. Sélectionner ce repo comme source
3. Port : `8069`
4. Commande de démarrage : **laisser vide** (le script gère tout)
