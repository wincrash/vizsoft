FROM centos:centos6
MAINTAINER Ruslan Pacevic <rpacevic@gmail.com>

RUN yum -y install openssh-server epel-release && \
    yum -y install pwgen && \
    yum -y install rpm-build yum-utils tar wget nano mc htop which && \
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
ADD home_rpacevic.repo /etc/yum.repos.d/home_rpacevic.repo
RUN yum -y install VisLT-osmesa

CMD ["/run.sh"]
