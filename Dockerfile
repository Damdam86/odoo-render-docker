FROM odoo:17

USER root
RUN apt-get update && apt-get install -y wkhtmltopdf

USER odoo

CMD ["odoo", "--db_host=${PGHOST}", "--db_port=${PGPORT}", "--db_user=${PGUSER}", "--db_password=${PGPASSWORD}", "--db_name=${PGDATABASE}", "-i", "base", "--without-demo=all"]
