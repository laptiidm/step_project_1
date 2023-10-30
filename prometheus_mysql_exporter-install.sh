#!/bin/bash

sudo groupadd --system mysql_exporter
sudo useradd -s /sbin/nologin --system -g mysql_exporter mysql_exporter

curl -LO https://github.com/prometheus/mysqld_exporter/releases/download/v0.14.0/mysqld_exporter-0.14.0.linux-amd64.tar.gz
sudo tar -xvf mysqld_exporter*.tar.gz
sudo mv  mysqld_exporter-*.linux-amd64/mysqld_exporter /usr/local/bin/
sudo rm -rf mysqld_exporter*

sudo chown mysql_exporter:mysql_exporter /usr/local/bin/mysqld_exporter
sudo mkdir /etc/mysqld_exporter/
sudo touch /etc/mysqld_exporter/mysqld_exporter.cnf
cat <<EOL > /etc/mysqld_exporter/mysqld_exporter.cnf
[client]
user=mysql_exporter
password=exporter
host=127.0.0.1
port = 3306
EOL

sudo chown mysql_exporter:mysql_exporter /etc/mysqld_exporter/mysqld_exporter.cnf
sudo touch /etc/systemd/system/mysql_exporter.service
cat <<EOL > /etc/systemd/system/mysql_exporter.service
[Unit]
Description=Prometheus MySQL Exporter Service

[Service]
After=network.target
User=mysql_exporter
Group=mysql_exporter
Type=simple
Restart=always

ExecStart=/usr/local/bin/mysqld_exporter \
    --collect.info_schema.tables.databases=shop_db \
    --config.my-cnf /etc/mysqld_exporter/mysqld_exporter.cnf \
    --collect.global_status \
    --collect.info_schema.innodb_metrics \
    --collect.auto_increment.columns \
    --collect.info_schema.processlist \
    --collect.binlog_size \
    --collect.info_schema.tablestats \
    --collect.global_variables \
    --collect.info_schema.query_response_time \
    --collect.info_schema.userstats \
    --collect.info_schema.tables \
    --collect.perf_schema.tablelocks \
    --collect.perf_schema.file_events \
    --collect.perf_schema.eventswaits \
    --collect.perf_schema.indexiowaits \
    --collect.perf_schema.tableiowaits \
    --collect.slave_status \
    --web.listen-address=0.0.0.0:9104

[Install]
WantedBy=multi-user.target
EOL

sudo systemctl daemon-reload
sudo systemctl enable mysql_exporter
sudo systemctl start mysql_exporter

