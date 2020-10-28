#!/bin/bash
set -e

# Download WordPress
if [ ! -f wp-load.php ]; then
  wp core download --allow-root
fi

# Generate WordPress config
if [ ! -f wp-config.php ]; then
  wp config create \
    --dbname="${DATABASE}" \
    --dbuser="${DB_USER}" \
    --dbpass="${DB_PASSWORD}" \
    --dbhost="${WORDPRESS_DB_HOST}" \
    --skip-check \
    --force \
    --allow-root
fi

# Install WordPress
if ! $(wp core is-installed --allow-root); then
  wp core install \
    --url="${WORDPRESS_URL}" \
    --title="${WORDPRESS_TITLE}" \
    --admin_user="${WORDPRESS_ADMIN_USER}" \
    --admin_password="`secret wp_password`" \
    --admin_email="`secret flag1`@ctf.local" \
    --allow-root

   wp plugin install /root/plugins/rsvpmaker.7.8.1.zip --allow-root --activate
   #wp plugin install https://downloads.wordpress.org/plugin/rsvpmaker.7.8.1.zip --activate --allow-root
fi

chown -R www-data:www-data /var/www/html/

cat << EOF












 _           _       _                          _       
| |         | |     (_)                        | |      
| |     __ _| |__    _ ___   _ __ ___  __ _  __| |_   _ 
| |    / _\` | '_ \  | / __| | '__/ _ \/ _\` |/ _\` | | | |
| |___| (_| | |_) | | \__ \ | | |  __/ (_| | (_| | |_| |
\_____/\__,_|_.__/  |_|___/ |_|  \___|\__,_|\__,_|\__, |
                                                   __/ |
                                                  |___/ 






 _   _                  ______                          
| | | |                 |  ___|                         
| |_| | __ ___   _____  | |_ _   _ _ __                 
|  _  |/ _\` \ \ / / _ \ |  _| | | | '_ \                
| | | | (_| |\ V /  __/ | | | |_| | | | |               
\_| |_/\__,_| \_/ \___| \_|  \__,_|_| |_|               
                                                        

Challenge start here by default: http://localhost:8000

EOF

exec "$@"
