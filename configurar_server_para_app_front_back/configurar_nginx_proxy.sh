# Pasos para crear y ejecutar este script en el servidor Linux:
#
# 1. Ir al directorio del usuario:
#    cd ~
#
# 2. Crear el archivo con nano o vim:
#    nano configurar_nginx_proxy.sh
#    # (o)
#    vim configurar_nginx_proxy.sh
#
# 3. Copiar y pegar el contenido del script en el editor.
#
# 4. Guardar y cerrar el editor:
#    # En nano: Ctrl+O, Enter, Ctrl+X
#    # En vim: Esc, :wq, Enter
#
# 5. Dar permisos de ejecución:
#    chmod +x configurar_nginx_proxy.sh
#
# 6. Ejecutar el script:
#    ./configurar_nginx_proxy.sh
#    # (o)
#    sudo ./configurar_nginx_proxy.sh

#!/bin/bash
# Script para configurar Nginx como proxy reverso para aplicaciones Docker

set -e

echo "=== Configurando Nginx como Proxy Reverso ==="

# Solicitar información al usuario
read -p "Ingresa tu dominio o IP del servidor (ej: mi-servidor.com o 192.168.1.100): " DOMAIN

# Actualizar el sistema
echo "Actualizando el sistema..."
sudo apt update

# Instalar Nginx
echo "Instalando Nginx..."
sudo apt install nginx -y

# Crear configuración de Nginx
echo "Creando configuración de Nginx..."
sudo tee /etc/nginx/sites-available/onku-app > /dev/null <<EOF
server {
    listen 80;
    server_name $DOMAIN;

    # Proxy para React Frontend (Puerto 5173)
    location / {
        proxy_pass http://localhost:5173;
        proxy_http_version 1.1;
        proxy_set_header Upgrade \$http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto \$scheme;
        proxy_cache_bypass \$http_upgrade;
    }

    # Proxy para Express Backend API (Puerto 8000)
    location /api/ {
        proxy_pass http://localhost:8000/api/;
        proxy_http_version 1.1;
        proxy_set_header Upgrade \$http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto \$scheme;
        proxy_cache_bypass \$http_upgrade;
    }
}
EOF

# Habilitar el sitio
echo "Habilitando configuración de Nginx..."
sudo ln -sf /etc/nginx/sites-available/onku-app /etc/nginx/sites-enabled/

# Remover configuración por defecto
sudo rm -f /etc/nginx/sites-enabled/default

# Verificar configuración de Nginx
echo "Verificando configuración de Nginx..."
sudo nginx -t

# Habilitar e iniciar Nginx
echo "Habilitando e iniciando Nginx..."
sudo systemctl enable nginx
sudo systemctl restart nginx

# Configurar firewall
echo "Configurando firewall..."
sudo ufw allow 80
sudo ufw allow 443
sudo ufw --force enable

# Verificar estado de Nginx
echo "Verificando estado de Nginx..."
sudo systemctl status nginx --no-pager

echo ""
echo "=== Configuración completada ==="
echo ""
echo "Tu aplicación ahora debería estar accesible en:"
echo "Frontend: http://$DOMAIN"
echo "Backend API: http://$DOMAIN/api/"
echo ""
echo "Comandos útiles:"
echo "- Ver logs de Nginx: sudo tail -f /var/log/nginx/access.log"
echo "- Reiniciar Nginx: sudo systemctl restart nginx"
echo "- Verificar configuración: sudo nginx -t"
echo ""
echo "Para HTTPS, puedes instalar SSL con:"
echo "sudo apt install certbot python3-certbot-nginx -y"
echo "sudo certbot --nginx -d $DOMAIN"