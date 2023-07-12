import duckdb
import pandas as pd

# Create a new in-memory database
con = duckdb.connect(database=':memory:')

# Create a table
con.execute("CREATE TABLE IF NOT EXISTS integers(i INTEGER)")

# Insert data using a parameterized query
value = 42
con.execute("INSERT INTO integers VALUES(?)", [value])

# Query the database
results = con.execute("SELECT 42 AS a")
df = pd.DataFrame(results.fetchall(), columns=results.description)

print(df)
