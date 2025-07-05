FROM odoo:17

USER root

# Installer postgresql-client
RUN apt-get update && apt-get install -y postgresql-client && apt-get clean

# Copier le script ultime
COPY ultimate-fix.sh /ultimate-fix.sh
RUN chmod +x /ultimate-fix.sh

USER odoo

# Port explicite
EXPOSE 8069

# Variables
ENV PORT=8069
ENV PYTHONUNBUFFERED=1

# SCRIPT ULTIME - Port ouvert immédiatement
ENTRYPOINT ["/ultimate-fix.sh"]
