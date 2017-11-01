import subprocess

def make_header(header):
	subprocess.call('clear'.split())
	print('')
	print(header.upper())
	print('-' * len(header))
	print('')
	

while True:
	make_header('menu driven python script')
	print('1.To Print Disk Usage.')
	print('2.To Print Memory Usage.')
	print('3.To Print Routing Table.')
	print('4.Exit')
	SELECTION = input('Select One Operation : ')
	if SELECTION:
		if SELECTION == '1':
			make_header('disk usage of server')
			subprocess.call('df -h'.split())
			input()

		elif SELECTION == '2':
			make_header('Memory usage information')
			subprocess.call('free -m'.split())
			input()

		elif SELECTION == '3':
			make_header('routing table information')
			subprocess.call('route'.split())
			input()

		elif SELECTION == '4':
			break
		else:
			print('Invalid Selection Number') 
	else:
		print('Invalid Selection')
