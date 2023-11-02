## step_project_1 >> vagrant configuration:
* deploying an environment with two virtual machines
* the role of the first machine is an supervisor
* the "supervisor" is deployed with pre-installed: Grafana, Prometheus, Prometheus Alert manager

![image](screenshots/grafana_status.png)

![image](screenshots/prometheus.png)

![image](screenshots/alertmanager.png)

* the role of the second machine is a subordinate
* the "subordinate" is deployed with pre-installed: MysqlServer, Prometheus mysql exporter, Prometheus node exporter

![image](screenshots/mysql.png)

![image](screenshots/mysql_exporter.png)

![image](screenshots/node_exporter.png)

* prometheus mysql exporter collects metrics from mysql server ("shop_db" database including)

![image](screenshots/mysql_metrics_db.png)

* data collection is configured in the files: mysqld_exporter.cnf and /etc/systemd/system/mysql_exporter.service (detailed in __prometheus_mysql_exporter-install.sh__)

![image](screenshots/mysql_exporter.cnf.png)

* further in the file __mysql_server-install.sh__ a database __"shop_db"__ is created as well as a user who collects metrics with the specific access rights

![image](screenshots/shop_db_end_user.png)

* configurations for collecting metrics from mysql_exporter are added into __prometheus.yml__ file

![image](screenshots/job_prometheus_yml.png)

* prometheus successfully collects metrics from "subordinate"

![image](screenshots/mysql_shop_db_metric_example.png)

![image](screenshots/node_exp_metrics_example.png)

![image](screenshots/node_metrics.png)

![image](screenshots/mysql_metrics.png)

* pre-installed Alertmanager is configured to send notifications by email

```
global:
  resolve_timeout: 30s

route:
  group_by: ['alertname']
  group_wait: 10s
  group_interval: 10s
  repeat_interval: 10s
  receiver: 'email'
receivers:
- name: 'email'
  email_configs:
  - to: 'laptii.dm@gmail.com'
    from: 'laptii.dm@gmail.com'
    smarthost: smtp.gmail.com:587
    auth_username: 'laptii.dm@gmail.com'
    auth_identity: 'laptii.dm@gmail.com'
    auth_password: 'jjpt tyca hybz ittw'
inhibit_rules:
  - source_match:
      severity: 'critical'
    target_match:
      severity: 'warning'
    equal: ['alertname', 'dev', 'instance']
```











