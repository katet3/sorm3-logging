#!/bin/bash

# Обновление списка пакетов и установка необходимых пакетов
sudo apt-get update
sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common

# Добавление официального GPG ключа Docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# Добавление репозитория Docker в список источников APT
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

# Обновление списка пакетов после добавления репозитория Docker
sudo apt-get update

# Установка Docker CE (Community Edition)
sudo apt-get install -y docker-ce

# Добавление текущего пользователя в группу docker для запуска docker без sudo
sudo usermod -aG docker $USER

# Установка Docker Compose
# Проверка последней версии Docker Compose на GitHub и установка
COMPOSE_VERSION=$(curl -s https://api.github.com/repos/docker/compose/releases/latest | grep 'tag_name' | cut -d\" -f4)
sudo curl -L "https://github.com/docker/compose/releases/download/${COMPOSE_VERSION}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

# Предоставление прав на выполнение для файла Docker Compose
sudo chmod +x /usr/local/bin/docker-compose

# Вывод версии Docker и Docker Compose для проверки
echo "Docker и Docker Compose успешно установлены:"
docker --version
docker-compose --version
