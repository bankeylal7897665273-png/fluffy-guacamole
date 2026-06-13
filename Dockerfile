# 100% PHP support ke liye base Apache image
FROM php:8.2-apache

# Agar 1c.zip use karna hai toh unzip tool install karein
RUN apt-get update && apt-get install -y unzip

# Render dynamically PORT assign karta hai, uske liye Apache ko configure karein
RUN sed -i 's/80/${PORT}/g' /etc/apache2/sites-available/000-default.conf /etc/apache2/ports.conf

# URL Rewrite enable karein (kisi bhi advance PHP script ke liye zaroori)
RUN a2enmod rewrite

# Working directory set karein
WORKDIR /var/www/html/

# GitHub repo ki saari files aur folders ko container me copy karein
COPY . /var/www/html/

# Agar repo me 1c.zip hai, toh use extract karein aur phir zip delete kar dein
RUN if [ -f "1c.zip" ]; then unzip 1c.zip && rm 1c.zip; fi

# Permissions set karein taaki 100% run ho bina kisi error ke
RUN chown -R www-data:www-data /var/www/html/ \
    && chmod -R 755 /var/www/html/
