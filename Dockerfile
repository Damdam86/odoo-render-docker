FROM odoo:17

USER root

RUN apt-get update && apt-get install -y \
    wkhtmltopdf \
    postgresql-client \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

COPY entrypoint.sh /entrypoint.sh
COPY odoo.conf /etc/odoo/odoo.conf
RUN chmod +x /entrypoint.sh

USER odoo

RUN mkdir -p /mnt/extra-addons /var/lib/odoo/sessions

EXPOSE 8069

ENTRYPOINT ["/entrypoint.sh"]
