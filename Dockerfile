FROM tomcat:8
RUN (cd /usr/local/tomcat/webapps/ && curl -O https://tomcat.apache.org/tomcat-8.0-doc/appdev/sample/sample.war)