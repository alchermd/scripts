#!/bin/bash

# Let's start by updating our repositories
sudo apt update && apt upgrade

#######################################
# --- Programming and Development --- #
#######################################

# Git
sudo apt install git -y

# PHP7.2 and extensions
sudo apt install python-software-properties -y
yes " " | sudo add-apt-repository ppa:ondrej/php
sudo apt update
sudo apt install php7.2 -y
sudo apt install php-pear php7.2-curl php7.2-dev php7.2-gd \
    php7.2-mbstring php7.2-zip php7.2-mysql php7.2-xml -y

# Composer
if which composer >/dev/null; then 
    echo "Composer is already installed"
else
    php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
    php -r "if (hash_file('SHA384', 'composer-setup.php') === '544e09ee996cdf60ece3804abc52599c22b1f40f4323403c44d44fdfdd586475ca9813a858088ffbc1f233e9b180f061') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
    php composer-setup.php
    php -r "unlink('composer-setup.php');"
    sudo mv composer.phar /usr/local/bin/composer
fi

# MySQL
# Some hacky way to bypass the password issues of MySQL 5.7
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password default'
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password default'
sudo apt-get -y install mysql-server
mysqladmin -u root -p'default' password ''

# Laravel
composer global require "laravel/installer"

##################### 
# --- Utilities --- #
#####################

# zsh
sudo apt install zsh -y

# Oh-my-zsh
sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
chsh -s /bin/zsh