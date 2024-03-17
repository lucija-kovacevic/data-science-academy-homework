# %%
import logging
import os

logging.basicConfig(filename='task_1.log',encoding='utf-8',level=logging.INFO, filemode = 'w+', format='%(process)d-%(levelname)s-%(message)s') 

os.makedirs('/Users/lucij/Desktop/monthly_data', exist_ok=True)
logging.info('Created directory for downloading files')



# %%
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
            sftp.get('/home/sofascore_academy/l2_dataset/january.csv.zip', '/Users/lucij/Desktop/monthly_data/downloaded_january.csv.zip')

    except FileNotFoundError:
        logging.error('File doesnt exist')




# %%
from zipfile import ZipFile
file_name = '/Users/lucij/Desktop/monthly_data/downloaded_january.csv.zip'

try:
    with ZipFile(file_name, 'r') as zip_file:
        zip_file.extractall('/Users/lucij/Desktop/raw_data')
    logging.info('Extracted january.csv file')
except FileNotFoundError:
    logging.error('File doesnt exist')




