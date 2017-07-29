FROM centos:7
LABEL Name=typo3-fullstack Version=8.7
MAINTAINER Marco De Angelis <marco.deangelis@mulgo.org>

RUN yum install -y --setopt=tsflags=nodocs https://centos7.iuscommunity.org/ius-release.rpm && \
    yum install -y --setopt=tsflags=nodocs \
      apache \
      php71u \
      php71u-cli \
      php71u-mysqlnd \
      php71u-gd \
      php71u-soap \
      php71u-xml \
      php71u-json \
      php71u-mbstring \
      GraphicsMagick && \
    echo -e "always_populate_raw_post_data = -1;\nmax_execution_time = 240;\nmax_input_vars = 1500;\nupload_max_filesize = 10M;\npost_max_size = 10M;" > /etc/php.d/99-typo3.ini && \
    echo -e "DocumentRoot \"/var/www/html/web\"\n<Directory \"/var/www/html/web\">\nSetEnv TYPO3_CONTEXT ${TYPO3_CONTEXT}\nEnableSendfile off\nEnableMMAP off\nOptions Indexes FollowSymLinks\nAllowOverride All\nOrder allow,deny\nAllow from all\n</Directory>" > /etc/httpd/conf.d/typo3.conf && \
    yum clean all && \
    curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer && \
    curl -sSL https://deployer.org/deployer.phar -o /usr/bin/deployer && chmod +x /usr/bin/deployer

ENV TYPO3_CONTEXT Production
EXPOSE 80
CMD httpd -DFOREGROUND