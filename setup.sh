#!/bin/bash
apt update
apt -y install apache2
ufw allow 'Apache'
touch /var/www/html/health_check
