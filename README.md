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
![image](screenshots/node_exporter.png)
![image](screenshots/mysql_exporter.png)