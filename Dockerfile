FROM docker-centos-java:1.8.0_91
MAINTAINER samuelololol <samuelololol@gmail.com>

ENV TRAC_HOME /home/trac

#RUN yum install
RUN yum -y install subversion git python-pip postgresql-server postgresql-contrib postgresql-client

RUN mkdir -p $TRAC_HOME/src
#download trac source
#WORKDIR $TRAC_HOME/src
#ENV TRAC_VER 1.0.12
#RUN wget http://download.edgewall.org/trac/Trac-$TRAC_VER.tar.gz;\
#    tar zxvf Trac-$TRAC_VER.tar.gz;\
#    rm -rf Trac-$TRAC_VER.tar.gz;\

#RUN wget https://pypi.python.org/packages/source/s/setuptools/setuptools-12.0.5.tar.gz;\
#    tar zxvf setuptools-12.0.5.tar.gz;\
#    python $TRAC_HOME/src/setuptools-12.0.5/setup.py build;\
#    python $TRAC_HOME/src/setuptools-12.0.5/setup.py install;\
#    easy_install pip;\
#    rm -rf setuptools-12.0.5.tar.gz;
RUN pip install psycopg2;

# Required packages
RUN easy_install Genshi;\
    easy_install Trac;

WORKDIR $TRAC_HOME/src
RUN cd $TRAC_HOME/src; 
COPY ./logo.png $TRAC_HOME/src/logo.png
COPY ./create_start.sh /usr/local/bin/create_start.sh
COPY ./edit_ini.py /usr/local/bin/edit_ini.py

#clean up
RUN yum clean all; rm -rf /tmp/* /var/log/wtmp /var/log/btmp; history -c
