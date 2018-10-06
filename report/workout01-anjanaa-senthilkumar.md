Anjanaa Senthil Kumar
October 2, 2018

##### 5) Ranking of Teams

``` r
teams <- read.csv('../data/nba2018-teams.csv')

team_ranks <- arrange(select(teams,team,salary), desc(salary))
gg_salary <- ggplot(team_ranks, aes(x=reorder(team, salary), y=salary))+
            geom_bar(stat = 'identity')+
            geom_hline(yintercept = mean(team_ranks$salary), color= "red") + 
            labs(x="Team", y="Salary ($ in millions)", title = "NBA Team ranked by Total Salary")+
            coord_flip()

gg_salary
```

![](../report/workout01-anjanaa-senthilkumar_files/Ranked%20by%20Total%20Salary-1.png)

``` r
team_points <- arrange(select(teams,team,points), desc(points))
gg_points <- ggplot(team_points, aes(x=reorder(team, points), y=points))+
  geom_bar(stat = 'identity')+
  geom_hline(yintercept = mean(team_points$points), color="red") +
  labs(x="Team", y="Total Points", title = "NBA Team ranked by Total Points")+
  coord_flip() 

gg_points
```

![](../report/workout01-anjanaa-senthilkumar_files/Ranked%20by%20Total%20Points-1.png)

``` r
team_efficiency <- arrange(select(teams,team,efficiency), desc(efficiency))
gg_efficiency <- ggplot(team_efficiency, aes(x=reorder(team,efficiency), y=efficiency))+
  geom_bar(stat = 'identity')+
  geom_hline(yintercept = mean(team_efficiency$efficiency), color="red") +
  labs(x="Team", y="Total Efficiency", title = "NBA Team ranked by Total Efficiency")+
  coord_flip() 

gg_efficiency
```

![](../report/workout01-anjanaa-senthilkumar_files/Ranked%20by%20Efficiency-1.png)

``` r
team_experience <- arrange(select(teams,team,experience), desc(experience))
gg_experience <- ggplot(team_experience, aes(x=reorder(team,experience), y=experience))+
  geom_bar(stat = 'identity')+
  geom_hline(yintercept = mean(team_experience$experience), color="red") +
  labs(x="Team", y="Total Experience (in years)", title = "NBA Team ranked by Total Experience")+
  coord_flip() 

gg_experience
```

![](../report/workout01-anjanaa-senthilkumar_files/Ranked%20by%20Experience-1.png)

###### I used the sum of the years of experience each player has had as a way to rank the team. Generally, the more experienced a player is, the better they are at basketball.

##### Comments and Reflection

-   Yes, this was the first time I was working on a project with this file structure. It was very intuitive to work through.
-   This was not my first time using relative paths. \*Yes, this was my first time using R Script. Using Markdown Syntax to separate different sections of code seems to make it easier to work through the file.
-   Learning to use ggplot and figuring out the syntax to display graphs in different ways was the most time consuming.
-   This assignment was not easy. I had a difficult time fully grasping how to get everything onto github.
-   No one helped me complete this assignment.
-   It took me approximately seven hours to commplete this assignment.
