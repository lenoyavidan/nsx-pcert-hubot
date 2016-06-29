import subprocess
import sys
import os.path

def Delete(name):
        yml_name = name + "-mini.yml"

        if not os.path.isfile(yml_name):
                raise StandardError('Error file ' + yml_name + ' doesn\'t exists')

        os.chdir(['cd', '/home/ubuntu/dbc/pcert/nsxv/scripts'])

        subprocess.call(['./TestbedServices.py', yml_name, '--delete_testbed', '--force'])

try:
        Delete(sys.argv[1])
except StandardError as e:
        print e
