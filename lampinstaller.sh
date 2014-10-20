#!/bin/bash


# THIS SCRIPT IS WRITTEN BY fuji clado
# Email  : fujiclado@gmail.com
# Github : https://github.com/FujiClado


package_list="httpd mysql-server php php-mysql " 
service_list="httpd mysqld"
mysqlroot_pass="mysql123"


#COLOR CODE TO USE WITH THE ECHO 
RESET="\e[0m"
RED="\e[31m"
GREEN="\e[32m"
CYAN="\e[36m"

#CLEAR THE WHOLE SCREEN
clear


echo -e "${GREEN}"
echo "##################################################"
echo "##             AUTO LAMP INSTALLER              ##"
echo "##################################################"
echo -e "${RESET}"


# READING THE PASSWORD
echo -ne "Please type your Mysql password: "
read -s NEWPASSWD
echo ""
echo -ne "Please Re-type your new password: "
read  -s CONFIRMPASSWD

# CHECKING FOR NULL PASSWORD
if [ -z ${NEWPASSWD} ] && [  -z ${CONFIRMPASSWD} ];then
echo ""
echo -e "${RED}Sorry, null passwords.${RESET}"
exit 1

else

# CHECKING THE PASSWORD ARE EQUEL 
if [[ ${NEWPASSWD} == ${CONFIRMPASSWD} ]];then

		# IF EVRYTHING WORK mysqlroot_pass VARIABLE CONTAIN THE PASSWORD FOR MySQL

		mysqlroot_pass=${CONFIRMPASSWD}

		echo ""
		# INSTALLING ALL THE LAMP PACKAGE 
		echo ""
		echo -e "${RED}INSTALLING LAMP PACKAGE${RESET}"
		echo -e '```````````````````````'
		for package in ${package_list}
		do 

			printf '=> \e[36m%-023s\e[0m\e[30m%-015s\e[0m' "Installing The Package" "${package}"
			if yum install -y ${package} &> /dev/null;then
			echo -e	"${GREEN} [  DONE  ]${RESET}"
			else
			echo -e "${RED} [ FAILED ]${RESET}"
			fi

		done

		# ADDING SERVECES INTO CHECKCONFIG 
		echo ""
		echo -e "${RED}ADDING SERVICES INTO CHECKCONFIG${RESET}"
		echo        '````````````````````````````````'

		for service in ${service_list}
		do 

			printf '=> \e[36m%-019s\e[0m\e[30m%-019s\e[0m' "Adding The Service" "${service}"
			if chkconfig ${service} on &> /dev/null;then
			echo -e	"${GREEN} [  DONE  ]${RESET}"
			else
			echo -e "${RED} [ FAILED ]${RESET}"
			fi

		done

		#ADDING SERVECES INTO CHECKCONFIG 
		echo ""
		echo -e "${RED}RESTARTING SERVICES INTO CHECKCONFIG${RESET}"
		echo          '````````````````````````````````````'

		for service in ${service_list}
		do 

			printf '=> \e[36m%-023s\e[0m\e[30m%-015s\e[0m' "Restarting The Service" "${service}"
			if service  ${service} restart  &> /dev/null;then
			echo -e	"${GREEN} [  DONE  ]${RESET}"
			else
			echo -e "${RED} [ FAILED ]${RESET}"
			fi

		done

		# INITIAL MYSQL SETUP
		echo ""
		echo -e "${RED}INITIAL MYSQL-SERVER SETUP${RESET}"
		echo           '``````````````````````````'

		#RESTING ROOT PASSWORD
		printf '=> \e[36m%-038s\e[0m' "Resetting Root Password" 

			if mysql -u root -e "update mysql.user set Password=PASSWORD('${mysqlroot_pass}') WHERE User='root';" &> /dev/null;then
			echo -e	"${GREEN} [  DONE  ]${RESET}"
			else
			echo -e "${RED} [ FAILED ]${RESET}"
			fi

		#RESTARTING THE MYSQL TO AVOID ANY AYN ISSUE
		service mysqld restart &> /dev/null

		#DELETING ANONYMOUS USERS
		printf '=> \e[36m%-038s\e[0m' "Deleting Anonymous Users" 

			if mysql -u root -p${mysqlroot_pass} -e "DELETE FROM mysql.user WHERE User=''" &> /dev/null;then
			echo -e	"${GREEN} [  DONE  ]${RESET}"
			else
			echo -e "${RED} [ FAILED ]${RESET}"
			fi


		#DELETING TEST DATABASE
		printf '=> \e[36m%-038s\e[0m' "Deleting test DataBase" 

			if mysql -u root -p${mysqlroot_pass} -e "DROP DATABASE test" &> /dev/null;then
			echo -e	"${GREEN} [  DONE  ]${RESET}"
			else
			echo -e "${RED} [ FAILED ]${RESET}"
			fi


		#RELOADING DATABSE
		printf '=> \e[36m%-038s\e[0m' "Reloading Privileges" 

			if mysql -u root -p${mysqlroot_pass} -e "FLUSH PRIVILEGES" &> /dev/null;then
			echo -e	"${GREEN} [  DONE  ]${RESET}"
			else
			echo -e "${RED} [ FAILED ]${RESET}"
			fi

		#FINAL RESTARTING OF THE SERICE
		service mysqld restart &> /dev/null
		
else
echo ""
echo -e "${RED}Sorry, passwords do not match.${RESET}"
fi
fi

