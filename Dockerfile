FROM centos:8.3.2011

# Install dependencies
RUN dnf clean all

#https://www.tecmint.com/install-php-7-in-centos-7/
RUN dnf install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm
RUN dnf install -y https://rpms.remirepo.net/enterprise/remi-release-8.rpm

RUN dnf module enable php:remi-8.2 -y

RUN dnf update -y
RUN dnf upgrade -y

#RUN dnf -y update --nogpgcheck
#RUN dnf -y install dnf-utils

RUN dnf install -y \
    initscripts \
    httpd \
    mod_ssl \
    curl \
    git \
    nginx \
    ImageMagick \
    openssl \
    php \
    php-fpm \
    php-bcmath \
    php-cli \
    php-common \
    php-imap \
    php-mbstring \
    php-mysqli \
    php-pdo \
    php-pecl-imagick \
    php-pecl-redis \
    php-pecl-memcache \
    php-pecl-memcached \
    php-pecl-xdebug \
    php-pecl-zip \
#    php-pear-XML-RPC \
    php-soap \
    php-xml \
    php-xmlrpc \
    zip \
    unzip \
    nano \
    net-tools \
    vim \
    epel-release \
    supervisor

#PHP Config
COPY ./images/php/conf/php.ini /usr/local/etc/php/conf.d/php.ini

#NGINX Config
COPY ./images/nginx/conf/nginx.conf /etc/nginx/nginx.conf

#SUPERVISOR Config
COPY supervisord.conf /etc/supervisord.conf

## Install composer
#RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN curl -sS https://getcomposer.org/installer | php

##Copy existing application directory contents
##COPY ../hobbyproject /var/www

EXPOSE 80 443

RUN mkdir -p /var/run/php-fpm

CMD ["/usr/bin/supervisord", "-n", "-c", "/etc/supervisord.conf"]
