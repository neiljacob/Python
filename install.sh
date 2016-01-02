#!/bin/bash


# THIS SCRIPT IS WRITTEN BY fuji clado
# Email  : fujiclado@gmail.com
# Github : https://github.com/FujiClado



#COLOR CODE TO USE WITH THE ECHO 
RESET="\e[0m"
RED="\e[31m"
GREEN="\e[32m"
CYAN="\e[36m"
REDBLACK='\e[1;41m'
GREENBLACK='\e[1;42m' 



package_list="httpd  mysql-server  php-* " 
service_list="httpd mysqld"


# PCKAGE INSTALLATION - START
clear
for package in ${package_list}
do 

  echo -e "${GREEN}"
  echo "########################################################################"
  echo "##                       AUTO LAMP INSTALLER                           ##"
  echo "##                              BY                                     ##"
  echo "##                         >>TEAM CLADO<<                              ##"
  echo "########################################################################"
  echo -e "${RESET}"
	echo ""
	echo ""
	echo -e ${REDBLACK}"INSTALLING THE PACKAGE"${RESET}
	echo ""
	echo ""
        echo -e ${GREENBLACK}"INSTALLING THE PACKAGE ${package} "${RESET}
        sleep 4
        echo ""
        echo ""


	yum install -y ${package} 

	echo ""
	echo ""
	sleep 2
	clear

done
# PACKAGE INSTALLATION - END



# SERVICE MANAGEMENT - START
clear

for service in ${service_list}
do
        echo -e "${GREEN}"
        echo "########################################################################"
        echo "##                       AUTO LAMP INSTALLER                           ##"
        echo "##                              BY                                     ##"
        echo "##                         >>TEAM CLADO<<                              ##"
        echo "########################################################################"
        echo -e "${RESET}"
        echo ""
        echo ""
        echo -e ${REDBLACK}"ENABLING THE SERVICE PERMANENTLY "${RESET}
        echo ""
        echo ""
        echo -e ${GREENBLACK}"ENABLING THE ${service} "${RESET}
        sleep 4
        echo ""
        echo ""


        chkconfig  ${service} on 
	service ${service} restart 

        echo ""
        echo ""
        sleep 2
        clear

done
# SERVICE MANAGEMENT  - END








# MYSQL-SERVER SETUP - START

echo -e "${GREEN}"
echo "########################################################################"
echo "##                       AUTO LAMP INSTALLER                           ##"
echo "##                              BY                                     ##"
echo "##                         >>TEAM CLADO<<                              ##"
echo "########################################################################"
echo -e "${RESET}"
echo ""
echo ""
echo -e ${REDBLACK}"--MYSQL-SERVER INITIAL SETUP  "${RESET}
echo ""
echo ""
sleep 4

echo -e ${GREEN}" - UPDATETING MYSQL-SERVER ROOT PASSWORD"${RESET}
echo ""





echo -ne "Please type your Mysql password: "
read -s NEWPASSWORD
echo ""
echo -ne "Please Re-type your new password: "
read  -s CONFIRMPASSWORD

echo ""



# CHECKING FOR NULL PASSWORD
if [ -z ${NEWPASSWORD} ] && [  -z ${CONFIRMPASSWORD} ];then
	echo ""
	echo -e "${RED}Null Password.. Scripting Exiting..!${RESET}"
	exit 1
else

	# CHECKING THE PASSWORD ARE EQUEL 
	if [[ ${NEWPASSWORD} == ${CONFIRMPASSWORD} ]];then

		if mysql -u root -e "update mysql.user set Password=PASSWORD('${NEWPASSWORD}') WHERE User='root';" &> /dev/null;then
			service mysqld restart &> /dev/null
		else
			echo -e ${RED}"Failed To Update Mysql-server Password"${RESET}
			echo -e ${RED}"Script Exiting....!"${RESET}
			exit;
		fi
	else
		echo -e "${RED}Password Do Not Match.. Scripting Exiting..!${RESET}"
		exit 1

	fi
fi

sleep 2





echo ""
echo -e ${GREEN}" - DELETING ANONYMOUS USERS...!"${RESET}
echo ""
mysql -u root -p${CONFIRMPASSWORD} -e "DELETE FROM mysql.user WHERE User=''" 
sleep 2

echo ""
echo -e ${GREEN}" - DELETING TEST DATABASES...!"${RESET}
echo ""
mysql -u root -p${CONFIRMPASSWORD} -e "DROP DATABASE test"
sleep 2

echo ""
echo -e ${GREEN}" - RELOADING PRIVILEGES...!"${RESET}
echo ""
mysql -u root -p${CONFIRMPASSWORD} -e "FLUSH PRIVILEGES"
sleep 2


echo ""
echo -e ${GREEN}" - RESTARTING MYSQLD...!"${RESET}
echo ""
service mysqld restart &> /dev/null
sleep 2

echo ""
echo ""
sleep 3;

# MYSQL-SERVER SETUP - END
