FROM tomcat:9.0.86-jre8
USER root
COPY ./target/ROOT.war /usr/local/tomcat/webapps/
COPY ./server.xml /usr/local/tomcat/conf/server.xml
CMD ["catalina.sh","run"]