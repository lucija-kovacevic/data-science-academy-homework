# %%
def to_camel_case(s):
    parts = s.split('_')
    return parts[0] + ''.join(x.title() for x in parts[1:])

def process_data(df):
    df.drop_duplicates(inplace=True)
    df.columns = [to_camel_case(col) for col in df.columns]
    filter_date = '20230315'
    df.drop(df[df['eventDate'].astype(str) > filter_date].index, inplace=True)

# %%
import os
import pandas as pd
import logging

os.makedirs('/app/logs', exist_ok=True)
log_file_path = '/app/logs/task_4.log'
logging.basicConfig(filename=log_file_path,encoding='utf-8',level=logging.INFO, filemode = 'w+', format='%(process)d-%(levelname)s-%(message)s') 

def merge_csv_files(directory, output_file):

    file_created = False
    headers = ['event_date','event_timestamp','event_name','user_pseudo_id','geo_country','app_info_version','platform','firebase_experiments','id','item_name','previous_first_open_count','name','event_id','status']  # Replace with your actual column names
    logging.info(file_created)
    na_values = [r'\N', '','NaN'] 
    dtype_mapping = {
    'eventDate': 'str',  
    'eventName': 'str',
    'userPseudoId': 'str',
    'platform': 'str',
    'status': 'str',
    'geoCountry': 'str',
    'id': 'Int64',
    }

    for root, dirs, files in os.walk(directory):
        logging.info("root '%s'",root)
        logging.info("dir '%s'",dirs)
         

        for file in files:
            logging.info("FILE '%s'",file)

            if file.endswith('.csv'):
                file_path = os.path.join(root, file)
                df = pd.read_csv(file_path,names=headers)
                df.to_csv(file_path, index=False, mode='w')


                df = pd.read_csv(file_path, usecols=["event_date", "event_name", "user_pseudo_id","platform", "status", "geo_country", "id"],na_values =na_values, dtype=dtype_mapping)
                process_data(df)
                
                # maybe there is data inside other months that is before limited data so I left everything to append just in case, but if
                # we are certain that that is not the case then we can use this part of code
                #file_name_parts = file.split('.')
                #time = datetime.strptime(file_name_parts[0], '%Y%m%d')
                #if(time>datetime.strptime('2023-03-15', '%Y%m%d')):
                #    continue


                if not file_created:
                    df.to_csv(output_file, index=False)
                    file_created = True
                else:
                    df.to_csv(output_file, mode='a', index=False, header=False)
                 
os.makedirs('/app/output', exist_ok=True)

main_directory = '/app'
merged_file_path = '/app/output/processed_data.csv'
logging.info('dosli')
merge_csv_files(main_directory, merged_file_path)




