#!/bin/bash

function setup1 (){
clear
echo -e "\033[01;37m ------------------------------------------------------------------"
echo -e "\033[01;37m|                  \033[01;36m     SSH Packet Setup 3.0\033[01;37m                       |"
echo -e "\033[01;37m ------------------------------------------------------------------"
echo ""
echo -e "\033[01;37m Este script irá:"
echo -e "\033[01;36m ● Configurar o OpenSSH para rodar nas portas: 22 e 443."
echo -e "\033[01;36m ● Instalar e configurar o Proxy Squid nas portas: 80, 3128 e 8080."
echo -e "\033[01;36m ● Instalar um conjunto de scripts (SSH Manager)."
echo ""
echo -ne "\033[01;37m Aperte a tecla ENTER para prosseguir..."; read ENTER
echo ""
echo -e "\033[01;37m TERMOS DE USO (!):"
echo ""
echo -e "\033[01;37m Você concorda que:"
echo -e "\033[01;36m ● O utilizador deste conjunto de scripts é o único responsável por"
echo -e "\033[01;36m executar as funções do mesmo."
echo ""
echo -ne "\033[01;37m Aperte a tecla ENTER para prosseguir..."; read ENTER
echo ""
echo -e "\033[01;37m Você não pode:"
echo -e "\033[01;36m ● Editar ou modificar o conjunto de scripts para fins lucrativos."
echo -e "\033[01;36m ● Vender ou alugar o conjunto de scripts."
echo ""
echo -ne "\033[01;37m Aperte a tecla ENTER para prosseguir..."; read ENTER
echo ""
echo -e "\033[01;37m Você pode:"
echo -e "\033[01;36m ● Editar ou modificar o conjunto de scripts ao seu gosto e prazer,"
echo -e "\033[01;36m mas nunca vender ou alugar o mesmo! Tenha bom senso de sempre deixa"
echo -e "\033[01;36m r o nome do criador como referência."
echo ""
echo -ne "\033[01;37m Aperte a tecla ENTER para prosseguir..."; read ENTER
echo ""
echo -e "\033[01;37m Você concorda que o desenvolvedor não se responsabilizará pelos:"
echo -e "\033[01;36m ● Problemas causados por conflitos entre este conjunto de scripts e"
echo -e "\033[01;36m de outros desenvolvedores."
echo -e "\033[01;36m ● Problemas causados por edições ou modificações do código deste co"
echo -e "\033[01;36m njunto de scripts."
echo -e "\033[01;36m ● Problemas causados por modificações no sistema do servidor."
echo -e "\033[01;36m ● Problemas que possam ocorrer ao usar este conjunto de scripts em"
echo -e "\033[01;36m sistemas que não estão na lista de sistemas testados."
echo ""
echo -ne "\033[01;37mAperte a tecla ENTER para prosseguir..."; read ENTER
}

function setup2 (){
clear
echo -e "\033[01;37m ------------------------------------------------------------------"
echo -e "\033[01;37m|                  \033[01;36m     SSH Packet Setup 3.0\033[01;37m                       |"
echo -e "\033[01;37m ------------------------------------------------------------------"
echo ""
echo -e "\033[01;36m Você já possui o SSH Packet instalado em seu servidor!"
echo ""
echo -e "\033[01;36m O banco de dados (/home/DATABASE) do SSH Packet foi localizado,"
echo -e "\033[01;36m deseja mantê-lo ou restaurá-lo durante a instalação?"
echo ""
echo -e "\033[01;36m  [\033[01;37m1\033[01;36m]\033[01;36m Criar um novo banco de dados."
echo -e "\033[01;36m  [\033[01;37m2\033[01;36m]\033[01;36m Mantê o banco de dados atual."
echo ""
echo -ne "\033[01;36m  [\033[01;37m1-2\033[01;36m]:\033[01;37m "; read NUMBERS
case $NUMBERS in
  1)  rm -rf /home/DATABASE
       mkdir /home/DATABASE
       mkdir /home/DATABASE/Backups
       touch /home/DATABASE/bannerssh.txt
       touch /home/DATABASE/messages.txt
       touch /home/DATABASE/users.db
       awk -F : '$3 >= 500 { print $1 " 1" }' /etc/passwd | grep -v "nobody" | sort > /home/DATABASE/users.db;;
  2) echo "";;
  *) setup2;;
esac
}

function setup3 (){
IPVPS=$(wget -qO- ipv4.icanhazip.com)
clear
echo -e "\033[01;37m ------------------------------------------------------------------"
echo -e "\033[01;37m|                  \033[01;36m     SSH Packet Setup 3.0\033[01;37m                       |"
echo -e "\033[01;37m ------------------------------------------------------------------"
echo ""
echo -e "\033[01;36m  [\033[01;37m1\033[01;36m]\033[01;36m Debian 8."
echo -e "\033[01;36m  [\033[01;37m2\033[01;36m]\033[01;36m Ubuntu 14."
echo -e "\033[01;36m  [\033[01;37m3\033[01;36m]\033[01;36m Ubuntu 16."
echo ""
echo -ne "\033[01;36m[\033[01;37m1-3\033[01;36m]:\033[01;37m "; read NUMBERS
echo -ne "\033[01;36mPara prosseguir confirme o IP deste servidor:\033[01;37m "; read -e -i $IPVPS IP
if [ -z $NUMBERS ]; then
  setup3
  exit
fi
if echo $NUMBERS | grep -q '[^1-3]' ; then
  setup3
  exit
fi
if  [ -z $IP ]; then
  setup3
  exit
fi
if [ -d "/home/DATABASE" ]; then
  setup2
fi
if [ ! -d "/home/DATABASE" ]; then
  mkdir /home/DATABASE
  mkdir /home/DATABASE/Backups
  touch /home/DATABASE/bannerssh.txt
  touch /home/DATABASE/messages.txt
  touch /home/DATABASE/users.db
  awk -F : '$3 >= 500 { print $1 " 1" }' /etc/passwd | grep -v "nobody" | sort > /home/DATABASE/users.db
fi
if [ $NUMBERS = "3" ]; then
  clear
  echo -e "\033[01;37m ------------------------------------------------------------------"
  echo -e "\033[01;37m|                  \033[01;36m     SSH Packet Setup 3.0\033[01;37m                       |"
  echo -e "\033[01;37m ------------------------------------------------------------------"
  echo ""
  echo -e "\033[01;36m ● Atualizando repositórios..."
  apt-get update 1> /dev/null 2> /dev/null
  echo -e "\033[01;36m ● Instalando recursos..."
  apt-get install git -y 1> /dev/null 2> /dev/null
  apt-get install nano -y 1> /dev/null 2> /dev/null
  apt-get install python -y 1> /dev/null 2> /dev/null
  apt-get install squid -y 1> /dev/null 2> /dev/null
  apt-get install unzip -y 1> /dev/null 2> /dev/null
  echo -e "\033[01;36m ● Configurando..."
  touch /etc/squid/domains.txt
  
  echo "http_port 80
http_port 3128
http_port 8080

visible_hostname sshpacket

acl accept1 dstdomain -i "/etc/squid/domains.txt"

acl accept2 dstdomain -i 127.0.0.1
acl accept3 dstdomain -i localhost
acl accept4 dstdomain -i $IP

http_access allow accept1
http_access allow accept2
http_access allow accept3
http_access allow accept4
  
http_access deny all

# ATIVO" > /etc/squid/squid.conf

  cat /etc/ssh/sshd_config | grep -v "Banner /home/DATABASE/bannerssh.txt" > ssh.txt
  mv ssh.txt /etc/ssh/sshd_config 
  cat /etc/ssh/sshd_config | grep -v "PasswordAuthentication yes" > ssh.txt
  mv ssh.txt /etc/ssh/sshd_config 
  cat /etc/ssh/sshd_config | grep -v "PermitEmptyPasswords yes" > ssh.txt
  mv ssh.txt /etc/ssh/sshd_config
  cat /etc/ssh/sshd_config | grep -v "Port 22" > ssh.txt
  mv ssh.txt /etc/ssh/sshd_config
  cat /etc/ssh/sshd_config | grep -v "Port 443" > ssh.txt
  mv ssh.txt /etc/ssh/sshd_config

  echo "Banner /home/DATABASE/bannerssh.txt
PasswordAuthentication yes
PermitEmptyPasswords yes
Port 22
Port 443" >> /etc/ssh/sshd_config

  echo -e "\033[01;36m ● Baixando e instalando scripts..."; echo ""
  git clone https://github.com/AnonymousLinux/SSHPacket.git 1> /dev/null 2> /dev/null
  cd SSHPacket
  unzip SSH_Packet_3.0.zip 1> /dev/null 2> /dev/null
  cd dom*
  mv domainsmanager-add1.sh /bin/domainsmanager-add && chmod a+x /bin/domainsmanager-add
  mv domainsmanager-menu1.sh /bin/domainsmanager-menu && chmod a+x /bin/domainsmanager-menu
  mv domainsmanager-remove1.sh /bin/domainsmanager-remove && chmod a+x /bin/domainsmanager-remove
  cd /root/SSHPacket/extra
  mv badvpn-menu.sh /bin/badvpn-menu && chmod a+x /bin/badvpn-menu
  mv badvpn-setup.sh /bin/badvpn-setup && chmod a+x /bin/badvpn-setup
  mv badvpn-uninstall.sh /bin/badvpn-uninstall && chmod a+x /bin/badvpn-uninstall
  mv changehostname.sh /bin/changehostname && chmod a+x /bin/changehostname
  mv changerootpassword.sh /bin/changerootpassword && chmod a+x /bin/changerootpassword
  mv connectiontest.sh /bin/connectiontest && chmod a+x /bin/connectiontest
  mv extra-menu.sh  /bin/extra-menu && chmod a+x /bin/extra-menu
  mv speedtest.py /bin/speedtest && chmod a+x /bin/speedtest
  cd /root/SSHPacket/outros
  mv about.sh /bin/about && chmod a+x /bin/about
  mv checkdatabase.sh /bin/checkdatabase && chmod a+x /bin/checkdatabase
  mv sshpacket.sh /bin/sshpacket && chmod a+x /bin/sshpacket
  mv uninstall.sh /bin/uninstall && chmod a+x /bin/uninstall
  cd /root/SSHPacket/usu*
  mv backupsmanager-export.sh /bin/backupsmanager-export && chmod a+x /bin/backupsmanager-export
  mv backupsmanager-import.sh /bin/backupsmanager-import && chmod a+x /bin/backupsmanager-import
  mv backupsmanager-menu.sh /bin/backupsmanager-menu && chmod a+x /bin/backupsmanager-menu
  mv backupsmanager-remove.sh /bin/backupsmanager-remove && chmod a+x /bin/backupsmanager-remove
  mv bannerssh.sh /bin/bannerssh && chmod a+x /bin/bannerssh
  mv changedate.sh /bin/changedate && chmod a+x /bin/changedate
  mv changelimit.sh /bin/changelimit && chmod a+x /bin/changelimit
  mv changepassword.sh /bin/changepassword && chmod a+x /bin/changepassword
  mv createuser.sh /bin/createuser && chmod a+x /bin/createuser
  mv limiter-menu.sh /bin/limiter-menu && chmod a+x /bin/limiter-menu
  mv limiter-messages.sh /bin/limiter-messages && chmod a+x /bin/limiter-messages
  mv limiter-start.sh /bin/limiter-start && chmod a+x /bin/limiter-start
  mv monitoring.sh /bin/monitoring && chmod a+x /bin/monitoring
  mv removeexpired.sh /bin/removeexpired && chmod a+x /bin/removeexpired
  mv removeuser.sh /bin/removeuser && chmod a+x /bin/removeuser
  mv userdisconnect.sh /bin/userdisconnect && chmod a+x /bin/userdisconnect
  mv usersmanager-menu.sh /bin/usersmanager-menu && chmod a+x /bin/usersmanager-menu
  cd /root
  rm -rf SSHPacket
  
  if [ -f "/etc/init.d/squid" ]; then
    /etc/init.d/squid restart 1> /dev/null 2> /dev/null
  else
    service squid restart 1> /dev/null 2> /dev/null
  fi
  if [ -f "/etc/init.d/ssh" ]; then
    /etc/init.d/ssh restart 1> /dev/null 2> /dev/null
  else
    service ssh restart 1> /dev/null 2> /dev/null
  fi
else
  clear
  echo -e "\033[01;37m ------------------------------------------------------------------"
  echo -e "\033[01;37m|                  \033[01;36m     SSH Packet Setup 3.0\033[01;37m                       |"
  echo -e "\033[01;37m ------------------------------------------------------------------"
  echo ""
  echo -e "\033[01;36m ● Atualizando repositórios..."
  apt-get update 1> /dev/null 2> /dev/null
  echo -e "\033[01;36m ● Instalando recursos..."
  apt-get install git -y 1> /dev/null 2> /dev/null
  apt-get install nano -y 1> /dev/null 2> /dev/null
  apt-get install python -y 1> /dev/null 2> /dev/null
  apt-get install squid3 -y 1> /dev/null 2> /dev/null
  apt-get install unzip -y 1> /dev/null 2> /dev/null
  echo -e "\033[01;36m ● Configurando..."
  touch /etc/squid3/domains.txt

  echo "http_port 80
http_port 3128
http_port 8080

visible_hostname sshpacket

acl accept1 dstdomain -i "/etc/squid3/domains.txt"

acl accept2 dstdomain -i 127.0.0.1
acl accept3 dstdomain -i localhost
acl accept4 dstdomain -i $IP

http_access allow accept1
http_access allow accept2
http_access allow accept3
http_access allow accept4
  
http_access deny all

# ATIVO" > /etc/squid3/squid.conf


  cat /etc/ssh/sshd_config | grep -v "Banner /home/DATABASE/bannerssh.txt" > ssh.txt
  mv ssh.txt /etc/ssh/sshd_config 
  cat /etc/ssh/sshd_config | grep -v "PasswordAuthentication yes" > ssh.txt
  mv ssh.txt /etc/ssh/sshd_config 
  cat /etc/ssh/sshd_config | grep -v "PermitEmptyPasswords yes" > ssh.txt
  mv ssh.txt /etc/ssh/sshd_config
  cat /etc/ssh/sshd_config | grep -v "Port 22" > ssh.txt
  mv ssh.txt /etc/ssh/sshd_config
  cat /etc/ssh/sshd_config | grep -v "Port 443" > ssh.txt
  mv ssh.txt /etc/ssh/sshd_config

  echo "Banner /home/DATABASE/bannerssh.txt
PasswordAuthentication yes
PermitEmptyPasswords yes
Port 22
Port 443" >> /etc/ssh/sshd_config

  echo -e "\033[01;36m ● Baixando e instalando scripts..."; echo ""
  git clone https://github.com/AnonymousLinux/SSHPacket.git 1> /dev/null 2> /dev/null
  cd SSHPacket
  unzip SSH_Packet_3.0.zip 1> /dev/null 2> /dev/null
  cd dom*
  mv domainsmanager-add2.sh /bin/domainsmanager-add && chmod a+x /bin/domainsmanager-add
  mv domainsmanager-menu2.sh /bin/domainsmanager-menu && chmod a+x /bin/domainsmanager-menu
  mv domainsmanager-remove2.sh /bin/domainsmanager-remove && chmod a+x /bin/domainsmanager-remove
  cd /root/SSHPacket/extra
  mv badvpn-menu.sh /bin/badvpn-menu && chmod a+x /bin/badvpn-menu
  mv badvpn-setup.sh /bin/badvpn-setup && chmod a+x /bin/badvpn-setup
  mv badvpn-uninstall.sh /bin/badvpn-uninstall && chmod a+x /bin/badvpn-uninstall
  mv changehostname.sh /bin/changehostname && chmod a+x /bin/changehostname
  mv changerootpassword.sh /bin/changerootpassword && chmod a+x /bin/changerootpassword
  mv connectiontest.sh /bin/connectiontest && chmod a+x /bin/connectiontest
  mv extra-menu.sh  /bin/extra-menu && chmod a+x /bin/extra-menu
  mv speedtest.py /bin/speedtest && chmod a+x /bin/speedtest
  cd /root/SSHPacket/outros
  mv about.sh /bin/about && chmod a+x /bin/about
  mv checkdatabase.sh /bin/checkdatabase && chmod a+x /bin/checkdatabase
  mv sshpacket.sh /bin/sshpacket && chmod a+x /bin/sshpacket
  mv uninstall.sh /bin/uninstall && chmod a+x /bin/uninstall
  cd /root/SSHPacket/usu*
  mv backupsmanager-export.sh /bin/backupsmanager-export && chmod a+x /bin/backupsmanager-export
  mv backupsmanager-import.sh /bin/backupsmanager-import && chmod a+x /bin/backupsmanager-import
  mv backupsmanager-menu.sh /bin/backupsmanager-menu && chmod a+x /bin/backupsmanager-menu
  mv backupsmanager-remove.sh /bin/backupsmanager-remove && chmod a+x /bin/backupsmanager-remove
  mv bannerssh.sh /bin/bannerssh && chmod a+x /bin/bannerssh
  mv changedate.sh /bin/changedate && chmod a+x /bin/changedate
  mv changelimit.sh /bin/changelimit && chmod a+x /bin/changelimit
  mv changepassword.sh /bin/changepassword && chmod a+x /bin/changepassword
  mv createuser.sh /bin/createuser && chmod a+x /bin/createuser
  mv limiter-menu.sh /bin/limiter-menu && chmod a+x /bin/limiter-menu
  mv limiter-messages.sh /bin/limiter-messages && chmod a+x /bin/limiter-messages
  mv limiter-start.sh /bin/limiter-start && chmod a+x /bin/limiter-start
  mv monitoring.sh /bin/monitoring && chmod a+x /bin/monitoring
  mv removeexpired.sh /bin/removeexpired && chmod a+x /bin/removeexpired
  mv removeuser.sh /bin/removeuser && chmod a+x /bin/removeuser
  mv userdisconnect.sh /bin/userdisconnect && chmod a+x /bin/userdisconnect
  mv usersmanager-menu.sh /bin/usersmanager-menu && chmod a+x /bin/usersmanager-menu
  cd /root
  rm -rf SSHPacket
 
  if [ -f "/etc/init.d/squid3" ]; then
    /etc/init.d/squid3 restart 1> /dev/null 2> /dev/null
  else
    service squid3 restart 1> /dev/null 2> /dev/null
  fi
  if [ -f "/etc/init.d/ssh" ]; then
    /etc/init.d/ssh restart 1> /dev/null 2> /dev/null
  else
    service ssh restart 1> /dev/null 2> /dev/null
  fi
fi
clear
echo -e "\033[01;37m ------------------------------------------------------------------"
echo -e "\033[01;37m|                  \033[01;36m     SSH Packet Setup 3.0\033[01;37m                       |"
echo -e "\033[01;37m ------------------------------------------------------------------"
echo ""
echo -e "\033[01;36m SSH Packet instalado com sucesso!"
echo ""
echo -e "\033[01;36m Abra o painel digitando:\033[01;37m sshpacket"
echo ""
exit
}

setup1
setup3
