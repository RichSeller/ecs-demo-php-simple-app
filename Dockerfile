FROM alpine:3.5

RUN apk add --update bash curl && rm -rf /var/cache/apk/*

# Install shush
RUN curl -sL -o /usr/local/bin/shush \
  https://github.com/realestate-com-au/shush/releases/download/v1.3.0/shush_linux_amd64 \
  && chmod +x /usr/local/bin/shush

# Add a user so that we're not running our executables as root.
RUN addgroup -S kube-kms-example && adduser -S -g kube-kms-example kube-kms-example

USER kube-kms-example

COPY print-secrets .

# Use shush exec as an entrypoint for decrypting our secrets
ENTRYPOINT ["/usr/local/bin/shush", "exec", "--"]

CMD ["./print-secrets"]


#FROM ubuntu:12.04

# Install dependencies
#RUN apt-get update -y
#RUN apt-get install -y git curl apache2 php5 libapache2-mod-php5 php5-mcrypt php5-mysql

# Install app
#RUN rm -rf /var/www/*
#ADD src /var/www

# Configure apache
#RUN a2enmod rewrite
#RUN chown -R www-data:www-data /var/www
#ENV APACHE_RUN_USER www-data
#ENV APACHE_RUN_GROUP www-data
#ENV APACHE_LOG_DIR /var/log/apache2

#EXPOSE 80

#CMD ["/usr/sbin/apache2", "-D",  "FOREGROUND"]
