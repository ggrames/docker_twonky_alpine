# twonky server  
FROM frolvlad/alpine-glibc
MAINTAINER Gernot Grames <gernot.grames@gmx.at>
ENV container docker
ENV UPDATED_ON "04 April 2018"
ENV TWONKY_VERSION 8.5
ENV TWONKY_PORT 9000 #fix

RUN apk add --update bash wget unzip supervisor

# download twonky
RUN wget http://download.twonky.com/$TWONKY_VERSION/twonky-i686-glibc-2.9-$TWONKY_VERSION.zip
#RUN wget http://download.twonky.com/${TWONKY_VERSION}/twonky-i686-glibc-2.9-"${TWONKY_VERSION}".zip

# unzip package
RUN mkdir -p /usr/local/twonky
RUN unzip twonky-i686-glibc-2.9-"${TWONKY_VERSION}".zip -d /usr/local/twonky

# set execute bit
RUN chmod 705 /usr/local/twonky/twonky* /usr/local/twonky/cgi-bin/* /usr/local/twonky/plugins/*
RUN chmod 757 -R /var/run

# add user twonky
RUN adduser -h /home/twonky -s /bin/sh -D twonky

# add Media folder
RUN mkdir /home/twonky/media
RUN chown -R twonky:twonky /home/twonky/media

# twonky database
RUN su twonky -c "mkdir -p /home/twonky/.twonky"
RUN sed -i 's/\"$TWONKYSRV\"/su twonky -c \"$TWONKYSRV\"/g' /usr/local/twonky/twonky.sh
RUN sed -i 's/--no-headers//g' /usr/local/twonky/twonky.sh

# cleanup
RUN apk del wget
RUN apk del unzip
RUN rm twonky-i686-glibc-2.9-$TWONKY_VERSION.zip

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

EXPOSE 9000

CMD /usr/bin/supervisord -c /etc/supervisor/conf.d/supervisord.conf

