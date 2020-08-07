FROM iamkyun/osbase:v2

MAINTAINER agapple (jianghang115@gmail.com)

# install canal
COPY image/ /tmp/docker/
COPY canal.deployer-*.tar.gz /home/admin/

RUN ls /bin/sh
RUN echo 123
RUN  cp -R /tmp/docker/alidata /alidata
RUN  chmod +x /alidata/bin/* 
RUN  mkdir -p /home/admin 
RUN  cp -R /tmp/docker/app.sh /home/admin/  
RUN  cp -R /tmp/docker/admin/* /home/admin/  
RUN  /bin/cp -f alidata/bin/lark-wait /usr/bin/lark-wait 

RUN  mkdir -p /home/admin/canal-server 
RUN  tar -xzvf /home/admin/canal.deployer-*.tar.gz -C /home/admin/canal-server 
RUN  /bin/rm -f /home/admin/canal.deployer-*.tar.gz 

RUN  tar zxvf /tmp/node_exporter.tar.gz -C /home/admin 
RUN  ln -s /home/admin/node_exporter-0.18.1.linux-arm64 /home/admin/node_exporter 

RUN  mkdir -p home/admin/canal-server/logs  
RUN  chmod +x /home/admin/*.sh  
RUN  chmod +x /home/admin/bin/*.sh  
RUN  chown admin: -R /home/admin 
RUN  yum clean all 
RUN true

# 11110 admin , 11111 canal , 11112 metrics, 9100 exporter
EXPOSE 11110 11111 11112 9100

WORKDIR /home/admin

ENTRYPOINT [ "/alidata/bin/main.sh" ]
CMD [ "/home/admin/app.sh" ]