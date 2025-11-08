set -e

# Actualizar el sistema
sudo apt-get update
sudo apt-get upgrade -y

# Instalar dependencias necesarias
sudo apt-get install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

# Agregar la clave GPG oficial de Docker
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

# Agregar el repositorio de Docker

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Instalar Docker Engine
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Habilitar e iniciar Docker
sudo systemctl enable docker
sudo systemctl start docker

# Verificar la instalación
sudo docker --version

echo "Docker se ha instalado correctamente."
