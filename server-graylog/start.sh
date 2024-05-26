sudo mkdir /mongo_data
sudo mkdir /os_data
sudo mkdir /os_dashboard_data
sudo mkdir /graylog_journal
sudo chmod 777 -R /mongo_data
sudo chmod 777 -R /os_data
sudo chmod 777 -R /os_dashboard_data
sudo chmod 777 -R /graylog_journal
sudo docker-compose up -d
