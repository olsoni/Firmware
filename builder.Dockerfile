FROM px4io/px4-dev-nuttx-bionic:2020-04-01 as px4-base-dev

ENV PX4_HOME /home/skyspecs/Firmware

RUN echo "Set disable_coredump false" > /etc/sudo.conf && \
    apt-get update && \
    apt-get install -y sudo apt-utils && \
    apt-get install -y make build-essential rsync mlocate vim && \
    ln -fs /usr/share/zoneinfo/America/New_York /etc/localtime

RUN bash -c 'pip3 install --user pyserial'

COPY ./ $PX4_HOME/

RUN bash -c 'cd $PX4_HOME && git submodule absorbgitdirs'

RUN bash -c 'cd $PX4_HOME && make px4_fmu-v3_default'

CMD bash -c 'cd $PX4_HOME && make px4_fmu-v3_default upload'
