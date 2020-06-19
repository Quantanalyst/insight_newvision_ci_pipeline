# install additional R libraries
# install.packages('testthat')
# install.packages("RJDBC")
if(!"RJDBC" %in% installed.packages()) install.packages("RJDBC")
# if(!"dplyr" %in% installed.packages()) install.packages("dplyr")
# if(!"reshape2" %in% installed.packages()) install.packages("reshape2")
if(!"data.table" %in% installed.packages()) install.packages("data.table")
# if(!"stringr" %in% installed.packages()) install.packages("stringr")
