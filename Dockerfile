FROM odoo:17

USER root
RUN apt-get update && apt-get install -y wkhtmltopdf

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

USER odoo
