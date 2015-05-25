FROM centos:centos7
MAINTAINER Ruslan Pacevic <rpacevic@gmail.com>

ONBUILD RUN yum -y install openssh-server epel-release && \
    yum -y install pwgen && \
    yum -y install rpm-build yum-utils tar wget nano mc htop which gcc-c++ make cmake freeglut-devel python-devel libXt-devel openmpi-devel mesa-libOSMesa-devel && \
    rm -f /etc/ssh/ssh_host_dsa_key /etc/ssh/ssh_host_rsa_key && \
    ssh-keygen -q -N "" -t dsa -f /etc/ssh/ssh_host_dsa_key && \
    ssh-keygen -q -N "" -t rsa -f /etc/ssh/ssh_host_rsa_key && \
    sed -i "s/#UsePrivilegeSeparation.*/UsePrivilegeSeparation no/g" /etc/ssh/sshd_config && \
    sed -i "s/UsePAM.*/UsePAM no/g" /etc/ssh/sshd_config

ONBUILD ADD set_root_pw.sh /set_root_pw.sh
ONBUILD ADD run.sh /run.sh
ONBUILD RUN chmod +x /*.sh
ONBUILD RUN useradd vislt
ONBUILD RUN echo "vislt:vislt" | chpasswd 


ENV AUTHORIZED_KEYS **None**

EXPOSE 22
EXPOSE 21000
EXPOSE 22000
EXPOSE 80

ENV PATH=/usr/lib64/openmpi/bin:$PATH
ONBUILD ADD home_rpacevic.repo /etc/yum.repos.d/home_rpacevic.repo
ONBUILD ADD VTK-6.2.0.tar.gz VTK-6.2.0.tar.gz
ONBUILD RUN tar xfz VTK-6.2.0.tar.gz
ONBUILD RUN mkdir /VTK-6.2.0/build

ONBUILD WORKDIR /VTK-6.2.0/build
ONBUILD RUN cmake -DVTK_Group_Web:BOOL=ON -DVTK_WRAP_PYTHON:BOOL=ON -DVTK_Group_Imaging:BOOL=ON -DVTK_Group_MPI:BOOL=ON -DVTK_Group_Views:BOOL=ON -DVTK_OPENGL_HAS_OSMESA:BOOL=ON -DVTK_USE_X:BOOL=OFF ..
ONBUILD run make install


CMD ["/run.sh"]
