# %%
import paramiko
import zipfile

with paramiko.SSHClient() as ssh:
    ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
    ssh.connect('130.61.238.15', username='sofascore_academy', password='H69qByfVGwkLgezF')
    with ssh.open_sftp() as sftp:
        remote_directory = '/home/sofascore_academy/l2_dataset/march'
        local_directory = '/Users/lucij/Desktop/monthly_data'
        
        files = sftp.listdir(remote_directory)
        
        for file in files:
            remote_file_path = f"{remote_directory}/{file}"
            local_file_path = f"{local_directory}/{file}"
            sftp.get(remote_file_path, local_file_path)

            with zipfile.ZipFile(local_file_path, 'r') as individual_zip:
                individual_zip.extractall('/Users/lucij/Desktop/raw_data')




