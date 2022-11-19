FROM ubuntu:22.04

RUN apt-get update 

RUN apt update && apt-get install -y git python3-virtualenv libssl-dev libffi-dev build-essential libpython3-dev python3-minimal authbind virtualenv

RUN apt-get install -y openssh-server net-tools iputils-ping traceroute vim nano iproute2 iptables pkg-config tcpdump nmap apache2 

RUN apt-get install openssl


RUN useradd -m -d /home/cowrie -s /bin/bash cowrie

RUN su cowrie; cd home/cowrie; git clone http://github.com/cowrie/cowrie

COPY ./cowrie.cfg /home/cowrie/cowrie/etc/
COPY ./userdb.txt /home/cowrie/cowrie/etc/

RUN cd /home/cowrie/cowrie; virtualenv --python=python3 cowrie-env; . cowrie-env/bin/activate; pip install --upgrade pip; pip install --upgrade -r requirements.txt

RUN chown -R cowrie:cowrie /home/cowrie
    
RUN mkdir /var/run/sshd



RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 22

COPY ./start.sh .




RUN chmod +x start.sh

CMD ["./start.sh"]