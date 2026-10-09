import pandas as pd

df = pd.read_csv("data/olist_customers_dataset.csv")

print(df["customer_id"].nunique())
print(df["customer_unique_id"].nunique())