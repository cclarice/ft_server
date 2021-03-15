# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: cclarice <cclarice@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/03/15 21:57:08 by cclarice          #+#    #+#              #
#    Updated: 2021/03/15 22:03:35 by cclarice         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM debian:buster

RUN apt update
RUN apt upgrade -y
RUN apt -y install nginx
RUN apt -y install wget
RUN apt -y install php-fpm
RUN apt -y install php7.3
RUN apt -y install php-mysql
RUN apt -y install mariadb-server
RUN apt -y install php-xml
RUN apt -y install vim

COPY ./srcs/nginx.conf ./etc/nginx/sites-available/default

WORKDIR /var/www/html
RUN wget http://wordpress.org/latest.tar.gz
RUN tar -xzvf latest.tar.gz
RUN rm -rf latest.tar.gz

WORKDIR /var/www/html/wordpress
COPY ./srcs/wp_config.php ./wp-config.php

WORKDIR /var/www/html
RUN wget https://files.phpmyadmin.net/phpMyAdmin/5.1.0/phpMyAdmin-5.1.0-all-languages.tar.gz
RUN tar -xzvf phpMyAdmin-5.1.0-all-languages.tar.gz
RUN rm -rf phpMyAdmin-5.1.0-all-languages.tar.gz

WORKDIR /
COPY ./srcs/init.sh ./

CMD [ "/bin/bash", "./init.sh" ]