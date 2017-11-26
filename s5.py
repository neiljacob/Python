## Read from a file and display

## os.system for executing unix commands

import os

f = open('/home/fugeniz/nano.sh','r+w')
p=f.read()
print(p)
f.write('#Hello testing')
f.close()
print('\n')
os.system('cat /etc/os-release')
