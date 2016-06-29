import subprocess
import sys
import os.path

def Deploy(name):
	yml_name = name + "-mini.yml"

	if os.path.isfile(yml_name):
		raise StandardError('Error file ' + yml_name + ' already exists')

	os.chdir(['cd', '/home/ubuntu/dbc/pcert/nsxv/scripts'])
	subprocess.call(['cp', 'mini.yml', yml_name])
	data = []
	with open(yml_name, 'r') as file:
		loc = 0
		for line in file:
			if 'testbed_name:' in line and '#' not in line:
				loc += len(line) - 2
				break
			loc += len(line)
		file.seek(0)
		data = list(file.read())
		data.insert(loc, name)
	file.closed

	with open(yml_name, 'wb') as file:
		file.write("".join(data))
	file.closed

	subprocess.call(['./TestbedServices.py', yml_name, '-d'])

	#p = subprocess.Popen(['./TestbedServices.py', yml_name, '-d'], stdout=subprocess.PIPE, stderr=subprocess.PIPE)
	#output, error = p.communicate()

try:
	Deploy(sys.argv[1])
except StandardError as e:
	print e
