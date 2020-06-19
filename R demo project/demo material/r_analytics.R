# Script Info ---------------------------------------------------------------------------------
# Script Name:   
# Created By: Saeed Mohajeryami
# Created On:  Wed Jun 11 2020  
# Description:  Pulling data and performing an aggregation

# set working directory
setwd("~/Insight fellow Program/DevOps Program/insight_newvision_ci_pipeline/R demo project/demo material")

# Set up environment --------------------------------------------------------------------------
if(!"dplyr" %in% installed.packages()) install.packages("dplyr")
if(!"reshape2" %in% installed.packages()) install.packages("reshape2")
if(!"data.table" %in% installed.packages()) install.packages("data.table")
if(!"stringr" %in% installed.packages()) install.packages("stringr")

library(dplyr)
library(reshape2)
library(data.table)
library(stringr)

# load data
student_ela_scores = read.csv("sample_student_ela_scores.csv")
student_math_scores = read.csv("sample_student_math_scores.csv")
student_science_scores = read.csv("sample_student_science_scores.csv")
student_scores_extra = read.csv("sample_student_scores_extra.csv")
student_scores_history = read.csv("sample_student_scores_history.csv")
subject_test_scores = read.csv("sample_subject_test_scores.csv")

# processing
all_scores <- subject_test_scores

# combine all these data to create one large table
studentScores <- rbindlist(l = list(student_ela_scores,
                                    student_math_scores,
                                    student_science_scores,
                                    student_scores_history,
                                    student_scores_extra),
                           use.names = TRUE,
                           fill = TRUE)

# test score average in one district
# our_school_agg <- aggregate(studentScores$test_score, by=list(studentScores$school_id), FUN=mean)
# colnames(school_agg) <- c("school_id", "average_score")

# test score average in one district for different subjects
our_school_subject_agg <- aggregate(studentScores$test_score, by=list(studentScores$school_id, studentScores$subject), FUN=mean)
colnames(our_school_subject_agg) <- c("school_id", "subject", "average_score")

# find the average score of all schools for different subjects
# all_schools_subject_agg <- aggregate()
all_schools_subject_agg <- data.frame(school_id=(all_scores$school_id),
                                      subject = (all_scores$subject),
  average_score=c(all_scores$high_score + all_scores$low_score)/2)

# find test score average
subject_agg <- aggregate(all_schools_subject_agg$average_score, by=list(all_schools_subject_agg$subject), FUN=mean)
colnames(subject_agg) <- c("subject", "average_score")

our_school_subject_agg$assessment <- c(-1)

for(i in 1:nrow(our_school_subject_agg))
  {
  for (j in 1:nrow(subject_agg))
    {
      if ((our_school_subject_agg$subject[i] == subject_agg$subject[j]) & (our_school_subject_agg$average_score[i] >= subject_agg$average_score[j]))
          {
        our_school_subject_agg$assessment[i] <- c("average and above") 
      } else if ((our_school_subject_agg$subject[i] == subject_agg$subject[j]) & (our_school_subject_agg$average_score[i] < subject_agg$average_score[j]))
        {
        our_school_subject_agg$assessment[i] <- c("below average") 
         }
    }
}

write.csv(our_school_subject_agg,"./assessment.csv", row.names = TRUE)
