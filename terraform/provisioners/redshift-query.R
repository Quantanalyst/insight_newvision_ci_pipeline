# run query on redshift

# list tables
dbGetTables(conn)

# list all the table on public schema
dbGetQuery(conn, "SELECT table_name FROM information_schema.tables WHERE table_schema = 'public'")

# get some data from the Redshift table
dbGetQuery(conn, "select count(*) from public.customer")

# this is not a good idea – the table has more than 100 Mio. rows”
# fligths <- dbReadTable(conn, "flights")


