# Use the official WordPress image with Apache and PHP
FROM wordpress:php8.2-apache

# Set the working directory
WORKDIR /var/www/html

# Copy custom themes, plugins, and uploads
COPY wp-content /var/www/html/wp-content

# Install necessary PHP extensions
RUN apt-get update && apt-get install -y \
    php-pgsql \
    php-mbstring \
    php-curl \
    php-xml \
    && rm -rf /var/lib/apt/lists/*

# Set permissions for WordPress files
RUN chown -R www-data:www-data /var/www/html && \
    chmod -R 755 /var/www/html

# Set a default ServerName to avoid Apache warnings
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf

# Enable Apache modules required by WordPress
RUN a2enmod rewrite headers

# Copy pg4wp for PostgreSQL compatibility (if using PostgreSQL)
ADD https://github.com/kevinoid/pg4wp/archive/refs/heads/master.zip /tmp/pg4wp.zip
RUN apt-get update && apt-get install -y unzip && \
    unzip /tmp/pg4wp.zip -d /tmp && \
    mv /tmp/pg4wp-master/db.php wp-content/db.php && \
    mv /tmp/pg4wp-master wp-content/pg4wp && \
    rm -rf /tmp/pg4wp.zip /tmp/pg4wp-master

# Expose port 80
EXPOSE 80

# Start Apache in the foreground
CMD ["apache2-foreground"]
