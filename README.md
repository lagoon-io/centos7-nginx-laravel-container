# centos7-nginx-laravel-container

[![Build Status](https://travis-ci.com/lagoon-io/centos7-nginx-laravel-container.svg?branch=master)](https://travis-ci.com/lagoon-io/centos7-nginx-laravel-container)
[![MIT License](http://img.shields.io/badge/license-MIT-blue.svg?style=flat)](LICENSE)

## モジュール

- Nginx
- composer
- php5.6
- php-fpm
- xdebug

## セットアップ

環境によっては git clone を実行した時にユーザー名が異なることが起因で正常に動作しない。  
コンテナ内のユーザーは root のみなので所有者、グループを root に変更する。

```
sudo chown -R root:root ./centos7-nginx-laravel-container/
```

## 起動コマンド

```
docker-compose up --build -d
```
