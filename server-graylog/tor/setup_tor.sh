#!/bin/bash

# Обновление списка пакетов и установка Tor
sudo apt update
sudo apt install -y tor

# Проверка и запуск службы Tor
sudo systemctl start tor
sudo systemctl enable tor

# Настройка конфигурационного файла Tor
sudo bash -c 'cat <<EOF >/etc/tor/torrc
## Tor configuration
AutomapHostsOnResolve 1
TransPort 0.0.0.0:9040
DNSPort 0.0.0.0:53
SOCKSPort 9050
EOF'

# Перезапуск службы Tor для применения новых настроек
sudo systemctl restart tor

# Проверка, что Tor запущен и слушает на нужных портах
sudo ss -plnt | grep -E '9050|9040|53'

# Создание systemd unit override для Docker
sudo mkdir -p /etc/systemd/system/docker.service.d
sudo bash -c 'cat <<EOF >/etc/systemd/system/docker.service.d/http-proxy.conf
[Service]
Environment="HTTP_PROXY=socks5://127.0.0.1:9050"
Environment="HTTPS_PROXY=socks5://127.0.0.1:9050"
Environment="NO_PROXY=localhost,127.0.0.1"
EOF'

# Перезагрузка конфигурации systemd и перезапуск Docker
sudo systemctl daemon-reload
sudo systemctl restart docker

echo "Tor и Docker настроены для работы через Tor."
