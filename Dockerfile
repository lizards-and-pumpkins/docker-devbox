ARG version=${version}
FROM ubuntu:16.04
LABEL Description="Lizards and Pumpkins Base Image Ubuntu 16.04" Vendor="Lizards and Pumpkins" Version="${version}" Maintainer="tl@scale.sc"
ENV TINI_VERSION v0.15.0
ENV PORT 80
ENV PROTO http
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
ADD supervisor/ /etc/supervisor/
ADD apache2/ /etc/apache2/
ADD nginx/ /etc/nginx/
ADD install-scripts/ /root/install-scripts/
ADD config-files/ /root/config-files/
ADD start.sh /usr/local/sbin/start.sh
ADD lizards-env.sh /etc/profile.d/lizards-env.sh

# INSTALL SERVICES
RUN apt-get update; \
apt-get install -y --no-install-recommends supervisor mariadb-server php7.0-cli php7.0-mysql php7.0-mbstring php7.0-mcrypt php7.0-xml php7.0-gd php7.0-curl php7.0-zip php7.0-intl php-imagick apache2 libapache2-mod-php7.0 nginx-extras git vim net-tools nano curl wget ca-certificates sudo composer unzip rsync ssh-client -o Dpkg::Options::="--force-confold"; \
a2enmod rewrite ; \
chmod +x /tini ; \
chmod +x /usr/local/sbin/start.sh ; \
chmod +x /etc/profile.d/lizards-env.sh ; \
mkdir /var/run/mysqld ; \
rm -rf /etc/apache2/sites-enabled/000* /etc/nginx/sites-enabled/default* ; \
mkdir -p /var/www/magento/pub ; \
mkdir -p /var/www/lizards ; \
apt-get -y autoremove ; \
apt-get -y clean ; \
rm -rf /var/lib/apt/lists/*

# INSTALL MAGGENTO & LIZARDS
RUN touch /root/.import-data.lock ; \
/usr/bin/supervisord -c /etc/supervisor/supervisord.conf & \
sleep 10 ; \
/root/install-scripts/magento.sh ; \
/root/install-scripts/lizards.sh ; \
rm -rf /var/run/apache2/apache2.pid ; \
rm -rf /root/.import-data.lock

ENTRYPOINT ["/tini", "--"]
CMD ["/usr/local/sbin/start.sh"]
