FROM ubuntu:15.10

WORKDIR /var/www
ADD .bowerrc ./
ADD bower.json ./

# Update and install packages
RUN apt-get update && \
    apt-get install -y --no-install-recommends apache2 ca-certificates curl git libapache2-mod-php5 npm php5-cli php5-curl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN ln -s nodejs /usr/bin/node && \
    npm install -g bower && \
    bower install && touch /tmp/bower.done && \
    ls -l /var/www/public/

#    apt-get remove npm && \
#    apt-get autoremove && \

RUN echo "<VirtualHost *>\nDocumentRoot /var/www/public\nFallbackResource /index.php\n</VirtualHost>" > /etc/apache2/sites-enabled/000-default.conf

# Install app dependencies
COPY composer.* ./
RUN curl -sS https://getcomposer.org/installer | php && ./composer.phar install --prefer-dist && ./composer.phar clearcache

# Copy site into place.
COPY . .

# Test image
RUN ./vendor/bin/phpunit src

EXPOSE 80
CMD /bin/bash -c "source /etc/apache2/envvars && exec /usr/sbin/apache2 -DFOREGROUND"
