FROM odoo:17

USER root

# Installation wkhtmltopdf (requis pour PDF / rapports)
RUN apt-get update && apt-get install -y \
    wkhtmltopdf \
    && apt-get clean

USER odoo

# Dossier d'addons custom (optionnel)
RUN mkdir -p /mnt/extra-addons
ENV PATH="/mnt/extra-addons:${PATH}"
