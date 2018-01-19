FROM ubuntu:16.04

MAINTAINER Ewen Cumming

# Install base software into the image.
# Pulls from Ubuntu repos and then cleans up the package lists to save some space.
# Last step upgrades pip (using pip) to the latest version and installs uwsgi.
RUN \
  apt-get update && \
  apt-get install -y \
    python3 \
    python3-pip \
    nginx \
    dnsmasq \
    supervisor && \
  rm -rf /var/lib/apt/lists/* && \
  pip3 install -U pip && \
  pip3 install uwsgi

# Project specific packages
# Do the requirements.txt copy earlier than the rest of the code to let Docker
# cache the dependencies and not reinstall every time the code changes.
COPY server/requirements.txt /src/server/requirements.txt
RUN pip3 install -r /src/server/requirements.txt

# Configuration
RUN echo "daemon off;" >> /etc/nginx/nginx.conf
RUN echo "user=root" >> /etc/dnsmasq.conf
COPY docker-config/nginx-app.conf /etc/nginx/sites-available/default
COPY docker-config/supervisor-app.conf /etc/supervisor/conf.d/
COPY docker-config/uwsgi.ini /src/

# Add Project code
COPY server/ /src/server/

# Run collectstatic to build Django static assets
RUN python3 /src/server/manage.py collectstatic --no-input

EXPOSE 80
CMD ["supervisord", "-n"]
