# Pull base image 
From tomcat:8-jre8 

# Maintainer
MAINTAINER "DeepanshuKumar" 

# copy war file on to container 
COPY ./BookStore.war /usr/local/tomcat/webapps
