FROM centos:latest

MAINTAINER DMQB_yellow

# Setting the working directory to /Tss_workflow
WORKDIR /Tss_workflow

# Upgrading system
RUN yum -y upgrade
RUN yum -y install wget

# Downloading Java
RUN wget --no-cookies --no-check-certificate --header "Cookie: oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u131-b11/d54c1d3a095b4ff2b6607d096fa80163/jdk-8u131-linux-x64.rpm" -O /tmp/jdk-8-linux-x64.rpm
RUN yum -y install /tmp/jdk-8-linux-x64.rpm
RUN rm /tmp/jdk-8-linux-x64.rpm

# Setting environment for Java
ENV JAVA_HOME /usr/java/latest

# Downloading tsstools
RUN wget "https://lambda.informatik.uni-tuebingen.de/nexus/content/repositories/releases/org/unituebingen/it/tsstools/1.0beta/tsstools-1.0beta-dependencies.jar"  -O tsstools.jar

CMD ["/bin/bash"]

