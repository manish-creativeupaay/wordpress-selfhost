# Use the official WordPress image with Apache and PHP
FROM wordpress:php8.2-apache

# Set the working directory
WORKDIR /var/www/html

# Copy custom themes, plugins, and uploads
COPY wp-content /var/www/html/wp-content

# Set permissions for WordPress files
RUN chown -R www-data:www-data /var/www/html

# Expose port 80
EXPOSE 80

# Start Apache in the foreground
CMD ["apache2-foreground"]
