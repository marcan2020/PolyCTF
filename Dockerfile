FROM wordpress:5.5.1-php7.2-apache

RUN curl https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar -o /bin/wp \
       && chmod +x /bin/wp

COPY ./entrypoint.sh /root/entrypoint.sh
RUN chmod +x /root/entrypoint.sh

COPY ./plugins/ /root/plugins/

COPY ./secret.sh /bin/secret
RUN chmod +x /bin/secret

COPY ./secrets /root/secrets
RUN mv /root/secrets/flag2 /flag.txt
RUN mv /root/secrets/flag3 /flag.txt

ENTRYPOINT ["/root/entrypoint.sh"]
CMD ["apache2-foreground"]
