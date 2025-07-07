FROM odoo:17

USER root

# Installation des dépendances optimisées
RUN apt-get update && apt-get install -y \
    wkhtmltopdf \
    postgresql-client \
    python3-pip \
    && pip3 install --upgrade psycopg2-binary \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Configuration Odoo optimisée
RUN echo "[options]" > /etc/odoo/odoo-optimized.conf && \
    echo "db_sslmode = require" >> /etc/odoo/odoo-optimized.conf && \
    echo "db_maxconn = 16" >> /etc/odoo/odoo-optimized.conf && \
    echo "proxy_mode = True" >> /etc/odoo/odoo-optimized.conf && \
    echo "workers = 2" >> /etc/odoo/odoo-optimized.conf && \
    echo "max_cron_threads = 1" >> /etc/odoo/odoo-optimized.conf && \
    echo "limit_memory_hard = 1073741824" >> /etc/odoo/odoo-optimized.conf && \
    echo "limit_memory_soft = 838860800" >> /etc/odoo/odoo-optimized.conf

# Copier le script d'entrée optimisé
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

USER odoo

# Créer les dossiers nécessaires
RUN mkdir -p /mnt/extra-addons /var/lib/odoo/filestore

EXPOSE 8069

ENTRYPOINT ["/entrypoint.sh"]
