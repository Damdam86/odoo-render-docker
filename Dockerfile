FROM odoo:17

USER root
RUN apt-get update && apt-get install -y wkhtmltopdf

USER odoo

CMD ["odoo", "--db_host=db.dkdrcflwmdkngitketzm.supabase.co", "--db_port=5432", "--db_user=postgres", "--db_password=Damdam86!?", "--db_name=postgres", "-i", "base", "--without-demo=all"]
