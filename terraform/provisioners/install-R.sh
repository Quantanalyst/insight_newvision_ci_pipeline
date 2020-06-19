#! /bin/bash
sudo apt-get update -y 
sudo apt-get update -y
sudo apt-get install wget -y
sudo apt-get install r-base -y
sudo apt-get install r-cran-rjava -y
sudo R CMD javareconf
sudo chmod 777 /usr/local/lib/R/site-library
sudo R CMD javareconf

# install libraries
sudo chmod 777 /tmp/libraries.R
sudo Rscript /tmp/libraries.R

# change mode of other R scripts
sudo chmod 777 /tmp/full_demo.R

# download JDBC connector for Redshift
wget --directory-prefix=/tmp/ https://s3.amazonaws.com/redshift-downloads/drivers/jdbc/1.2.43.1067/RedshiftJDBC42-no-awssdk-1.2.43.1067.jar

