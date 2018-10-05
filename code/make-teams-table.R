# ==================================================
#Title: Workout1- Data Wrangling and Visualization
#Description:
#Input: nba2018.csv
#Output:
# ===================================================

knitr::opts_chunk$set(echo = TRUE, fig.path = '../report/')

library(dplyr)
library(ggplot2)
library(readr)
library(plyr)
library(data.table)

nba <- read.csv('C:\\Users\\anjan\\Desktop\\workout01\\data\\nba2018.csv')

# 4) Data Preparation
nba$experience <- as.character(nba$experience)
nba$experience[which(nba$experience=="R")] <- "0"
nba$experience <- as.integer(nba$experience)


# experience variable

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

sink(file = '../data/teams-summary.txt')
summary(teams)
sink()


write.csv(teams,file= '../data/nba2018-teams.csv', row.names = FALSE)

# 5) Ranking of Teams

team_ranks <- arrange(select(teams,team,salary), desc(salary))
gg_salary <- ggplot(team_ranks, aes(x=reorder(team, salary), y=salary))+
            geom_bar(stat = 'identity')+
            geom_hline(yintercept = mean(team_ranks$salary), color= "red") + 
            labs(x="Team", y="Salary (in millions)", title = "NBA Team ranked by Total Salary")+
            coord_flip()
         



team_points <- arrange(select(teams,team,points), desc(points))
gg_points <- ggplot(team_points, aes(x=reorder(team, points), y=points))+
  geom_bar(stat = 'identity')+
  geom_hline(yintercept = mean(team_points$points), color="red") +
  labs(x="Team", y="Total Points)", title = "NBA Team ranked by Total Points")+
  coord_flip() 
  
team_efficiency <- arrange(select(teams,team,efficiency), desc(efficiency))
gg_efficiency <- ggplot(team_efficiency, aes(x=reorder(team,efficiency), y=efficiency))+
  geom_bar(stat = 'identity')+
  geom_hline(yintercept = mean(team_efficiency$efficiency), color="red") +
  labs(x="Team", y="Total Efficiency)", title = "NBA Team ranked by Total Efficiency")+
  coord_flip() 

team_experience <- arrange(select(teams,team,experience), desc(experience))
gg_experience <- ggplot(team_experience, aes(x=reorder(team,experience), y=experience))+
  geom_bar(stat = 'identity')+
  geom_hline(yintercept = mean(team_experience$experience), color="red") +
  labs(x="Team", y="Total Experience (in years)", title = "NBA Team ranked by Total Experience")+
  coord_flip() 


       