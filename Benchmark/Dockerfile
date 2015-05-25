FROM centos:centos6
MAINTAINER Ruslan Pacevic <rpacevic@gmail.com>

RUN yum -y install openssh-server epel-release && \
    yum -y install pwgen && \
    yum -y install rpm-build yum-utils tar wget nano mc htop which openmpi-devel gcc-c++ && \
    rm -f /etc/ssh/ssh_host_dsa_key /etc/ssh/ssh_host_rsa_key && \
    ssh-keygen -q -N "" -t dsa -f /etc/ssh/ssh_host_dsa_key && \
    ssh-keygen -q -N "" -t rsa -f /etc/ssh/ssh_host_rsa_key && \
    sed -i "s/#UsePrivilegeSeparation.*/UsePrivilegeSeparation no/g" /etc/ssh/sshd_config && \
    sed -i "s/UsePAM.*/UsePAM no/g" /etc/ssh/sshd_config

ADD set_root_pw.sh /set_root_pw.sh
ADD run.sh /run.sh
RUN chmod +x /*.sh
RUN useradd vislt
RUN echo "vislt:vislt" | chpasswd 


ENV AUTHORIZED_KEYS **None**

EXPOSE 22
EXPOSE 21000
EXPOSE 22000
EXPOSE 80

COPY bonnie++-1.97.tgz /
COPY iozone3_405.tar /
COPY l_lpk_p_11.1.2.005.tgz /
COPY stream.c /
RUN ls -all ;tar xzf l_lpk_p_11.1.2.005.tgz ;  tar xf iozone3_405.tar ; tar xfz bonnie++-1.97.tgz ; 
RUN cd iozone3_405/src/current/ ; make linux-AMD64 ; cd /bonnie++-1.97.1 ; ./configure ; make ; cd / ; gcc -O2 -DSTREAM_ARRAY_SIZE=30000000 -fopenmp stream.c -o stream-bin

CMD ["/run.sh"]
