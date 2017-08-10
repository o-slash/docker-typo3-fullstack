FROM centos:7
MAINTAINER Marco De Angelis <marco.deangelis@mulgo.org>

ARG TYPO3_VERSION=7.6
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
      php56u \
      php56u-cli \
      php56u-mysqli \
      php56u-gd \
      php56u-soap \
      php56u-xml \
      php56u-json \
      php56u-mbstring \
      php56u-process \
      php56u-pecl-xdebug \
      GraphicsMagick && \
    yum clean all && \
    curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer && \
    curl -sSL https://deployer.org/releases/v4.3.1/deployer.phar -o /usr/bin/dep && chmod +x /usr/bin/dep && \
    curl -sSL http://www.phing.info/get/phing-latest.phar -o /usr/bin/phing && chmod +x /usr/bin/phing && \
    curl -sSL https://phar.phpunit.de/phpunit-5.7.phar -o /usr/bin/phpunit && chmod +x /usr/bin/phpunit && \
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