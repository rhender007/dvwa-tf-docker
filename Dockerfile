# Use an official PHP image as the base
FROM php:7.4-apache

# Install dependencies
RUN yum update && yum install -y \
    git \
    mariadb-client \
    && docker-php-ext-install mysqli

# Enable Apache mod_rewrite
RUN a2enmod rewrite

# Clone DVWA from GitHub
RUN git clone https://github.com/digininja/DVWA.git /var/www/html

# Set permissions
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html

# Copy DVWA config and update it
COPY config.inc.php /var/www/html/config/

# Expose port 80
EXPOSE 80

# Start Apache service
CMD ["apache2-foreground"]
