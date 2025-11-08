# Utilidades para Servidores Linux

Este repositorio contiene scripts y herramientas útiles para administración de servidores Linux.

## Instalación de Docker

### Descripción

Script automatizado para instalar Docker Engine en servidores Linux (Ubuntu/Debian).

### Archivo

- `instalar_docker.sh` - Script de instalación completo de Docker

### Pasos para usar el script en el servidor Linux:

#### 1. Navegar al directorio del usuario

```bash
cd ~
```

#### 2. Crear el archivo del script

Puedes usar `nano` o `vim`:

```bash
nano instalar_docker.sh
```

O alternativamente:

```bash
vim instalar_docker.sh
```

#### 3. Copiar y pegar el contenido

Copia el contenido completo del archivo `instalar_docker.sh` y pégalo en el editor.

#### 4. Guardar y cerrar el editor

**En nano:**

- `Ctrl + O` para guardar
- `Enter` para confirmar
- `Ctrl + X` para salir

**En vim:**

- `Esc` para modo comando
- `:wq` y `Enter` para guardar y salir

#### 5. Dar permisos de ejecución

```bash
chmod +x instalar_docker.sh
```

#### 6. Ejecutar el script

```bash
./instalar_docker.sh
```

### Verificación de la instalación

#### Verificar versión de Docker

```bash
docker --version
```

#### Verificar estado del servicio Docker

```bash
sudo systemctl status docker
```

### Lo que hace el script:

1. Actualiza el sistema
2. Instala dependencias necesarias (ca-certificates, curl, gnupg, lsb-release)
3. Agrega la clave GPG oficial de Docker
4. Configura el repositorio de Docker
5. Instala Docker Engine, CLI y plugins
6. Habilita e inicia el servicio Docker
7. Verifica la instalación

### Requisitos:

- Sistema Ubuntu/Debian
- Acceso sudo
- Conexión a internet

---

## Clonar Repositorios Privados de GitHub

### Descripción

Guía para clonar repositorios privados usando tokens de acceso personal.

### Requisitos previos

- Git instalado en el servidor
- Cuenta de GitHub con acceso al repositorio privado

### Verificar si Git está instalado

```bash
git --version
```

### Instalar Git (si no está instalado)

```bash
sudo apt update
sudo apt install git -y
```

### Configurar Token de Acceso Personal

#### 1. Crear token en GitHub:

- Ve a GitHub → Settings → Developer settings → Personal access tokens → Tokens (classic)
- Selecciona "Generate new token (classic)"
- Configura el token para un repositorio específico

#### 2. Permisos mínimos necesarios:

**Repository permissions:**

- ✅ **Contents** → **Read**
- ✅ **Metadata** → **Read**

#### 3. Clonar el repositorio:

```bash
git clone https://TU_TOKEN@github.com/usuario/repositorio.git
```

### Navegación básica después del clonado

#### Ver ubicación actual:

```bash
pwd
```

#### Ver contenido del directorio:

```bash
ls -la
```

#### Entrar a la carpeta del proyecto:

```bash
cd nombre-del-repositorio
```

#### Ver estructura del proyecto:

```bash
ls -la
```

### Notas importantes:

- Nunca compartas tus tokens de acceso
- Los tokens son temporales y pueden expirar
- Para solo clonar, los permisos de lectura son suficientes

---

## Crear Archivos de Variables de Entorno (.env)

### Descripción

Guía para crear y configurar archivos `.env` para proyectos en el servidor Linux.

### Pasos para crear archivo .env

#### 1. Navegar al directorio del proyecto

```bash
cd ~/nombre-del-proyecto
```

#### 2. Crear el archivo .env

Usando `nano` (recomendado):

```bash
nano .env
```

O usando `vim`:

```bash
vim .env
```

#### 3. Formato de variables de entorno

Pega las variables con este formato:

```bash
# Configuración de base de datos
DATABASE_URL=postgresql://usuario:password@localhost:5432/nombre_db
DATABASE_HOST=localhost
DATABASE_PORT=5432

# API Keys
API_KEY=tu_api_key_aqui
SECRET_KEY=tu_secret_key_aqui

# Configuración de entorno
NODE_ENV=production
PORT=3000

# URLs y dominios
BASE_URL=https://tu-dominio.com
FRONTEND_URL=https://frontend.tu-dominio.com
```

#### 4. Guardar y cerrar el editor

**En nano:**

- `Ctrl + O` para guardar
- `Enter` para confirmar
- `Ctrl + X` para salir

**En vim:**

- `Esc` para modo comando
- `:wq` y `Enter` para guardar y salir

#### 5. Verificar la creación del archivo

```bash
ls -la .env
```

#### 6. Ver el contenido (opcional)

```bash
cat .env
```

### Configurar permisos de seguridad

```bash
chmod 600 .env
```

Esto hace que solo el propietario pueda leer/escribir el archivo.

### Notas importantes:

- Nunca subas archivos `.env` a repositorios públicos
- Agrega `.env` a tu `.gitignore`
- Usa valores diferentes para desarrollo y producción
- Mantén copias de seguridad de tus variables de entorno

---

## Ejecutar Docker Compose en el Servidor

### Descripción

Guía para ejecutar proyectos que usan Docker Compose en el servidor Linux.

### Requisitos previos

- Docker instalado y funcionando
- Proyecto clonado con archivo `docker-compose.yml`
- Archivo `.env` configurado (si es necesario)

### Configurar permisos de Docker

#### 1. Agregar usuario al grupo docker:

```bash
sudo usermod -aG docker $USER
```

#### 2. Aplicar cambios de grupo:

**Opción A - Reiniciar sesión SSH:**

```bash
exit
```

Luego conéctate nuevamente.

**Opción B - Cambiar grupo sin desconectar:**

```bash
newgrp docker
```

#### 3. Verificar permisos:

```bash
docker ps
```

### Ejecutar el proyecto

#### 1. Navegar al directorio del proyecto:

```bash
cd ~/nombre-del-proyecto
```

#### 2. Verificar archivo Docker Compose:

```bash
ls -la docker-compose.yml
```

#### 3. Ejecutar en segundo plano (recomendado):

```bash
docker compose up -d
```

#### 4. Ejecutar en primer plano (para ver logs):

```bash
docker compose up
```

#### 5. Forzar reconstrucción:

```bash
docker compose up --build -d
```

### Comandos de gestión

#### Ver estado de contenedores:

```bash
docker compose ps
```

#### Ver logs:

```bash
docker compose logs
```

#### Ver logs en tiempo real:

```bash
docker compose logs -f
```

#### Detener servicios:

```bash
docker compose down
```

#### Detener y eliminar volúmenes:

```bash
docker compose down -v
```

### Solución de problemas comunes

#### Error de permisos:

Si ves errores de "permission denied", ejecuta:

```bash
sudo usermod -aG docker $USER
newgrp docker
```

#### Warning sobre versión:

El warning sobre `version` en docker-compose.yml es menor y puede ignorarse.

---

## Configurar Nginx como Proxy Reverso

### Descripción

Script automatizado para configurar Nginx como proxy reverso y exponer aplicaciones Docker a internet.

### Archivo

- `configurar_nginx_proxy.sh` - Script de configuración completo de Nginx

### Pasos para usar el script en el servidor Linux:

#### 1. Navegar al directorio del usuario

```bash
cd ~
```

#### 2. Crear el archivo del script

```bash
nano configurar_nginx_proxy.sh
```

#### 3. Copiar y pegar el contenido

Copia el contenido completo del archivo `configurar_nginx_proxy.sh` y pégalo en el editor.

#### 4. Guardar y cerrar el editor

- `Ctrl + O` para guardar
- `Enter` para confirmar
- `Ctrl + X` para salir

#### 5. Dar permisos de ejecución

```bash
chmod +x configurar_nginx_proxy.sh
```

#### 6. Ejecutar el script

```bash
./configurar_nginx_proxy.sh
```

El script te pedirá tu dominio o IP del servidor (ej: `192.168.1.209`).

### Configurar URLs para comunicación Frontend-Backend

Después de ejecutar el script, debes actualizar las URLs en tu proyecto:

#### 1. Actualizar .env del frontend

```bash
cd ~/tu-proyecto/frontend
nano .env
```

Cambiar:

```bash
VITE_WORKER_URL=http://localhost:8000/api/v1/
```

Por:

```bash
VITE_WORKER_URL=http://TU_IP_SERVIDOR/api/v1/
```

#### 2. Actualizar CORS en el backend

```bash
cd ~/tu-proyecto/backend
nano .env
```

Agregar tu IP a CORS_ORIGIN:

```bash
CORS_ORIGIN=http://localhost:5173,http://localhost:3000,http://TU_IP_SERVIDOR
```

#### 3. Reconstruir contenedores

```bash
cd ~/tu-proyecto
docker compose down
docker compose up --build -d
```

### Lo que hace el script:

1. Instala y configura Nginx
2. Crea configuración de proxy reverso
3. Configura rutas para frontend (puerto 5173) y backend (puerto 8000)
4. Habilita firewall para puertos 80 y 443
5. Reinicia servicios

### Verificación post-instalación

#### Ver IP del servidor:

```bash
hostname -I
```

#### Verificar estado de Nginx:

```bash
sudo systemctl status nginx
```

#### Ver logs de Nginx:

```bash
sudo tail -f /var/log/nginx/access.log
sudo tail -f /var/log/nginx/error.log
```

#### Verificar contenedores:

```bash
docker compose ps
```

### Acceso a las aplicaciones:

- **Frontend**: `http://TU_IP_SERVIDOR`
- **Backend API**: `http://TU_IP_SERVIDOR/api/`

### Para configurar HTTPS:

```bash
sudo apt install certbot python3-certbot-nginx -y
sudo certbot --nginx -d tu-dominio.com
```

---

## Configurar SSL/HTTPS Gratuito

### Descripción

Guía para configurar certificados SSL gratuitos usando Let's Encrypt para habilitar HTTPS en tus aplicaciones.

### Requisitos

- Nginx configurado y funcionando
- **Dominio propio** apuntando a tu servidor
- Acceso sudo al servidor

### Opciones para obtener un dominio

#### Dominios gratuitos:

- **DuckDNS**: `miapp.duckdns.org` (recomendado)
- **Freenom**: `.tk`, `.ml`, `.ga`, `.cf`
- **No-IP**: `miapp.ddns.net`

#### Dominios de pago (económicos):

- **Namecheap**, **GoDaddy**: $8-15/año
- **Google Domains**, **Cloudflare**

### Configurar DuckDNS (Gratuito)

#### 1. Crear cuenta en DuckDNS:

- Ve a `https://www.duckdns.org`
- Inicia sesión con GitHub, Google, etc.

#### 2. Crear subdominio:

- Elige un nombre: `miapp.duckdns.org`
- Ingresa la IP de tu servidor
- Anota tu token

#### 3. Actualizar configuración de Nginx:

```bash
sudo nano /etc/nginx/sites-available/onku-app
```

Cambiar `server_name` por tu dominio:

```nginx
server_name miapp.duckdns.org;
```

#### 4. Reiniciar Nginx:

```bash
sudo nginx -t
sudo systemctl reload nginx
```

### Instalar certificado SSL

#### 1. Instalar Certbot:

```bash
sudo apt update
sudo apt install certbot python3-certbot-nginx -y
```

#### 2. Generar certificado SSL:

```bash
sudo certbot --nginx -d tu-dominio.duckdns.org
```

#### 3. Seguir las instrucciones:

- Ingresa tu email
- Acepta términos de servicio
- Elige si compartir email (opcional)
- Selecciona redirigir HTTP a HTTPS (recomendado)

#### 4. Verificar certificado:

```bash
sudo certbot certificates
```

### Configuración automática de renovación

#### Verificar renovación automática:

```bash
sudo certbot renew --dry-run
```

#### Ver estado del timer de renovación:

```bash
sudo systemctl status certbot.timer
```

### Actualizar URLs del proyecto

Después de configurar SSL, actualiza tus .env:

#### Frontend:

```bash
VITE_WORKER_URL=https://tu-dominio.duckdns.org/api/v1/
```

#### Backend CORS:

```bash
CORS_ORIGIN=https://tu-dominio.duckdns.org,http://localhost:5173
```

#### Reconstruir contenedores:

```bash
docker compose down
docker compose up --build -d
```

### Verificación final

Tu aplicación ahora estará disponible en:

- **HTTPS**: `https://tu-dominio.duckdns.org` ✅
- **HTTP**: Redirige automáticamente a HTTPS

### Comandos útiles

#### Ver logs de Certbot:

```bash
sudo tail -f /var/log/letsencrypt/letsencrypt.log
```

#### Renovar manualmente:

```bash
sudo certbot renew
```

#### Eliminar certificado:

```bash
sudo certbot delete --cert-name tu-dominio.duckdns.org
```

### Notas importantes:

- Los certificados de Let's Encrypt son válidos por 90 días
- La renovación automática se configura automáticamente
- DuckDNS es gratuito pero requiere actualizar la IP si cambia
- Para dominios de pago, la configuración es idéntica

---

## Configurar Auto-Inicio del Proyecto

### Descripción

Configuración para que tu proyecto Docker Compose se inicie automáticamente cuando se encienda el servidor.

### Opción 1: Servicio Systemd (Recomendado)

#### 1. Crear archivo de servicio:

```bash
sudo nano /etc/systemd/system/onku-app.service
```

#### 2. Contenido del archivo:

```ini
[Unit]
Description=Onku App Docker Compose
Requires=docker.service
After=docker.service

[Service]
Type=oneshot
RemainAfterExit=yes
WorkingDirectory=/home/TU_USUARIO/nombre-del-proyecto
ExecStart=/usr/bin/docker compose up -d
ExecStop=/usr/bin/docker compose down
TimeoutStartSec=0
User=TU_USUARIO
Group=docker

[Install]
WantedBy=multi-user.target
```

**Importante:** Cambiar `TU_USUARIO` y `nombre-del-proyecto` por los valores correctos.

#### 3. Habilitar y iniciar el servicio:

```bash
sudo systemctl daemon-reload
sudo systemctl enable onku-app.service
sudo systemctl start onku-app.service
```

#### 4. Verificar estado:

```bash
sudo systemctl status onku-app.service
```

### Opción 2: Docker Restart Policy

#### Modificar docker-compose.yml:

Agregar `restart: unless-stopped` a cada servicio:

```yaml
services:
  onku-frontend:
    restart: unless-stopped
    # ... resto de configuración

  onku-backend:
    restart: unless-stopped
    # ... resto de configuración
```

#### Aplicar cambios:

```bash
docker compose down
docker compose up -d
```

### Opción 3: Cron Job con @reboot

#### 1. Editar crontab:

```bash
crontab -e
```

#### 2. Agregar línea:

```bash
@reboot cd /home/TU_USUARIO/nombre-del-proyecto && /usr/bin/docker compose up -d
```

### Comandos útiles para gestionar el servicio

#### Ver estado del servicio:

```bash
sudo systemctl status onku-app.service
```

#### Iniciar manualmente:

```bash
sudo systemctl start onku-app.service
```

#### Detener:

```bash
sudo systemctl stop onku-app.service
```

#### Deshabilitar auto-inicio:

```bash
sudo systemctl disable onku-app.service
```

#### Ver logs del servicio:

```bash
sudo journalctl -u onku-app.service -f
```

#### Reiniciar servicio:

```bash
sudo systemctl restart onku-app.service
```

### Verificar que funciona

#### 1. Reiniciar el servidor:

```bash
sudo reboot
```

#### 2. Después de reiniciar, verificar contenedores:

```bash
docker compose ps
```

#### 3. Verificar servicio:

```bash
sudo systemctl status onku-app.service
```

### Notas importantes:

- La **Opción 1 (Systemd)** es la más robusta y recomendada
- La **Opción 2 (Restart Policy)** es más simple pero depende de Docker
- La **Opción 3 (Cron)** es básica pero funcional
- Siempre usa rutas absolutas en las configuraciones
- Verifica que el usuario tenga permisos para Docker

---

## Otros Scripts

_Espacio para futuras utilidades..._

===============================================================
