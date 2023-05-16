using DuckDB
#using DataFrames
# create a new in-memory database
con = DBInterface.connect(DuckDB.DB, "myddb.duckdb") #:memory:

# create a table
DBInterface.execute(con, "CREATE TABLE IF NOT EXISTS integers(i INTEGER)")

# insert data using a prepared statement
stmt = DBInterface.prepare(con, "INSERT INTO integers VALUES(?)")
DBInterface.execute(stmt, [42])

# query the database
results = DBInterface.execute(con, "SELECT 42 a")
print(results)