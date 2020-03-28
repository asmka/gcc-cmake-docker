FROM centos:7

USER root

# gcc 9.3.0
WORKDIR /root/tmp
RUN yum install -y gcc gcc-c++ make wget bzip2
RUN curl -LO http://ftp.tsukuba.wide.ad.jp/software/gcc/releases/gcc-9.3.0/gcc-9.3.0.tar.gz
RUN tar zxf gcc-9.3.0.tar.gz 
WORKDIR gcc-9.3.0
RUN ./contrib/download_prerequisites
WORKDIR build
RUN ../configure --enable-languages=c,c++ --prefix=/usr/local --disable-bootstrap --disable-multilib 
RUN make > /dev/null
RUN make install > /dev/null
RUN echo '/usr/local/lib64' > /etc/ld.so.conf.d/local_lib64.conf
RUN ldconfig
WORKDIR /root/tmp
RUN rm -rf ./*

# cmake 3.17.0
WORKDIR /root/tmp
RUN yum -y install openssl-devel
RUN curl -LO https://github.com/Kitware/CMake/releases/download/v3.17.0/cmake-3.17.0.tar.gz
RUN tar zxf cmake-3.17.0.tar.gz
WORKDIR cmake-3.17.0
RUN ./bootstrap && make && make install
WORKDIR /root/tmp
RUN rm -rf ./*

WORKDIR /root
CMD ["/bin/bash", "-l"]
