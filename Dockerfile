FROM odoo:17

USER root

# Installer postgresql-client
RUN apt-get update && apt-get install -y postgresql-client && apt-get clean

# Copier le script de correction définitive
COPY final-fix.sh /final-fix.sh
RUN chmod +x /final-fix.sh

USER odoo

# Port explicite
EXPOSE 8069

# Variables
ENV PORT=8069
ENV PYTHONUNBUFFERED=1

# SCRIPT DÉFINITIF qui résout TOUT
ENTRYPOINT ["/final-fix.sh"]
