FROM centos:centos7
MAINTAINER Ruslan Pacevic <rpacevic@gmail.com>

RUN yum -y install openssh-server epel-release && \
    yum -y install pwgen && \
    yum -y install rpm-build yum-utils tar wget nano mc htop which gcc-c++ make cmake freeglut-devel python-devel libXt-devel openmpi-devel mesa-libOSMesa-devel && \
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

ENV PATH=/usr/lib64/openmpi/bin:$PATH
ADD home_rpacevic.repo /etc/yum.repos.d/home_rpacevic.repo
RUN wget http://www.vtk.org/files/release/6.2/VTK-6.2.0.tar.gz
RUN ls -all /; tar xfz /VTK-6.2.0.tar.gz -C /
RUN mkdir /VTK-6.2.0/build

WORKDIR /VTK-6.2.0/build
RUN cmake -DVTK_Group_Web:BOOL=ON -DVTK_WRAP_PYTHON:BOOL=ON -DVTK_Group_Imaging:BOOL=ON -DVTK_Group_MPI:BOOL=ON -DVTK_Group_Views:BOOL=ON -DVTK_OPENGL_HAS_OSMESA:BOOL=ON -DVTK_USE_X:BOOL=OFF ..
run make install


CMD ["/run.sh"]
