#!/bin/bash

# Добавляем ключ GPG для репозитория Grafana
wget -q -O - https://packages.grafana.com/gpg.key | sudo apt-key add -

# Добавляем репозиторий Grafana
echo "deb https://packages.grafana.com/oss/deb stable main" | sudo tee -a /etc/apt/sources.list.d/grafana.list

# Обновляем список пакетов
sudo apt-get update -y

# Устанавливаем Grafana
sudo apt-get -y install grafana

# Включаем и запускаем службу Grafana
sudo systemctl enable grafana-server
sleep 5
sudo systemctl start grafana-server
