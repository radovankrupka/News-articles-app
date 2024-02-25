FROM tomcat:9.0.86-jre8
COPY ./target/ROOT.war /usr/local/tomcat/webapps/