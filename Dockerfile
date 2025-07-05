FROM odoo:17

USER root

# Installer seulement postgresql-client
RUN apt-get update && apt-get install -y postgresql-client && apt-get clean

# Copier le serveur de test
COPY test-server.py /test-server.py
RUN chmod +x /test-server.py

USER odoo

# Port explicite
EXPOSE 8069

# Variables
ENV PORT=8069
ENV PYTHONUNBUFFERED=1

# SERVEUR DE TEST POUR VÉRIFIER LE PORT
ENTRYPOINT ["python3", "/test-server.py"]
