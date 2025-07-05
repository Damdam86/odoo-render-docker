FROM odoo:17

USER root

# Installer les dépendances nécessaires + outils de debug
RUN apt-get update && apt-get install -y \
    wkhtmltopdf \
    postgresql-client \
    netstat-nat \
    lsof \
    iproute2 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Copier tous les scripts
COPY entrypoint.sh /entrypoint.sh
COPY entrypoint-fix.sh /entrypoint-fix.sh
COPY entrypoint-simple.sh /entrypoint-simple.sh
COPY test-port.sh /test-port.sh
COPY odoo.conf /etc/odoo/odoo.conf

# Rendre tous les scripts exécutables
RUN chmod +x /entrypoint.sh /entrypoint-fix.sh /entrypoint-simple.sh /test-port.sh

# Créer les dossiers nécessaires avec bonnes permissions
RUN mkdir -p /mnt/extra-addons /var/lib/odoo/sessions /tmp/odoo_sessions \
    && chown -R odoo:odoo /var/lib/odoo /mnt/extra-addons /tmp/odoo_sessions

USER odoo

# Exposer le port explicitement
EXPOSE 8069

# Variables d'environnement critiques pour Render
ENV PORT=8069
ENV ODOO_RC=/etc/odoo/odoo.conf
ENV PYTHONUNBUFFERED=1

# Utiliser le script simple ultra-robuste
ENTRYPOINT ["/entrypoint-simple.sh"]
