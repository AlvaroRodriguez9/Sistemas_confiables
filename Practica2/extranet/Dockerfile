# Archivo Dockerfile. Estos comandos se ejecutan al hacer docker-compose up
# Autor: Álvaro Rodríguez Carpintero
FROM ubuntu:22.04

ENV TZ=Europe/Madrid
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update 

COPY ./paraHping.sh .
RUN chmod +x paraHping.sh

RUN ./paraHping.sh

RUN apt-get install -y openssh-server net-tools iputils-ping traceroute vim nano iproute2 iptables pkg-config tcpdump nmap 
RUN apt-get install -y hping3


    
RUN mkdir /var/run/sshd
RUN echo 'root:root' |chpasswd
RUN sed -ri 's/^#?PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config
RUN mkdir /root/.ssh

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 22

COPY ./start.sh .

RUN chmod +x start.sh

CMD ["./start.sh"]