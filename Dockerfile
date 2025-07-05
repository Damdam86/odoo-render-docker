FROM odoo:17

USER root

RUN apt-get update && apt-get install -y \
    wkhtmltopdf \
    postgresql-client \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

COPY entrypoint.sh /entrypoint.sh
COPY entrypoint-fix.sh /entrypoint-fix.sh
COPY odoo.conf /etc/odoo/odoo.conf
RUN chmod +x /entrypoint.sh /entrypoint-fix.sh

RUN mkdir -p /mnt/extra-addons /var/lib/odoo/sessions /tmp/odoo_sessions

RUN chown -R odoo:odoo /var/lib/odoo /mnt/extra-addons /tmp/odoo_sessions

USER odoo

EXPOSE 8069

ENTRYPOINT ["/entrypoint-fix.sh"]
