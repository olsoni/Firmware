FROM ubuntu:18.04 as px4-base-dev
USER root

ENV PX4_HOME /home/skyspecs/Firmware

RUN echo "Set disable_coredump false" > /etc/sudo.conf && \
    apt-get update && \
    apt-get install -y sudo apt-utils && \
    apt-get install -y make build-essential rsync mlocate && \
    ln -fs /usr/share/zoneinfo/America/New_York /etc/localtime

COPY ./Tools/setup $PX4_HOME/Tools/setup

RUN bash -c 'cd $PX4_HOME && bash ./Tools/setup/ubuntu.sh'

RUN bash -c 'sudo updatedb && \
             echo "export PATH=\$PATH:$(dirname `locate bin/arm-none-eabi-gcc | head -n1`)" > $PX4_HOME/env'

COPY ./ $PX4_HOME/

RUN bash -c 'cd $PX4_HOME && source ./env && make px4_fmu-v3_default'

CMD bash -c 'cd $PX4_HOME && source ./env && make px4_fmu-v3_default upload'
