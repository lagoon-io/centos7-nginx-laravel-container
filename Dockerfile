FROM centos:centos7

# composer設定
ENV PATH="$PATH:/opt/composer/vendor/bin"
# composer update、install時のメモリ上限を無効化
ENV COMPOSER_MEMORY_LIMIT=-1

# RHELのリポジトリに追加してやらないとインストールできないので追加
COPY ./conf/nginx/repo/nginx.repo /etc/yum.repos.d/nginx.repo

# マルチステージビルド
# composer 公式イメージからcomposerを移植
COPY --from=composer:1.8.6 /usr/bin/composer /usr/bin/composer

RUN yum update -y \
  # 基本パッケージのインストール
  && yum install -y wget git openssh-server \
  # nginxインストール
  && yum install -y nginx \
  # php用のリポジトリ登録
  && rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm \
  && rpm -Uvh http://rpms.famillecollet.com/enterprise/remi-release-7.rpm \
  # php依存パッケージのインストール
  && yum install -y httpd openssl-devel autoconf zlib-devel systemd-sysv automake pcre-devel krb5-devel libxslt libxml2-devel libedit-devel \
  # 標準リポジトリを無効化、remiリポジトリを有効化してphpをインストール
  && yum install -y --disablerepo=* --enablerepo=remi,remi-php56 php php-fpm php-cli php-common php-devel php-mbstring php-pear php-pecl-apcu php-soap php-xml php-xmlrpc php-zip php-pdo \
  # xdebugのインストール
  && yum install -y gcc \
  && pecl install xdebug-2.2.7 \
  # アプリケーションマウントポイント作成
  && mkdir /var/www/app/ && chmod 777 -R /var/www/

# 各種サービス起動
RUN systemctl enable sshd.service \
  && systemctl enable php-fpm \
  && systemctl enable nginx

EXPOSE 22
EXPOSE 80
EXPOSE 9000
EXPOSE 9001

CMD ["/sbin/init"]
