FROM odoo:17

USER root

# Installer wkhtmltopdf et le client PostgreSQL
RUN apt-get update && apt-get install -y \
    wkhtmltopdf \
    postgresql-client \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Copier le script d'entrée
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Préparer les dossiers nécessaires
RUN mkdir -p /mnt/extra-addons /var/lib/odoo/sessions

USER odoo

EXPOSE 8069

ENTRYPOINT ["/entrypoint.sh"]
