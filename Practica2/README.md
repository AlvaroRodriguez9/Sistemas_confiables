Autor: Álvaro Rodríguez Carpintero
Link al vídeo de ejecución de las pruebas:  
# Archivo de manifiesto

En este archivo se va a explicar los ficheros que conforman la entrega y
su contenido.

### Estructura de archivos

- `dmz` : Carpeta que contiene los archivos de configuración de la dmz. 
- `extranet`: Carpeta que contiene todos los archivos de configuración de el ordenador de la extranet.
- `fw`: Carpeta que contiene todos los archivos de configuración del fw.
- `int1`:  Carpeta que contiene todos los archivos de configuración del primer ordenador de la red interna.
- `int2`:  Carpeta que contiene todos los archivos de configuración del segundo ordenador de la red interna.
-  `docker-compose.yml`:  Archivo de configuración general que sirve para levantar los contendores. 
-  `README.md`:  Este archivo de manifiesto.

### DMZ

La carpeta dmz contiene:
- `000-default.conf` : Archivo de configuración para el servido apache usado para generar un servicio HTTPS.
- `Dockerfile` : Archivo Dockerfile donde se encuentran todos los comandos que se ejecutan al iniciar el contendor.
- `Index.html` : Archivo HTML usado para probar el funcionamiento del servicio HTTPS.
- `start.sh` : Script que ejecuta docker al realizar exec al contenedor.
- `cowrie.cfg` : Archivo de configuración de Cowrie.
- `userdb.txt` : Base de datos de usuarios de Cowrie.

### Extranet

La carpeta extranet contiene:
- `Dockerfile` : Archivo Dockerfile donde se encuentran todos los comandos que se ejecutan al iniciar el contendor.
- `start.sh` : Script que ejecuta docker al realizar exec al contenedor.
- `paraHping.sh` : Script que me ha permitido instalar hping3.

### fw

La carpeta fw contiene:
- `Dockerfile` : Archivo Dockerfile donde se encuentran todos los comandos que se ejecutan al iniciar el contendor.
- `start.sh` : Script que ejecuta docker al realizar exec al contenedor.
- `parasnort.sh` : Script que me ha permitido instalar snort.
- `snort.lua` : Archivo de configuración de Snort.

### int1

La carpeta int1 contiene:
- `Dockerfile` : Archivo Dockerfile donde se encuentran todos los comandos que se ejecutan al iniciar el contendor.
- `start.sh` : Script que ejecuta docker al realizar exec al contenedor.

### int2

La carpeta int2 contiene:
- `Dockerfile` : Archivo Dockerfile donde se encuentran todos los comandos que se ejecutan al iniciar el contendor.
- `start.sh` : Script que ejecuta docker al realizar exec al contenedor.


Salida de comandos  ip a 
-------------

- `int1` :  inet 10.5.2.20/24 brd 10.5.2.255 scope global eth0
- `int2` :  inet 10.5.2.21/24 brd 10.5.2.255 scope global eth0
- `fw` : inet 10.5.2.1/24 brd 10.5.2.255 scope global eth2
inet 10.5.1.1/24 brd 10.5.1.255 scope global eth0
inet 10.5.0.1/24 brd 10.5.0.255 scope global eth1
- `dmz1` : inet 10.5.1.20/24 brd 10.5.1.255 scope global eth0
- `ext1` : inet 10.5.0.20/24 brd 10.5.0.255 scope global eth0


Salida de comandos  ip route 
-------------

- `int1` :  default via 10.5.2.1 dev eth0 
10.5.2.0/24 dev eth0 proto kernel scope link src 10.5.2.20
- `int2` :  default via 10.5.2.1 dev eth0 
10.5.2.0/24 dev eth0 proto kernel scope link src 10.5.2.21
- `fw` : 10.5.0.0/24 dev eth1 proto kernel scope link src 10.5.0.1 
10.5.1.0/24 dev eth0 proto kernel scope link src 10.5.1.1 
10.5.2.0/24 dev eth2 proto kernel scope link src 10.5.2.1
- `dmz1` : default via 10.5.1.1 dev eth0 
10.5.1.0/24 dev eth0 proto kernel scope link src 10.5.1.20
- `ext1` : default via 10.5.0.1 dev eth0 
10.5.0.0/24 dev eth0 proto kernel scope link src 10.5.0.20 
