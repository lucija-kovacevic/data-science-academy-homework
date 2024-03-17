# %%
import pandas as pd
from clickhouse_driver import Client
  
client = Client(host='clickhouse.sofascore.ai',
                port='9000',
                user='lkovacevic',
                password='b9Ea8XzdFr0w6Zo32i4Z'
)

create_table="""CREATE TABLE IF NOT EXISTS lkovacevic.l2_dataset
(
eventDate String,
eventName String,
userPseudoId String,
platform LowCardinality(String),
status LowCardinality(String),
geoCountry LowCardinality(String),
id Nullable(Int64)
)
ENGINE = MergeTree()
ORDER BY eventDate
SETTINGS index_granularity = 8192;"""

client.execute(create_table)

chunksize = 1000000
file_path = '/Users/lucij/Desktop/processed_data.csv'
na_values = [r'\N', '','NaN'] 

dtype_mapping = {
    'eventDate': 'str',  
    'eventName': 'str',
    'userPseudoId': 'str',
    'platform': 'str',
    'status': 'str',
    'geoCountry': 'str',
    'id': 'str', 
}
for chunk_df in pd.read_csv(file_path, chunksize=chunksize,na_values=na_values,dtype=dtype_mapping):
    chunk_df['id'] = pd.to_numeric(chunk_df['id'], errors='coerce')
    chunk_df['id'] = chunk_df['id'].where(pd.notna(chunk_df['id']), None)
    chunk_df = chunk_df.where(pd.notna(chunk_df), None)
    
    client.insert_dataframe('INSERT INTO lkovacevic.l2_dataset(eventDate, eventName, userPseudoId, platform, status, geoCountry, id) VALUES', chunk_df, settings=dict(use_numpy=True))
  



