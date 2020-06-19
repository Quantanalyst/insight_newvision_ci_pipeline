# Script Info ---------------------------------------------------------------------------------
# Script Name:   
# Created By: Saeed Mohajeryami
# Created On:  Wed Jun 11 2020  
# Description:  Reporting schools with below average
# ---------------------------------------------------------------------------------------------
rm(list=ls())
all_schools_assessment = read.csv("/tmp/assessment.csv")

above_average <- all_schools_assessment[which(all_schools_assessment$assessment == "average and above"),][2:4]

write.csv(above_average,"/tmp/above_average.csv", row.names = TRUE)