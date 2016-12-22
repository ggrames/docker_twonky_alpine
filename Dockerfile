# twonky server  
FROM alpine
MAINTAINER Gernot Grames <gernot.grames@gmx.at>
ENV container docker
ENV UPDATED_ON "22 December 2016"
ENV TWONKY_VERSION 8.3
ENV TWONKY_PORT 9000 #fixed

RUN apk add --update bash wget unzip

# download twonky
RUN wget http://d33rws75kj13ih.cloudfront.net/downloads/packages/twonky-i686-glibc-2.9-8.3.zip

# unzip package
RUN mkdir -p /usr/local/twonky
RUN unzip twonky-i686-glibc-2.9-8.3.zip -d /usr/local/twonky

# set execute bit
RUN cd /usr/local/twonky
#RUN chmod 700 twonkys* twonkyproxy cgi-bin/* plugins/*

# add user twonky
RUN adduser -h /home/twonky -s /bin/false -D twonky

# twonky database
RUN mkdir -p /home/tomeky/.twonky

# cleanup
RUN apk del wget
RUN apk del unzip

#COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
#COPY httpd.conf /etc/apache2/httpd.conf

EXPOSE 9000

#CMD /usr/bin/supervisord -c /etc/supervisor/conf.d/supervisord.conf
