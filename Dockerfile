FROM odoo:17

USER root

# Installer PostgreSQL client seulement
RUN apt-get update && apt-get install -y \
    postgresql-client \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Copier le script de démarrage direct
COPY start-odoo.sh /start-odoo.sh
COPY odoo.conf /etc/odoo/odoo.conf

# Rendre le script exécutable
RUN chmod +x /start-odoo.sh

# Créer les dossiers
RUN mkdir -p /mnt/extra-addons /var/lib/odoo/sessions \
    && chown -R odoo:odoo /var/lib/odoo /mnt/extra-addons

USER odoo

# Port explicite
EXPOSE 8069

# Variables critiques
ENV PORT=8069
ENV PYTHONUNBUFFERED=1

# Script direct et simple
ENTRYPOINT ["/start-odoo.sh"]
