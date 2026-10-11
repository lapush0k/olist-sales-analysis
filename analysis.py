import sqlite3
import os
import pandas as pd
import matplotlib.pyplot as plt
from matplotlib.ticker import FuncFormatter

conn = sqlite3.connect("olist.db")

query = '''
select strftime('%Y-%m', order_purchase_timestamp) as month, round(sum(price), 2) as revenue 
from order_items
join orders on orders.order_id = order_items.order_id
where order_status = 'delivered'
group by month
order by month;
'''
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