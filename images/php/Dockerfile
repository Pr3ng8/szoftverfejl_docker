FROM php:7.2-fpm

# Copy composer.lock and composer.json
COPY composer.lock composer.json /var/www/

# Set working directory
WORKDIR /var/www

RUN apt-get update && apt-get install -y \
    build-essential \
    vim \
    locales \
    libpng-dev \
    libjpeg62-turbo-dev \
    libfreetype6-dev

# Clear cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Install dependencies
RUN yum clean all; yum -y update --nogpgcheck
RUN yum -yinstall yum-utils

RUN yum install -y \
    curl \
    git \
    ImageMagick \
    openssl \
    php \
    php-bcmath \
    php-cli \
    php-common \
    php-imap \
    php-mbstring \
    php-mysqli \
    php-pdo \
    php-pecl \
    php-pecl-imagick \
    php-pecl-redis \
    php-pecl-memcache \
    php-pecl-memcached \
    php-pecl-xdebug \
    php-pecl-zip \
    php-pear-XML-RPC \
    php-soap \
    php-xml \
    php-xmlrpc \
    zip \
    unzip \

# Install extensions
RUN docker-php-ext-install pdo_mysql mbstring zip exif pcntl
RUN docker-php-ext-configure gd --with-gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ --with-png-dir=/usr/include/
RUN docker-php-ext-install gd

#XDEBUG
RUN echo '[xdbug]'                             >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini; \
    echo 'xdebug.remote_autostart=true'        >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini; \
    echo 'xdebug.remote_enable=On'             >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini; \
    echo 'xdebug.remote_connect=On'            >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini; \
    echo 'xdebug.var_display_max_depth=20'     >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini; \
    echo 'xdebug.var_display_max_children=256' >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini; \
    echo 'xdebug.var_display_max_data=1024'    >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini;

# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Add user for laravel application
RUN groupadd -g 1000 www
RUN useradd -u 1000 -ms /bin/bash -g www www

# Copy existing application directory contents
COPY . /var/www

# Copy existing application directory permissions
COPY --chown=www:www . /var/www

# Change current user to www
USER www

# Expose port 9000 and start php-fpm server
EXPOSE 9000
CMD ["php-fpm"]