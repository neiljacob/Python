##  Replace wenesday by sunday and place a comma 
##  beetween words and write o/p to a file
import os
import subprocess

x = 'wenesday neil sachin ponting'
f = open('output_s4','w+')
y = (x.split())
z = []
for i in y:
    if i.endswith('y'):
       z.append("sunday")
    else:
       z.append(i)
z.append('\n')
p = ','.join(z)
f.write(p)
f.close()
os.system('cat /root/python/output_s4')

