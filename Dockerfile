# Use the official PHP and Laravel Sail base image
FROM laravelsail/php80-composer:latest

# Set the working directory inside the container
WORKDIR /var/www

# Copy your project files into the container
COPY . /var/www

# Install dependencies
RUN composer install

# Expose the port you are using for your Statamic project (e.g., 80 for HTTP)
EXPOSE 80

# Start the development server (adjust this command according to your project's setup)
CMD ["php", "artisan", "sail:serve"]
