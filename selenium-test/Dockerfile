FROM ubuntu:15.04

MAINTAINER Selenium <selenium-developers@googlegroups.com>

ENV TEST_CMD ""
# The remainder of this build will be completed by the upstream image's ONBUILD commands


RUN apt-get update


RUN apt-get install -y openssh-server
RUN sed -i 's|session required pam_loginuid.so|session optional pam_loginuid.so|g' /etc/pam.d/sshd
RUN mkdir -p /var/run/sshd


RUN apt-get install -y openjdk-7-jdk
RUN apt-get install -y ant

RUN mkdir -p /opt/selenium/test

ADD ./run.sh /opt/selenium/test/run.sh

RUN chmod +x /opt/selenium/test/run.sh

CMD ["/bin/sh","-e","/opt/selenium/test/run.sh"]



