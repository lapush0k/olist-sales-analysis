from pathlib import Path
import sqlite3
import pandas as pd

conn = sqlite3.connect("olist.db")

for file_path in Path('data').glob('*.csv'):
    df = pd.read_csv(file_path)
    table_name = file_path.stem.replace('olist_', '').replace('_dataset', '')
    print(table_name)
    df.to_sql(table_name, conn, if_exists="replace", index=False)
    
conn.close()