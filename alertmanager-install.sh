#!/bin/bash

# system user creating 
sudo useradd --system --no-create-home --shell /bin/false alertmanager

# install alertmanager
wget https://github.com/prometheus/alertmanager/releases/download/v0.26.0/alertmanager-0.26.0.linux-amd64.tar.gz
tar -xvf alertmanager-0.26.0.linux-amd64.tar.gz

# create directories
sudo mkdir -p /alertmanager-data /etc/alertmanager

# copie binaries
sudo mv alertmanager-0.26.0.linux-amd64/alertmanager /usr/local/bin/
sudo mv alertmanager-0.26.0.linux-amd64/alertmanager.yml /etc/alertmanager/
rm -rf alertmanager*

# create systemd service 
sudo touch /etc/systemd/system/alertmanager.service

cat <<EOL > /etc/systemd/system/alertmanager.service
[Unit]
Description=Alertmanager
Wants=network-online.target
After=network-online.target

StartLimitIntervalSec=500
StartLimitBurst=5

[Service]
User=alertmanager
Group=alertmanager
Type=simple
Restart=on-failure
RestartSec=5s
ExecStart=/usr/local/bin/alertmanager \
  --storage.path=/alertmanager-data \
  --config.file=/etc/alertmanager/alertmanager.yml

[Install]
WantedBy=multi-user.target
EOL

# run our service
sudo systemctl enable alertmanager
sleep 5
sudo systemctl start alertmanager
