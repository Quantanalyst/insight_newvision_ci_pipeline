#!/bin/bash

#   sudo apt-get update -y
#   sudo apt-get install r-base-core -y
#   sudo apt-get install r-cran-rjava -y
#   sudo R CMD javareconf
#   sudo chmod 777 /usr/local/lib/R/site-library
#   sudo R CMD javareconf

# install R packages
# chmod 777 /tmp/libraries.R
# sudo Rscript /tmp/libraries.R



# extended version

# update the apt-get repos
# There is a bug in the system that you must put the following command twice
# sudo apt-get update -y
# sudo apt-get update -y


# install R
# sudo apt-get install r-base -y

# install RStudio-Server 1.3.959 (2020-05-22)
# sudo apt-get install gdebi-core -y
# wget https://download2.rstudio.org/server/bionic/amd64/rstudio-server-1.3.959-amd64.deb
# sudo gdebi rstudio-server-1.3.959-amd64.deb --n

#install shiny and shiny-server 1.5.13.944 (March 4th, 2020)
# sudo R -e "install.packages('shiny', repos='http://cran.rstudio.com/')"
# wget https://download3.rstudio.org/ubuntu-14.04/x86_64/shiny-server-1.5.13.944-amd64.deb
# sudo gdebi shiny-server-1.5.13.944-amd64.deb --n

# run rstudio server
# create a user and a user directory first
# sudo mkdir /home/rs_user
# sudo useradd rs_user
# sudo chown -R rs_user /home/rs_user
# run rstudio-server service
# sudo service rstudio-server start

# some necessary linux packages to run R packages
# sudo apt-get install r-cran-rjava -y
# sudo apt-get install r-cran-dbi -y

# set java config with the below command
# sudo R CMD javareconf


# install R dependencies
# chmod 777 /tmp/libraries.R
# sudo chmod 777 /usr/local/lib/R/site-library
# sudo Rscript /tmp/libraries.R

# change the R studio password using the parameter passed
# echo "changing rs_user password to $1"
# echo "rs_user:$1" | sudo chpasswd

# configure Shiny server 
# sudo mkdir ~/ShinyApps
# sudo /opt/shiny-server/bin/deploy-example user-dirs
# sudo cp -R /opt/shiny-server/samples/sample-apps/hello ~/ShinyApps/
# you can see your Shiny dashboards on http://ec2-YOUR-IP.compute-1.amazonaws.com:3838/<your_linux_username>/hello
# e.g. http://ec2-54-188-223-53.us-west-2.compute.amazonaws.com:3838/ubuntu/hello

# Run some analytics
# sudo Rscript /tmp/analytics.R