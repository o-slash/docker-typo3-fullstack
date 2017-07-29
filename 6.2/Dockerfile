ARG TYPO3_CONTEXT=Production
FROM centos:7
MAINTAINER Marco De Angelis <marco.deangelis@mulgo.org>
ENV TYPO3_VERSION 6.2

ARG BUILD_DATE
ARG VCS_REF
ARG TYPO3_CONTEXT

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

RUN yum install -y --setopt=tsflags=nodocs https://centos7.iuscommunity.org/ius-release.rpm && \
    yum install -y --setopt=tsflags=nodocs \
      httpd \
      php56u \
      php56u-cli \
      php56u-mysqli \
      php56u-gd \
      php56u-soap \
      php56u-xml \
      php56u-json \
      php56u-mbstring \
      GraphicsMagick && \
    mkdir -p /var/www/site/web && chown -R apache:apache /var/www/site/ && \
    yum clean all && \
    curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer && \
    curl -sSL https://deployer.org/releases/v4.3.1/deployer.phar -o /usr/bin/deployer && chmod +x /usr/bin/deployer

ADD typo3.ini /etc/php.d/99-typo3.ini
ADD typo3.conf /etc/httpd/conf.d/typo3.conf
ADD run-typo3.sh /usr/bin/run-typo3.sh
RUN chmod +x /usr/bin/run-typo3.sh

EXPOSE 80
CMD ["run-typo3.sh" ]