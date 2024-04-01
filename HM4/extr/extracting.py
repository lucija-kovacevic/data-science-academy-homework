# %%
import logging
import os

os.makedirs('/app/logs', exist_ok=True)
log_file_path = '/app/logs/task_1.log'
logging.basicConfig(filename=log_file_path,encoding='utf-8',level=logging.INFO, filemode = 'w+', format='%(process)d-%(levelname)s-%(message)s') 

os.makedirs('/app/monthly_data', exist_ok=True)
logging.info('Created directory for downloading files')



# %%
import paramiko 

username = os.getenv('SSH_USERNAME')
password = os.getenv('SSH_PASSWORD')

try:
    with paramiko.SSHClient() as ssh:
        ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
        ssh.connect('130.61.238.15', username=username, password=password)
        logging.info('Connected successfully')

        
        try:
            with ssh.open_sftp() as sftp:
                sftp.get('/home/sofascore_academy/l2_dataset/january-small.csv.zip', '/app/monthly_data/downloaded_january.csv.zip')
            logging.info("File transferred successfully.")
        
        except FileNotFoundError:
            logging.error("File not found on remote server.")
        
        except Exception as e:
            logging.error("An unexpected error occurred during file transfer:", e)

        try:
            with ssh.open_sftp() as sftp:
                sftp.get('/home/sofascore_academy/l2_dataset/february-small.tar.gz', '/app/monthly_data/downloaded_february.tar.gz')
            logging.info("File transferred successfully.")
        
        except FileNotFoundError:
            logging.error("File not found on remote server.")
        
        except Exception as e:
            logging.error("An unexpected error occurred during file transfer:", e)

        try:
            with ssh.open_sftp() as sftp:
                remote_directory = '/home/sofascore_academy/l2_dataset/march-small'
                local_directory = '/app/raw_data'

                files = sftp.listdir(remote_directory)

                try:
                    for file in files:
                        remote_file_path = f"{remote_directory}/{file}"
                        local_file_path = f"{local_directory}/{file}"
                        sftp.get(remote_file_path, local_file_path)

                        #try:
                         #   with zipfile.ZipFile(local_file_path, 'r') as individual_zip:
                          #      individual_zip.extractall('/Users/lucij/Desktop/raw_data')
                           #     logging.info("Extracted '%s'",file)
                        #except FileNotFoundError:
                         #   logging.error("File '%s' doesnt exist on localhost.",file)
                        #except Exception as e:
                        #    logging.error("An unexpected error occurred during file unziping:", e)

                    logging.info("Files transferred successfully.")

                except FileNotFoundError:
                    logging.error("File '%s' not found on remote server.", file)        
                except Exception as e:
                    logging.error("An unexpected error occurred during file transfer:", e)

        except FileNotFoundError:
            logging.error("File not found on remote server.")
        
        except Exception as e:
            logging.error("An unexpected error occurred during file transfer:", e)

except paramiko.AuthenticationException:
    logging.error("Authentication failed. Please check your username and password.")
    password = input("Enter password: ")
    username = input("Enter username: ")
    ssh.connect('130.61.238.15', username=username, password=password)

except paramiko.SSHException as e:
    logging.error('Unable to establish SSH connection')

except Exception as e:
    logging.error("An unexpected error occurred:", e)


from tarfile import TarFile
file_name = '/app/monthly_data/downloaded_february.tar.gz'

try:
    with TarFile.open(file_name, 'r') as tar_file:
        tar_file.extractall('/app/raw_data',filter='data')
    logging.info('Extracted february-small.tar')
except FileNotFoundError:
    logging.error('File doesnt exist')


# %%
from zipfile import ZipFile
file_name = '/app/monthly_data/downloaded_january.csv.zip'

try:
    with ZipFile(file_name, 'r') as zip_file:
        zip_file.extractall('/app/raw_data')
    logging.info('Extracted january-small.csv file')
except FileNotFoundError:
    logging.error('File doesnt exist')


print("uspjeh")
