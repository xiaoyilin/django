#基础镜像
FROM ubuntu:16.04
#维护者信息
MAINTAINER xiaoyilin <406735078@qq.com>
LABEL version="1.0" 
LABEL description="Django"
ENV HOSTNAME xiaoyilin
#Python版本
ENV PYTHON_VERSION 3.7.1
#PYTHON下载地址zlib1g-dev
ENV PYTHON_DOWNLOAD_URL https://www.python.org/ftp/python/3.7.1/Python-3.7.1.tgz
#指定运行容器时的用户名后续的RUN也会使用指定用户
USER root
#Update the sources list
RUN apt-get update && apt-get install -y wget && apt-get dist-upgrade -y && apt-get install -y build-essential && apt-get install -y zlib1g-dev
RUN apt-get install -y zlib
WORKDIR /opt
#下载/解压/删除Python-3.7.1.tgz
RUN  wget $PYTHON_DOWNLOAD_URL &&  tar -xvf Python-3.7.1.tgz && rm -rf Python-3.7.1.tgz
WORKDIR /opt/Python-3.7.1
#编译安装
RUN ./configure --prefix=/usr/local/python && make && make install
#删除编译前源目录/创建虚拟环境目录
RUN rm -rf /opt/Python-3.7.1 && mkdir /usr/local/virtualenv
#进入创建后虚拟环境目录
WORKDIR /usr/local/virtualenv
#创建虚拟环境
RUN /usr/local/python3/bin/ -m venv .
WORKDIR /usr/local/virtualenv/bin
#激活虚拟环境 
RUN source activate && ./pip3 install django && ./pip3 install uwsgi

CMD ["/bin/bash"]
#CMD [ "python3", "./manage.py", "runserver", "0.0.0.0:8000"]


#EXPOSE指定于外界交互的端口
#ENV设置环境变量
#RUN用于指定镜像构建时所要执行的命令
#CMD用于指定在容器启动时所要执行的命令
#VOLUME指定持久化目录
#WORKDIR工作目录，类似于cd命令
#LABEL为镜像添加元数据
#ENTRYPOINT配置容器，使其可执行化
#ADD将本地文件添加到容器中，tar类型文件会自动解压，可以访问网络资源，类似wget
#COPY功能类似ADD不会自动解压文件不能访问网络资源

