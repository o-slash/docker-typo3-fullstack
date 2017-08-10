FROM centos:7
MAINTAINER Marco De Angelis <marco.deangelis@mulgo.org>

ARG TYPO3_VERSION=8.7
ARG TYPO3_CONTEXT=Production
ARG TYPO3_DOCROOT=web

ARG BUILD_DATE
ARG VCS_REF

LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.name="Docker Typo3 Toolchain" \
      org.label-schema.description="Docker image with full Typo3 Toolchain" \
      org.label-schema.url="https://github.com/o-slash/docker-typo3-toolchain" \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-type=Git \
      org.label-schema.vcs-url="https://github.com/o-slash/docker-typo3-toolchain.git" \
      org.label-schema.version=$TYPO3_VERSION \
      org.label-schema.schema-version="1.0"

ENV TYPO3_CONTEXT $TYPO3_CONTEXT

WORKDIR /var/www/site

RUN yum update -y --setopt=tsflags=nodocs --nogpgcheck && \
    yum install -y --setopt=tsflags=nodocs --nogpgcheck https://centos7.iuscommunity.org/ius-release.rpm && \
    yum install -y --setopt=tsflags=nodocs --nogpgcheck \
      sudo \
      httpd \
      php71u \
      php71u-cli \
      php71u-mysqlnd \
      php71u-gd \
      php71u-soap \
      php71u-xml \
      php71u-json \
      php71u-mbstring \
      php71u-process \
      php71u-pecl-xdebug \
      GraphicsMagick && \
    yum clean all && \
    curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer && \
    curl -sSL https://deployer.org/deployer.phar -o /usr/bin/dep && chmod +x /usr/bin/dep && \
    curl -sSL http://www.phing.info/get/phing-latest.phar -o /usr/bin/phing && chmod +x /usr/bin/phing && \
    curl -sSL https://phar.phpunit.de/phpunit-6.2.phar -o /usr/bin/phpunit && chmod +x /usr/bin/phpunit && \
    curl -sSL https://github.com/Behat/Behat/releases/download/v3.3.0/behat.phar -o /usr/bin/behat && chmod +x /usr/bin/behat

ADD typo3.ini /etc/php.d/99-typo3.ini
ADD typo3.conf /etc/httpd/conf.d/typo3.conf
ADD phpenv.sh /etc/profile.d/phpenv.sh
ADD entrypoint.sh /usr/bin/entrypoint.sh
ADD run-typo3.sh /usr/bin/run-typo3.sh
RUN chmod +x /usr/bin/entrypoint.sh
RUN chmod +x /usr/bin/run-typo3.sh

EXPOSE 80
ENTRYPOINT ["entrypoint.sh"]
CMD ["run-typo3.sh" ]