FROM odoo:17

USER root

# Installation des dépendances nécessaires
RUN apt-get update && apt-get install -y \
    wkhtmltopdf \
    postgresql-client \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Créer un fichier de configuration Odoo avec SSL
RUN echo "[options]" > /etc/odoo/odoo-ssl.conf && \
    echo "db_sslmode = require" >> /etc/odoo/odoo-ssl.conf && \
    echo "db_maxconn = 32" >> /etc/odoo/odoo-ssl.conf && \
    echo "proxy_mode = True" >> /etc/odoo/odoo-ssl.conf

# Copier le script d'entrée
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

USER odoo

# Dossier d'addons custom
RUN mkdir -p /mnt/extra-addons

# Exposer le port
EXPOSE 8069

ENTRYPOINT ["/entrypoint.sh"]
