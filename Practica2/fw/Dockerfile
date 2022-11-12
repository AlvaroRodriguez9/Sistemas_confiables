FROM ubuntu:22.04

RUN apt-get update 


COPY ./parasnort.sh .
RUN chmod +x parasnort.sh

RUN ./parasnort.sh

RUN apt-get install -y openssh-server net-tools iputils-ping traceroute vim nano iproute2 iptables pkg-config tcpdump nmap





#Comandos para Snort
RUN apt install -y build-essential libpcap-dev libpcre3-dev libnet1-dev zlib1g-dev luajit hwloc libdnet-dev libdumbnet-dev bison flex liblzma-dev openssl libssl-dev pkg-config libhwloc-dev cmake cpputest libsqlite3-dev uuid-dev libcmocka-dev libnetfilter-queue-dev libmnl-dev autotools-dev libluajit-5.1-dev libunwind-dev git

RUN mkdir snort-source-files
RUN cd snort-source-files; git clone https://github.com/snort3/libdaq.git; cd libdaq; ./bootstrap; ./configure; make; make install; cd ../; wget https://github.com/gperftools/gperftools/releases/download/gperftools-2.10/gperftools-2.10.tar.gz; tar xzf gperftools-2.10.tar.gz; cd gperftools-2.10/; ./configure; make; make install; cd ../; git clone https://github.com/snort3/snort3.git; cd snort3/; ./configure_cmake.sh --prefix=/usr/local --enable-tcmalloc; cd build; make; make install; ldconfig; ln -s /usr/local/bin/snort /usr/sbin/snort 




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


