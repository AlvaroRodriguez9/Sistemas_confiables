# Archivo Dockerfile 
# Autor: Álvaro Rodríguez Carpintero

FROM ubuntu:22.04

RUN apt-get update 

RUN apt-get install -y openssh-server net-tools iputils-ping traceroute vim nano iproute2 iptables pkg-config tcpdump nmap apache2 

RUN apt-get install openssl
    
RUN mkdir /var/run/sshd
RUN echo 'root:root' |chpasswd
RUN sed -ri 's/^#?PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config
RUN mkdir /root/.ssh

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 22

COPY ./start.sh .


# HTTPS 
COPY ./index.html /var/www/html/

RUN chmod 644 /var/www/html/index.html
RUN mkdir /etc/apache2/certificate
RUN openssl req -new -newkey rsa:4096 -x509 -sha256 -days 365 -nodes -out /etc/apache2/certificate/apache-certificate.crt -keyout /etc/apache2/certificate/apache.key -subj "/C=ES/ST=CYL/L=Leon/O=ULE/CN=10.5.1.20"
COPY ./000-default.conf /etc/apache2/sites-available/

RUN a2enmod ssl 
RUN service apache2 restart



RUN chmod +x start.sh

CMD ["./start.sh"]