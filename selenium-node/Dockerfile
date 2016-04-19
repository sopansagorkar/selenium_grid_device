FROM sopansagorkar/install_android

MAINTAINER Sukhada Sankpal<sukhadas@cybage.com>

ENV ANDROID_EMULATOR_FORCE_32BIT true

#--- Basic prerequisites for Android, NPM, Appium

RUN dpkg-divert --local --rename --add /sbin/initctl

RUN ln -sf /bin/true /sbin/initctl

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get -y --force-yes update

RUN apt-get install -y sudo openssh-server curl lsb-release

RUN apt-get install -y nano

ENV TERM xterm

WORKDIR /usr/local

ENV PWD /usr/local

ENV HOME /root

RUN apt-get -y install libc6-i386 lib32stdc++6 lib32gcc1 lib32ncurses5 lib32z1 libgles2-mesa-dev 

#--- Node installation

RUN rm -rf node*

RUN sudo wget https://nodejs.org/download/release/v0.12.10/node-v0.12.10-linux-x64.tar.gz

RUN sudo tar -xvf node-v0.12.10-linux-x64.tar.gz

ENV PATH $PATH:$PWD/node-v0.12.10-linux-x64/bin

ENV ANDROID_AVD_HOME /root/.android/avd

COPY ./Dockerfile /opt/

COPY ./nodeConfig.json /usr/local/

ADD setpath.sh .

RUN chmod +x setpath.sh

RUN npm install -g -f appium

CMD ["/bin/bash","./setpath.sh"]
