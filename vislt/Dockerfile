FROM wincrash/centos7
MAINTAINER Ruslan Pacevic <rpacevic@gmail.com>

COPY home_rpacevic.repo /etc/yum.repos.d/
RUN yum -y install VisLT-osmesa

CMD ["/run.sh"]
