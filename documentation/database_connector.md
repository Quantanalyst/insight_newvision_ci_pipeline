In order to connect R to Redshift, I have used RJDBC package, which is a JDBC connector written for R. Below, you can see how to use it. 

Steps:
1. calling RJDBC library
2. download the driver (if it doesn't exist)
3. define a variable to store the driver location
4. define another variable to store the Redshift jdbcurl (you can get this link from Redshift console)
5. connect using dbConnect command
6. Now, you can run querry with other RJDBC commands. 


### My example

library(RJDBC)

download.file('https://s3.amazonaws.com/redshift-downloads/drivers/jdbc/1.2.43.1067/RedshiftJDBC42-no-awssdk-1.2.43.1067.jar','/tmp/RedshiftJDBC42-no-awssdk-1.2.43.1067.jar')

driver <- JDBC("com.amazon.redshift.jdbc42.Driver", "/tmp/RedshiftJDBC42-no-awssdk-1.2.43.1067.jar", identifier.quote="`")

url <- "jdbc:redshift://tf-redshift-cluster.ca3ybu4spx0o.us-west-2.redshift.amazonaws.com:5439/newvisionredshift?user=root&password=mySecretPassw0rd"

conn <- dbConnect(driver, url)