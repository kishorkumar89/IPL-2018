setwd("E:/GIT_Hub/IPL-2018")

df_set=read.csv("E:/GIT_Hub/IPL-2018/inputs/Match.csv",header = TRUE,encoding='ISO-8859-1')

library(dplyr)

df_set <- tbl_df(df_set)
print(df_set,n=10)
colnames(df_set)

toss_prob=select(df_set,Toss_Winner,match_winner)
toss_prob[2,1]
toss_prob[2,2]
rows=nrow(toss_prob)

for (varb in 1:rows) {
     if((toss_prob[(paste(varb)),1])==(toss_prob[(paste(varb)),2])){
       toss_prob[(paste(varb)),3] <- 1
     }
  else{
    toss_prob[(paste(varb)),3] <- 0
    }
   }

toss_prob=select(toss_prob,Toss_Winner,V3)

toss_prob <-toss_prob %>%
  select(Toss_Winner,V3)%>%
  group_by(Toss_Winner) %>%
  summarise(value=(sum(V3)/n())*100)



library(plotly)

img <- plot_ly(toss_prob, x = ~Toss_Winner, y = ~value, type = 'bar', 
                      name = ~Toss_Winner, color = ~Toss_Winner) %>%
  layout(yaxis = list(title = 'Total Sales'), barmode = 'stack')

Sys.setenv("plotly_username"="shyam.kishor.kumar89")
Sys.setenv("plotly_api_key"="s2qivWLgkcon0cqiugYv")

plotly_IMAGE(img, width = 1366, height = 768, format = "png", scale = 2,
             out_file = "image/Probability of winning the game is team x wins the toss.png")





