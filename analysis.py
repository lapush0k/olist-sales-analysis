# Grafic a monthly revenue

import sqlite3
import os
import pandas as pd
import matplotlib.pyplot as plt
from matplotlib.ticker import FuncFormatter

conn = sqlite3.connect("olist.db")
base_dir = os.path.dirname(os.path.abspath(__file__))
sql_path = os.path.join(base_dir, '02_sales.sql')

with open(sql_path, encoding='utf-8') as f:
    queries = f.read().split(';')

query = queries[0]
df = pd.read_sql(query, conn)
conn.close()

df = df[(df['month'] >= '2017-01') & (df['month'] <= '2018-08')]

os.makedirs('images', exist_ok=True)
plt.figure(figsize=(10, 5))
plt.gca().yaxis.set_major_formatter(FuncFormatter(lambda x, _: f'{x/1e6:.1f}M'))
plt.grid(True, alpha=0.3)
plt.plot(df['month'], df['revenue'], marker='o')
plt.xticks(rotation=45)
plt.title('Olist monthly revenue')
plt.xlabel('Month')
plt.ylabel('Revenue, BRL')
plt.tight_layout()
plt.savefig('images/revenue_by_month.png', dpi=150)

# Top 10 Categories by Revenue

conn = sqlite3.connect("olist.db")
base_dir = os.path.dirname(os.path.abspath(__file__))
sql_path = os.path.join(base_dir, '02_sales.sql')

with open(sql_path, encoding='utf-8') as f:
    queries = f.read().split(';')

query = queries[1]
df = pd.read_sql(query, conn)
df['category'] = df['category'].str.replace('_', ' ')
conn.close()
plt.figure(figsize=(10, 6))
plt.barh(df['category'], df['revenue'])
plt.gca().invert_yaxis()
plt.gca().xaxis.set_major_formatter(FuncFormatter(lambda x, _: f'{x/1e6:.1f}M'))
plt.title('Top 10 Categories by Revenue')
plt.xlabel('Revenue, BRL')
plt.tight_layout()
plt.savefig('images/top10_categories.png', dpi=150)

# Orders by State (Top 10)

conn = sqlite3.connect('olist.db')
base_dir = os.path.dirname(os.path.abspath(__file__))
sql_path = os.path.join(base_dir, '01_basics.sql')

with open(sql_path, encoding='utf-8') as f:
    queries = f.read().split(';')

query = queries[2]
df = pd.read_sql(query, conn)
conn.close()

plt.figure(figsize=(10, 6))
plt.bar(df['customer_state'], df['count_order'])
plt.title('Delivered orders by state (top 10)')
plt.xlabel('State')
plt.ylabel('Number of orders')
plt.tight_layout()
plt.savefig('images/orders_by_state.png', dpi=150)
