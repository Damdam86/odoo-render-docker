FROM odoo:17

USER root
RUN apt-get update && apt-get install -y wkhtmltopdf

USER odoo

CMD ["odoo", "-i", "base", "--without-demo=all"]
