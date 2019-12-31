FROM centos:centos7

RUN yum -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm \
	&& rm -rf /var/cache/yum/* \
	&& yum clean all

RUN yum -y install mysql pv \
	&& rm -rf /var/cache/yum/* \
	&& yum clean all
