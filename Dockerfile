FROM centos:centos7
LABEL Augusto Branquinho <augustobranquinho@gmail.com>

# Requirements
RUN yum -y update && \
    yum -y install wget && \
    yum -y install which

# HDP Repositories
RUN wget http://public-repo-1.hortonworks.com/HDP/centos7/2.x/updates/2.6.4.0/hdp.repo -O /etc/yum.repos.d/hdp.repo
RUN wget http://public-repo-1.hortonworks.com/HDP-GPL/centos7/2.x/updates/2.6.4.0/hdp.gpl.repo -O /etc/yum.repos.d/hdp.gpl.repo

# Install HDP Sqoop
RUN yum -y install sqoop

COPY sqoop/conf/ /etc/sqoop/conf/
COPY sqoop/init-sqoop.sh /etc/sqoop/init-sqoop

# Install Drivers
RUN wget "https://jdbc.postgresql.org/download/postgresql-42.2.1.jar" -O /tmp/postgresql-42.2.1.jar
RUN wget "https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-5.1.45.tar.gz" -O /tmp/mysql-connector-java-5.1.45.tar.gz

RUN cp /tmp/postgresql-42.2.1.jar /usr/hdp/2.6.4.0-91/sqoop/lib/
RUN tar xvzfC /tmp/mysql-connector-java-5.1.45.tar.gz /tmp
RUN cp /tmp/mysql-connector-java-5.1.45/mysql-connector-java-5.1.45-bin.jar /usr/hdp/2.6.4.0-91/sqoop/lib/

# Install Java
ENV JAVA_VERSION 8u162

RUN wget --no-cookies --no-check-certificate --header "Cookie: oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/$JAVA_VERSION-b12/0da788060d494f5095bf8624735fa2f1/jdk-$JAVA_VERSION-linux-x64.rpm" -O /tmp/jdk-8-linux-x64.rpm

RUN yum -y install /tmp/jdk-8-linux-x64.rpm

RUN alternatives --install /usr/bin/java jar /usr/java/latest/bin/java 200000
RUN alternatives --install /usr/bin/javaws javaws /usr/java/latest/bin/javaws 200000
RUN alternatives --install /usr/bin/javac javac /usr/java/latest/bin/javac 200000

ENV JAVA_HOME /usr/java/latest



# RUN echo "export HIVE_HOME=$ {HIVE_HOME:-/usr/hdp/current/hive-server2}" >> /usr/bin/sqoop

# ENTRYPOINT ["/etc/sqoop/init-sqoop"]
#wget --header="Cookie:oraclelicense=accept-securebackup-cookie" --no-check-certificate http://download.oracle.com/otn-pub/java/jdk/8u162-b12/0da788060d494f5095bf8624735fa2f1/jdk-8u162-linux-x64.rpm

