FROM odoo:17

USER root

# Installer postgresql-client
RUN apt-get update && apt-get install -y postgresql-client && apt-get clean

# Copier le script de démarrage rapide
COPY fast-start.sh /fast-start.sh
RUN chmod +x /fast-start.sh

USER odoo

# Port explicite
EXPOSE 8069

# Variables
ENV PORT=8069
ENV PYTHONUNBUFFERED=1

# Script ultra-rapide qui ouvre le port immédiatement
ENTRYPOINT ["/fast-start.sh"]
