FROM ubuntu:18.04 as px4-base-dev
USER root

ENV PX4_HOME /home/skyspecs/Firmware

RUN echo "Set disable_coredump false" > /etc/sudo.conf && \
    apt-get update && \
    apt-get install -y sudo apt-utils && \
    apt-get install -y make build-essential rsync mlocate && \
    ln -fs /usr/share/zoneinfo/America/New_York /etc/localtime

COPY ./ $PX4_HOME/

RUN bash -c 'cd $PX4_HOME && bash ./Tools/setup/ubuntu.sh'
RUN bash -c 'cd $PX4_HOME && make px4_fmu-v3_default'

CMD bash -c 'cd $PX4_HOME && make px4_fmu-v3_default upload'
