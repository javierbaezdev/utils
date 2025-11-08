# Utilidades para Servidores Linux

Este repositorio contiene una colección de scripts y herramientas útiles para la administración y configuración de servidores Linux.

## 📁 Estructura del Repositorio

### `configurar_server_para_app_front_back/`
Scripts completos para configurar un servidor Linux desde cero para desplegar aplicaciones web full-stack (Frontend + Backend) usando Docker.

**Incluye:**
- 🐳 **Instalación automatizada de Docker**
- 📦 **Configuración de Docker Compose**
- 🔄 **Clonado de repositorios privados de GitHub**
- ⚙️ **Configuración de variables de entorno**
- 🌐 **Nginx como proxy reverso**
- 🔒 **SSL/HTTPS gratuito con Let's Encrypt**

**Para instrucciones detalladas paso a paso, consulta:**
👉 [`configurar_server_para_app_front_back/README.md`](./configurar_server_para_app_front_back/README.md)

---

## 🚀 Inicio Rápido

Si necesitas configurar un servidor Linux completo para aplicaciones web:

1. Ve a la carpeta [`configurar_server_para_app_front_back/`](./configurar_server_para_app_front_back/)
2. Sigue las instrucciones del README interno
3. Ejecuta los scripts en orden según tus necesidades

---

## 🛠️ Scripts Disponibles

| Script | Descripción | Ubicación |
|--------|-------------|-----------|
| `instalar_docker.sh` | Instala Docker Engine completo | `configurar_server_para_app_front_back/` |
| `configurar_nginx_proxy.sh` | Configura Nginx como proxy reverso | `configurar_server_para_app_front_back/` |

---

## 📋 Requisitos Generales

- Servidor Linux (Ubuntu/Debian recomendado)
- Acceso SSH al servidor
- Permisos sudo
- Conexión a internet

---

## 🤝 Contribuciones

¿Tienes scripts útiles para servidores Linux? ¡Las contribuciones son bienvenidas!

---

## 📄 Licencia

Este proyecto está bajo licencia MIT. Siéntete libre de usar, modificar y distribuir estos scripts.

---

## ⚠️ Importante

Estos scripts están diseñados para servidores de desarrollo y producción. Siempre revisa y prueba los scripts en un entorno de desarrollo antes de ejecutarlos en producción.