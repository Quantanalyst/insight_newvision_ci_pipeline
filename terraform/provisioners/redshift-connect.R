library("RJDBC")

download.file('https://s3.amazonaws.com/redshift-downloads/drivers/jdbc/1.2.43.1067/RedshiftJDBC42-no-awssdk-1.2.43.1067.jar','~/RedshiftJDBC42-no-awssdk-1.2.43.1067.jar')

driver <- JDBC("com.amazon.redshift.jdbc42.Driver", "~/RedshiftJDBC42-no-awssdk-1.2.43.1067.jar", identifier.quote="`")

url <- "jdbc:redshift://tf-redshift-cluster.ca3ybu4spx0o.us-west-2.redshift.amazonaws.com:5439/newvisionredshift?user=root&password=mySecretPassw0rd"

conn <- dbConnect(driver, url)



