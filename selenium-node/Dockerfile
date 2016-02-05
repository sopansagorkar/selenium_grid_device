FROM ubuntu:14.04

MAINTAINER Sopan/Sneha

RUN apt-get update 

RUN apt-get install -y wget

RUN apt-get install -y openjdk-7-jre-headless lib32z1 lib32ncurses5 lib32bz2-1.0 g++-multilib

RUN wget -qO- "http://dl.google.com/android/android-sdk_r24.4.1-linux.tgz" | tar -zxv -C /opt/

RUN echo y | /opt/android-sdk-linux/tools/android update sdk --all --filter platform-tools,build-tools-20.0.0 --no-ui --force

ENV ANDROID_HOME /opt/android-sdk-linux

RUN apt-get install -y nodejs

RUN apt-get install -y npm

COPY run.sh /opt/selenium/node01/run.sh

RUN chown -R 777 /opt/selenium/node01

RUN useradd -m -s /bin/bash automator -G sudo 

RUN echo automator:password | chpasswd 

USER automator

RUN wget -qO- "http://dl.google.com/android/android-sdk_r24.4.1-linux.tgz" | tar -zxv -C /home/automator

RUN echo y | /home/automator/android-sdk-linux/tools/android update sdk --no-ui --all --filter platform-tools,build-tools-19.1.0,system-image,android-19,extra-android-support --force

RUN sudo apt-get install build-essential curl git m4 ruby texinfo libbz2-dev libcurl4-openssl-dev libexpat-dev libncurses-dev zlib1g-dev

RUN ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/linuxbrew/go/install)"

RUN PATH $HOME/.linuxbrew/bin:$PATH

RUN MANPATH $HOME/.linuxbrew/share/man:$MANPATH

RUN INFOPATH $HOME/.linuxbrew/share/info:$INFOPATH

RUN brew update

RUN brew install node

RUN brew link node

RUN npm install -g appium

RUN npm install wd

CMD ["/bin/sh","-e","/opt/selenium/node01/run.sh"]
