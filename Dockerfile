FROM odoo:17.0-slim

USER root
RUN apt-get update && apt-get install -y wkhtmltopdf

USER odoo
