sudo mkdir /mongo_data
sudo mkdir /es_data
sudo mkdir /graylog_journal
sudo chmod 777 -R /mongo_data
sudo chmod 777 -R /es_data
sudo chmod 777 -R /graylog_journal
sudo docker-compose up -d
