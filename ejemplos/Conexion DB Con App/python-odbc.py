import pyodbc

conn_str = ( 
    "DRIVER=/Library/ODBC/Devart/PostgreSQL/libdevartodbcpostgresql.dylib;"
    "SERVER=localhost;" "PORT=5433;" 
    "DATABASE=pagila;" 
    "UID=postgres;" 
    "PWD=zero;" 
)

conn = pyodbc.connect(conn_str)

cursor = conn.cursor()

cursor.execute("SELECT title FROM film LIMIT 5")

for row in cursor.fetchall():
    print(row.title)

conn.close()
