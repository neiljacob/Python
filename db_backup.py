## Take db backup where db names are kept in a file

import os
import time
import datetime

# MySQL database details to which backup to be done. Make sure below user having enough privileges to take databases backup.
# To take multiple databases backup, create any file like /backup/dbnames.txt and put databses names one on each line and assignd to DB_NAME variable.

DB_HOST = 'localhost'
DB_USER = 'root'
DB_USER_PASSWORD = '_root_user_password_'
DB_NAME = '/backup/dbnames.txt'
BACKUP_PATH = '/backup/dbbackup/'

# Getting current datetime to create seprate backup folder like "12012013-071334".
DATETIME = time.strftime('%m%d%Y-%H%M%S')

TODAYBACKUPPATH = BACKUP_PATH + DATETIME


in_file = open(DB_NAME,"r")
flength = len(in_file.readlines())
in_file.close()
p = 1
dbfile = open(DB_NAME,"r")

while p <= flength:
     db = dbfile.readline()   # reading database name from file
     db = db[:-1]         # deletes extra line
     dumpcmd = "mysqldump -u " + DB_USER + " -p" + DB_USER_PASSWORD + " " + db + " > " + TODAYBACKUPPATH + "/" + db + ".sql"
     os.system(dumpcmd)
     p = p + 1
dbfile.close()

print "Backup script completed"
print "Your backups has been created in '" + TODAYBACKUPPATH + "' directory"
