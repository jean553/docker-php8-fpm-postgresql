FROM php:8-fpm
# Install modules
RUN buildDeps="libpq-dev libzip-dev libicu-dev libpng-dev libjpeg-dev libfreetype6-dev libmagickwand-dev libxslt-dev" && \
    apt-get update && \
    apt-get install -y $buildDeps --no-install-recommends && \
    # install imagick
    # use github version for now until release from https://pecl.php.net/get/imagick is ready for PHP 8
    # see: https://github.com/Imagick/imagick/issues/358#issuecomment-768586107
    mkdir -p /usr/src/php/ext/imagick; \
    curl -fsSL https://github.com/Imagick/imagick/archive/06116aa24b76edaf6b1693198f79e6c295eda8a9.tar.gz | tar xvz -C "/usr/src/php/ext/imagick" --strip 1; \
    ln -s /usr/lib/x86_64-linux-gnu/ImageMagick-6.8.9/bin-Q16/MagickWand-config /usr/bin && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    docker-php-ext-install \
        opcache \
        pdo \
        pdo_pgsql \
        pgsql \
        sockets \
        xsl \
        sysvsem \
        intl
CMD ["php-fpm"]
