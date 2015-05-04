# A basic apache server. To use either add or bind mount content under /var/www
FROM centos:6

MAINTAINER Ruslan Pacevic version 0.1

RUN yum -y install rpm-build yum-utils tar wget nano mc htop SDL-devel python-pip htop

EXPOSE 21000
EXPOSE 80
EXPOSE 8080
EXPOSE 22
VOLUME /export

ADD vtk-parallel-osmesa-5.10.1-7.4.src.rpm vtk-parallel-osmesa-5.10.1-7.4.src.rpm
ADD VisLT-osmesa-0.1-2.1.src.rpm VisLT-osmesa-0.1-2.1.src.rpm
ADD xvidcore-1.3.2-5.1.src.rpm xvidcore-1.3.2-5.1.src.rpm


RUN yum-builddep -y --nogpgcheck /vtk-parallel-osmesa-5.10.1-7.4.src.rpm
RUN yum-builddep -y --nogpgcheck /VisLT-osmesa-0.1-2.1.src.rpm
RUN yum-builddep -y --nogpgcheck /xvidcore-1.3.2-5.1.src.rpm

RUN rpmbuild --rebuild /xvidcore-1.3.2-5.1.src.rpm
RUN rpmbuild --rebuild /vtk-parallel-osmesa-5.10.1-7.4.src.rpm
RUN yum -y install  /root/rpmbuild/RPMS/x86_64/*
RUN rpmbuild --rebuild /VisLT-osmesa-0.1-2.1.src.rpm
RUN yum -y install  /root/rpmbuild/RPMS/x86_64/*


RUN /bin/sh run.sh


