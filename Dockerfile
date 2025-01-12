# Use the official WordPress image
FROM wordpress:latest

# Copy the local WordPress files into the container
COPY . /var/www/html

# Set the working directory
WORKDIR /var/www/html

# Expose port 80
EXPOSE 80
