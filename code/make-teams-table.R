# ==================================================
#Title: Workout1- Data Wrangling and Visualization
#Description: Data preparation for analyzing key
#             statistics by teams
#Input:  nba2018.csv
#Output: nba2018-teams.csv, teams-summary.txt,
#        efficiency-summary.txt
# ===================================================

library(dplyr)
library(ggplot2)


nba <- read.csv('C:\\Users\\anjan\\Desktop\\workout01\\data\\nba2018.csv')

# 4) Data Preparation

# experience variable
nba$experience <- as.character(nba$experience)
nba$experience[which(nba$experience=="R")] <- "0"
nba$experience <- as.integer(nba$experience)

# salary variable
nba$salary <- nba$salary /1000000

#position variable
nba$position <-revalue(nba$position, c("C"= "center", "PF" = "power_fwd", "PG" = "point_guard", "SF"="small_fwd", "SG"="shoot_guard"))

# Adding new variables

missed_fg <- nba$field_goals_atts - nba$field_goals
missed_ft <- nba$points1_atts - nba$points1
rebounds <- nba$off_rebounds + nba$def_rebounds
nba2 <- mutate(nba, missed_fg, missed_ft, rebounds)

efficiency <- (nba2$points + nba2$total_rebounds + nba2$assists + nba2$steals + nba2$blocks - nba2$missed_fg - nba2$missed_ft-nba2$turnovers)/nba2$games
nba2 <- mutate(nba2, efficiency)

sink(file = '../output/efficiency-summary.txt')
summary(efficiency)
sink()

# Data aggregation

teams <- summarise(
                group_by(nba2, team),
                experience = round(sum(experience),2), 
                salary = round(sum(salary),2), 
                points3=sum(points3), 
                points2=sum(points2), 
                points1=sum(points1),
                points = sum(points),
                off_rebounds = sum(off_rebounds),
                def_rebounds = sum(def_rebounds),
                assists= sum(assists),
                steals = sum(steals),
                blocks = sum(blocks),
                turnovers = sum(turnovers),
                fouls = sum(fouls),
                efficiency = sum(efficiency)
       )

sink(file = '../output/teams-summary.txt')
summary(teams)
sink()


write.csv(teams,file= '../data/nba2018-teams.csv', row.names = FALSE)

