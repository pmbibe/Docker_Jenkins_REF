FROM centos:7

ADD http://pkg.jenkins-ci.org/redhat/jenkins.repo /etc/yum.repos.d/jenkins.repo
RUN rpm --import https://jenkins-ci.org/redhat/jenkins-ci.org.key && \
    yum install -y http://rpms.remirepo.net/enterprise/remi-release-7.rpm && \
    yum install -y yum-utils && \
    yum-config-manager --enable remi-php55 && \
    yum install -y initscripts php-intl phpunit java jenkins ant wget php-pear git php php-mcrypt php-cli php-gd php-curl php-mysql php-ldap php-zip php-fileinfo
RUN wget https://github.com/sebastianbergmann/money/blob/master/build/tools/phpcs.phar && chmod +x phpcs.phar && mv phpcs.phar /usr/local/bin/phpcs && \
    wget https://github.com/sebastianbergmann/money/blob/master/build/tools/phploc.phar && chmod +x phploc.phar && mv phploc.phar /usr/local/bin/phploc && \
    wget https://github.com/sebastianbergmann/money/blob/master/build/tools/pdepend.phar && chmod +x pdepend.phar && mv pdepend.phar /usr/local/bin/pdepend && \
    wget https://github.com/sebastianbergmann/money/blob/master/build/tools/phpmd.phar && chmod +x phpmd.phar && mv phpmd.phar /usr/local/bin/phpmd && \
    wget https://github.com/sebastianbergmann/money/blob/master/build/tools/phpcpd.phar && chmod +x phpcpd.phar && mv phpcpd.phar /usr/local/bin/phpcpd && \
    wget https://github.com/sebastianbergmann/money/blob/master/build/tools/phpdox.phar && chmod +x phpdox.phar && mv phpdox.phar /usr/bin/phpdox

ADD setup.sh /setup.sh
RUN sh /setup.sh

EXPOSE 8080

CMD service jenkins start && tail -f /var/log/jenkins/jenkins.log

