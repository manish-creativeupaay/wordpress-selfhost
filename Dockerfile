# Use the official WordPress image with Apache and PHP
FROM wordpress:php8.2-apache

# Set the working directory
WORKDIR /var/www/html

# Copy custom themes, plugins, and uploads
COPY wp-content /var/www/html/wp-content

# Install necessary dependencies and pg4wp
RUN apt-get update && apt-get install -y unzip wget && \
    wget https://github.com/PostgreSQL-For-Wordpress/postgresql-for-wordpress/archive/refs/heads/master.zip -O /tmp/pg4wp.zip && \
    unzip /tmp/pg4wp.zip -d /tmp && \
    mv /tmp/postgresql-for-wordpress-master/db.php /var/www/html/wp-content/db.php && \
    mv /tmp/postgresql-for-wordpress-master /var/www/html/wp-content/pg4wp && \
    rm -rf /tmp/pg4wp.zip /tmp/postgresql-for-wordpress-master

# Set permissions for WordPress files
RUN chown -R www-data:www-data /var/www/html && \
    chmod -R 755 /var/www/html

# Set a default ServerName to avoid Apache warnings
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf

# Enable Apache modules required by WordPress
RUN a2enmod rewrite headers

# Expose port 80
EXPOSE 80

# Start Apache in the foreground
CMD ["apache2-foreground"]
