import argparse

parser = argparse.ArgumentParser()
parser.add_argument('-H',dest='host',metavar="ipaddress",required=True,help="Description about switch")
parser.add_argument('-p',dest='port',type=int,default='22',help="Description about switch")
parser.add_argument('-u',dest='user',default='root',help='Description about switch')

arguments = parser.parse_args()
print('')
print('Arguments :',arguments)
print('')

host = arguments.host
port = arguments.port
user = arguments.user

print('Host [arguments.host] :', host)
print('port [arguments.port] :', port)
print('user [arguments.user] :', user)
