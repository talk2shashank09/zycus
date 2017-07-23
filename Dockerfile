# FROM : It is for specifying the base image
# Taking centos6 as base image
FROM centos:6

#MAINTAINER : For specifying the author
MAINTAINER Shashank Gupta

#LABEL : For providing the information about the image
LABEL Description="This is the image of CentOS 6 with installed Python 2.7, MongoDB and Tomcat 7"

#WORKDIR : Specifies the working directory for the RUN, CMD, ENTRYPOINT, COPY and ADD.
WORKDIR /home

#RUN : It will run the commands mentioned in the new layer and commit the changes
#Below RUN block is updating the packages and then install the wget and gcc packages and then through "wget" command it is downloading the python 2.7 package tar from the mentioned URL. The "tar" command extracting the Python-2.7.8.tgz to folder Python-2.7.8 and finally configuring and intalling the python commands are mentioned.
RUN yum -y update && \
    yum -y install wget && \
    yum -y install gcc && \
    wget https://www.python.org/ftp/python/2.7.8/Python-2.7.8.tgz && \
    tar xvfz Python-2.7.8.tgz && \
    cd Python-2.7.8 && \
    ./configure && \
    make && make altinstall


# After this installing mngodb using yum.
RUN yum -y update; yum clean all
RUN yum -y install epel-release; yum clean all
RUN yum -y install mongodb-server; yum clean all
RUN mkdir -p /data/db

# Now, Installing apache tomcat 7 on our container, To run Tomcat we need java.
RUN yum install -y java-1.7.0-openjdk && \
    wget http://www-us.apache.org/dist/tomcat/tomcat-7/v7.0.79/bin/apache-tomcat-7.0.79.tar.gz && \
    tar xzf apache-tomcat-7.0.79.tar.gz && \
    mv apache-tomcat-7.0.79 tomcat7

#EXPOSE : It will inform Docker that the container listens on the mentioned port at runtime.
EXPOSE 8080

#ENTRYPOINT : For specifying the default executable for the image.
ENTRYPOINT ["/home/tomcat7/bin/catalina.sh", "run"]

#####################################################################################################
#For running the image
#docker build -t shashank_image .
#For running the container from the build image run the below mentioned command:
#  docker run -itd -p 7080:8080 --name shashank_container shashank_image
######################################################################################################
