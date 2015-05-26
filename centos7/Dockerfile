FROM centos:centos7
MAINTAINER Ruslan Pacevic <rpacevic@gmail.com>

RUN yum -y install openssh-server epel-release && \
    yum -y install pwgen && \    
    rm -f /etc/ssh/ssh_host_dsa_key /etc/ssh/ssh_host_rsa_key && \
    ssh-keygen -q -N "" -t dsa -f /etc/ssh/ssh_host_dsa_key && \
    ssh-keygen -q -N "" -t rsa -f /etc/ssh/ssh_host_rsa_key && \
    sed -i "s/#UsePrivilegeSeparation.*/UsePrivilegeSeparation no/g" /etc/ssh/sshd_config && \
    sed -i "s/UsePAM.*/UsePAM no/g" /etc/ssh/sshd_config

COPY set_root_pw.sh /set_root_pw.sh
COPY run.sh /

EXPOSE 22
EXPOSE 21000
EXPOSE 22000
EXPOSE 80
EXPOSE 8080
EXPOSE 8282
EXPOSE 8484

RUN chmod +x /*.sh && useradd vislt && echo "vislt:vislt" | chpasswd 
ENV AUTHORIZED_KEYS **None**

RUN yum -y install rpm-build yum-utils tar wget nano mc htop which git gcc-c++ make cmake openmpi-devel
ENV PATH=/usr/lib64/openmpi/bin:$PATH
ENV LD_LIBRARY_PATH=/usr/local/lib:/usr/lib64/openmpi/lib:$LD_LIBRARY_PATH


CMD ["/run.sh"]
