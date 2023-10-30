#!/bin/bash

# Обновляем пакеты
sudo apt-get update -y

# Создаем системного пользователя Prometheus
sudo useradd --system --no-create-home --shell /bin/false prometheus

# Загружаем и устанавливаем Prometheus
wget https://github.com/prometheus/prometheus/releases/download/v2.32.1/prometheus-2.32.1.linux-amd64.tar.gz
tar -xvf prometheus-2.32.1.linux-amd64.tar.gz

# Создаем необходимые директории
sudo mkdir -p /data /etc/prometheus

# Копируем бинарники и конфигурацию
cd prometheus-2.32.1.linux-amd64
sudo mv prometheus promtool /usr/local/bin/
sudo mv consoles/ console_libraries/ /etc/prometheus/
sudo mv prometheus.yml /etc/prometheus/prometheus.yml
cd ~
sudo rm -rf prometheus*

# Устанавливаем правильные разрешения
sudo chown -R prometheus:prometheus /etc/prometheus/ /data

# Создаем systemd service файл
sudo touch /etc/systemd/system/prometheus.service

cat <<EOL > /etc/systemd/system/prometheus.service
[Unit]
Description=Prometheus
Wants=network-online.target
After=network-online.target

StartLimitIntervalSec=500
StartLimitBurst=5

[Service]
User=prometheus
Group=prometheus
Type=simple
Restart=on-failure
RestartSec=5s
ExecStart=/usr/local/bin/prometheus \
  --config.file=/etc/prometheus/prometheus.yml \
  --storage.tsdb.path=/data \
  --web.console.templates=/etc/prometheus/consoles \
  --web.console.libraries=/etc/prometheus/console_libraries \
  --web.listen-address=0.0.0.0:9090 \
  --web.enable-lifecycle

[Install]
WantedBy=multi-user.target
EOL

# Включаем и запускаем службу
sudo systemctl enable prometheus
sleep 5
sudo systemctl start prometheus
