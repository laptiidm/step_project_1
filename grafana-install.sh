#!/bin/bash

# add ключ GPG key Grafana
wget -q -O - https://packages.grafana.com/gpg.key | sudo apt-key add -

# add repo Grafana
echo "deb https://packages.grafana.com/oss/deb stable main" | sudo tee -a /etc/apt/sources.list.d/grafana.list

# update packet list
sudo apt-get update -y

# install Grafana
sudo apt-get -y install grafana

# run Grafana
sudo systemctl enable grafana-server
sleep 5
sudo systemctl start grafana-server
