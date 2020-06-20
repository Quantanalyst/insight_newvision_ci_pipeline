# Script Info ---------------------------------------------------------------------------------
# Script Name:   
# Created By: Glen Acheampong 
# Created On:  Wed Jun 10 12:59:13 2020  
# Description:  
# Required/Related Scripts: [OPTIONAL] 
# Controller file(s) that call this script: [OPTIONAL] 


# Set up environment --------------------------------------------------------------------------
if(!"dplyr" %in% installed.packages()) install.packages("dplyr")
if(!"reshape2" %in% installed.packages()) install.packages("reshape2")
if(!"data.table" %in% installed.packages()) install.packages("data.table")
if(!"stringr" %in% installed.packages()) install.packages("stringr")

library(dplyr)
library(reshape2)
library(data.table)
library(stringr)

# Connect to warehouse ------------------------------------------------------------------------ 

ptb <- proc.time() 
scriptName <- ''
fileName <- 'sample_student_score_report.csv'

# Script-specific functions or variables ------------------------------------------------------ 

studentEla <- paste0(getwd(), '/src/sample_data/sample_student_ela_scores.csv')
studentMath <- paste0(getwd(), '/src/sample_data/sample_student_math_scores.csv')
studentScience <- paste0(getwd(), '/src/sample_data/sample_student_science_scores.csv')
studentHistory <- paste0(getwd(), '/src/sample_data/sample_student_scores_history.csv')
studentExtra <- paste0(getwd(), '/src/sample_data/sample_student_scores_extra.csv')
allScores <- paste0(getwd(), '/src/sample_data/sample_subject_test_scores.csv')

# Load Data ----------------------------------------------------------------------------------- 

studentElaData <- fread(file = studentEla)
studentMathData <- fread(file = studentMath)
studentScienceData <- fread(file = studentScience)
studentHistoryData <- fread(file = studentHistory)
studentExtraData <- fread(file = studentExtra)

subjectScoreData <- fread(file = allScores)[0:60]

# Pre-process --------------------------------------------------------------------------------- 

studentScores <- rbindlist(l = list(studentElaData,
                                    studentMathData,
                                    studentScienceData,
                                    studentHistoryData,
                                    studentExtraData),
                           use.names = TRUE,
                           fill = TRUE)

subjectScoreData[, average_score := (high_score + low_score)/2, by = .(school_id, 
                                                                       subject, 
                                                                       test_date)]

# Processing ---------------------------------------------------------------------------------- 

studentScoreReport <- subjectScoreData[studentScores, on = c('school_id', 
                                                             'subject', 
                                                             'test_date')]

studentScoreReport[test_score >= average_score, at_or_above_average := 1]
studentScoreReport[at_or_above_average != 1 | is.na(at_or_above_average), at_or_above_average := 0]

studentScoreReport <- studentScoreReport[, .(student_id,
                                             school_id,
                                             subject,
                                             test_score,
                                             at_or_above_average,
                                             test_date)][order(student_id)]

# Push Data ----------------------------------------------------------------------------------- 

ptfinal <- proc.time()-ptb

fwrite(studentScoreReport, file = paste0(getwd(), '/src/sample_data/', fileName))

# Clean up environment ------------------------------------------------------------------------ 
gc()
rm(list=ls(envir=globalenv()))
