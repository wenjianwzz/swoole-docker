FROM ubuntu:18.04

RUN echo "Asia/Shanghai" > /etc/timezone
RUN export DEBIAN_FRONTEND=noninteractive && apt update && apt upgrade -y && apt install -y php7.2-gd php7.2-cli \
            php7.2-fpm php7.2-curl php7.2-json php7.2-mysql php7.2-snmp php7.2-xml php7.2-dev \
            php7.2-imap php7.2-intl php7.2-mbstring php7.2-zip php-tokenizer php7.2-opcache \
            unzip openssh-client gcc make curl libssl-dev wget composer

ENV Ver 4.4.16
ENV Download_URL https://github.com/swoole/swoole-src/archive/v${Ver}.zip

RUN cd / && wget $Download_URL
RUN cd / && \ 
    unzip v${Ver}.zip && \
    cd swoole-src-${Ver} && phpize && \
    ./configure --enable-openssl --enable-http2 && \
    make -j4 && make install && \
    echo "extension=swoole.so" > /etc/php/7.2/cli/conf.d/20-swoole.ini

RUN mkdir /app 

WORKDIR /app/
USER root

CMD [ "/bin/bash" ]
