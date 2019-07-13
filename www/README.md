Instalação Inicial para Web Application Stack:
$ sudo apt-get install build-essential
$ sudo apt-get install libncurses5-dev libncursesw5-dev libreadline6-dev
$ sudo apt-get install libbz2-dev libexpat1-dev liblzma-dev zlib1g-dev libsqlite3-dev libgdbm-dev tk8.5-dev
$ sudo apt-get install python-dev
$ sudo apt-get install libssl-dev openssl

Criar pasta para seguir com a instalação:
$ mkdir python-source
3.6.4
Download python from python.org:

$ wget https://www.python.org/ftp/python/3.6.4/Python-3.6.4.tgz (It works!)

Verifique a versão do Python3:
$ python3 --version

Descompactar arquivo para fazer update do python3:
$ tar zxvf Python-3.6.4.tgz

Entrar na pasta:
$ cd Python-3.6.4 

Instalar em um local predefinido:
$ ./configure --prefix=/usr/local/opt/python-3.6.4

Compilar com make script:
$ make

Next and last thing to do is install your new Python version cause we want to update the system version of Python:
$ sudo make install

$ /usr/local/opt/python-3.6.4/bin/python3.6 --version

Using Python virtual environment for our application:
Log as a root user:
$ sudo su

root$ cd /var
cd = change directory

root@pi:var$ mkdir www
root@pi:var$ cd www
root@pi:var/www$ mkdir lab_app
root@pi:var/www$ cd lab_app
root@pi:var/www/lab_app$ /usr/local/opt/python-3.6.4/bin/python3.6 -m venv .

Obs.: “.”  =  /var/www/lab_app, “.” significa present location 

Verificar o caminho da versão do python:
root@pi:var/www/lab_app$ ls -al bin

Ativar versão correta do python para esse projeto usando venv:
root@pi:var/www/lab_app$ . bin/activate
(lab_app) root@pi:var/www/lab_app$

Verfique a versão do Python novamente:
(lab_app) root@pi:var/www/lab_app$ python --version

Para sair do ambiente virtual, basta dar um: $ deactivate


Instalando NGINX:
(lab_app) root@pi:var/www/lab_app$ apt-get install nginx

Any issue? Run: apt-get update

SETUP FLASK:

(lab_app) root@pi:var/www/lab_app$ pip install flask

Hello World:
(lab_app) root@pi:var/www/lab_app$ vim hello.py

salvar e sair: esc -> :wq!

(lab_app) root@pi:var/www/lab_app$ python hello.py

from flask import Flask
app = Flask(__name__)
@app.route("/")

def hello():
    return "Hello World!"

@app.route("/example")
def example_route():
    return "This is as example route"

###if __name__ == "__main__":
###    app.run(host='0.0.0.0', port=8080)

$ flask run --host=0.0.0.0 --port=8080


Instalando UWSGI server:
(lab_app) root@pi:var/www/lab_app$ pip install uwsgi

Verificar:
(lab_app) root@pi:var/www/lab_app$ ls -al bin/

Configurar Nginx: 
(lab_app) root@pi:var/www/lab_app$ cat /etc/nginx/sites-enabled/default

(lab_app) root@pi:var/www/lab_app$ rm /etc/nginx/sites-enabled/default

Criar novo arquivo de configuração para Nginx:
(lab_app) root@pi:var/www/lab_app$ vim lab_app_nginx.conf

Criar Link Simbólico no lugar de copiar arquivos:
(lab_app) root@pi:var/www/lab_app$ ln -s /var/www/lab_app/lab_app_nginx.conf /etc/nginx/conf.d

Verificar:
(lab_app) root@pi:var/www/lab_app$ ls -al /etc/nginx/conf.d/

Restart Nginx para fazer efeito:
(lab_app) root@pi:var/www/lab_app$ /etc/init.d/nginx restart


uWSGI installation:
(lab_app) root@pi:var/www/lab_app$ vim lab_app_uwsgi.ini


Mais informações:
https://uwsgi-docs.readthedocs.io/en/latest/Configuration.html

(lab_app) root@pi:var/www/lab_app$ cat lab_app_uwsgi.ini

(lab_app) root@pi:var/www/lab_app$ mkdir /var/log/uwsgi

USWGI and Nginx configuration testing

(lab_app) root@pi:var/www/lab_app$ bin/uwsgi --ini /var/www/lab_app/lab_app_uwsgi.ini


SystemD: is a system that is very popular in the Linux world for managing system processes after booting.
So you can create a little script or a program and then configure it so that system will automatically start when your raspberry pi or your computer begins.

(lab_app) root@pi:var/www/lab_app$ vim /etc/systemd/system/emperor.uwsgi.service



[Unit]
Description=uWSGI Emperor
After=syslog.target

[Service]
ExecStart=/var/www/lab_app/bin/uwsgi --ini /var/www/lab_app/lab_app_uwsgi.ini
# Requires systemd version 211 or newer
RuntimeDirectory=uwsgi
Restart=always
KillSignal=SIGQUIT
Type=notify
StandardError=syslog
NotifyAccess=all

[Install]
WantedBy=multi-user.target


Running:
(lab_app) root@pi:var/www/lab_app$ systemctl start emperor.uwsgi.service

Verificar:
(lab_app) root@pi:var/www/lab_app$ systemctl status emperor.uwsgi.service

Enable and made an Simbolic Link:
(lab_app) root@pi:var/www/lab_app$ systemctl enable emperor.uwsgi.service


Install SQLite 3:

(lab_app) root@pi:var/www/lab_app$ apt-get install sqlite3

(lab_app) root@pi:var/www/lab_app$ mkdir static
(lab_app) root@pi:var/www/lab_app$ cd mkdir 
(lab_app) root@pi:var/www/lab_app/static$ mkdir css
(lab_app) root@pi:var/www/lab_app/static$ mkdir images


(lab_app) root@pi:var/www/lab_app/static$ vim a_static_file.html


<html>
<head>
<title>Static page</title>
</head>
<body>
<h1>This is an example of a static page</h1>
<p>Neat, isn’t it?</p>
</body>
</html>

http://192.168.0.11/static/a_static_file.html


Download 
getskeleton.com


Criar Pasta de Templates:

(lab_app) root@pi:var/www/lab_app$ mkdir templates