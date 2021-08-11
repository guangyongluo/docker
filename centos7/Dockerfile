FROM centos:7
EXPOSE 5672
EXPOSE 15672
WORKDIR /data
WORKDIR bb
ENV BASE_PATH /data/bb
COPY aa.txt /data/bb
ADD bb.txt /data/bb
#ADD https://apache.website-solution.net/tomcat/tomcat-10/v10.0.10/bin/apache-tomcat-10.0.10.tar.gz /data/bb
ADD apache-tomcat-10.0.10.tar.gz $BASE_PATH
RUN mv apache-tomcat-10.0.10 tomcat
WORKDIR tomcat
VOLUME $BASE_PATH/tomcat/webapps
#ENTRYPOINT ls $BASE_PATH/tomcat
CMD ls $BASE_PATH/tomcat
