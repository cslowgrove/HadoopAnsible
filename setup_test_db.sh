cd ~/
if [ -f test.csv ]; then
    rm test.csv
fi
head /mnt/hgfs/shared_area/hourly.csv -n 1000 >> test.csv
cd hadoop-2.7.3
~/hadoop-2.7.3/sbin/stop-all.sh
#bin/hdfs namenode -format -nonInteractive
~/hadoop-2.7.3/sbin/start-all.sh
~/hadoop-2.7.3/bin/hdfs dfs -mkdir -p /weatherdata
~/hadoop-2.7.3/bin/hdfs dfs -put /home/charlie/test.csv /weatherdata/
cd apache-hive-2.1.1-bin
~/hadoop-2.7.3/apache-hive-2.1.1-bin/bin/hive -f /mnt/hgfs/shared_area/hive.sql