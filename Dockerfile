FROM odoo:17

USER root

# Installer postgresql-client
RUN apt-get update && apt-get install -y postgresql-client && apt-get clean

# Copier le script Odoo minimal
COPY minimal-start.sh /minimal-start.sh
RUN chmod +x /minimal-start.sh

USER odoo

# Port explicite (TESTÉ ET VALIDÉ)
EXPOSE 8069

# Variables exactes du test qui fonctionne
ENV PORT=8069
ENV PYTHONUNBUFFERED=1

# Script Odoo avec paramètres réseau identiques au test
ENTRYPOINT ["/minimal-start.sh"]
