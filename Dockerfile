FROM php:7.3-apache

# 更新系统和安装必要工具
RUN apt-get update && apt-get install -y \
    git \
    vim \
    unzip \
    mariadb-client \
    && rm -rf /var/lib/apt/lists/*

# 安装 PHP 扩展
RUN docker-php-ext-install mysqli pdo pdo_mysql

# 将 sqli-labs 源代码复制到容器中
COPY . /var/www/html/

# 设置工作目录
WORKDIR /var/www/html

# 修改配置文件以支持 URL 重写
RUN a2enmod rewrite && service apache2 restart

# 设置 Apache 目录权限
RUN chown -R www-data:www-data /var/www/html

# 开放 80 端口
EXPOSE 80

# 启动 Apache
CMD ["apache2-foreground"]


