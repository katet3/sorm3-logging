#!/bin/bash
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
