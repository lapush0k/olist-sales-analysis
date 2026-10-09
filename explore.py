from pathlib import Path
import pandas as pd

data_folder = Path('data')

for file_path in data_folder.glob('*.csv'):
    print(file_path.name)
    df = pd.read_csv(file_path)
    print(df.shape)
    print()
    print(list(df.columns))
    print()
    print(df.head(5))