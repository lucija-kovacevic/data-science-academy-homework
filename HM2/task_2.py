# %%
import logging

logging.basicConfig(filename='task_2.log',encoding='utf-8',level=logging.INFO, filemode = 'w+', format='%(process)d-%(levelname)s-%(message)s') 

import paramiko 


try:
    with paramiko.SSHClient() as ssh:
        ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
        ssh.connect('130.61.238.15', username='sofascore_academy', password='H69qByfVGwkLgezF')

    logging.info('Connected sucesfully')

except paramiko.AuthenticationException:
    logging.error('Authentication failed')
    password = input("Enter password: ")
    username = input("Enter username: ")
    ssh.connect('130.61.238.15', username=username, password=password)

except paramiko.SSHException as sshException:
    logging.error('Unable to establish SSH connection')

    try:
        with ssh.open_sftp() as sftp:
            sftp.get('/home/sofascore_academy/l2_dataset/february.tar.gz', '/Users/lucij/Desktop/monthly_data/downloaded_february.tar.gz')

    except FileNotFoundError:
        logging.error('File doesnt exist')


# %%
from tarfile import TarFile
file_name = '/Users/lucij/Desktop/monthly_data/downloaded_february.tar.gz'

try:
    with TarFile.open(file_name, 'r') as tar_file:
        tar_file.extractall('/Users/lucij/Desktop/raw_data',filter='data')
    logging.info('Extracted fenruary.zip')
except FileNotFoundError:
    logging.error('File doesnt exist')




