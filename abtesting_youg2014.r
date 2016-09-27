## A/B test

# Data is from Young, 2014 - Library A/B Test paper (proper citation still needed)

# I renamed the crazy egg csv files for easier readin
files=c("1_interact.csv", "2_connect.csv", "3_learn.csv", "4_help.csv", "5_services.csv")

# preparing the table with button name, clicks on the button and total clicks in the time
names=c("INTERACT", "CONNECT", "LEARN", "HELP", "SERVICES")
clicks=numeric(length(names))
totclicks=numeric(length(names))
df=data.frame(names, clicks, totclicks)

# extracting button clicks and total clicks
for (ii in 1:length(names)) {
dftemp=read.csv(files[ii])
ind=which(dftemp$Name==names[ii])
df$clicks[ii]=dftemp$No..clicks[ind]
df$totclicks[ii]=sum(dftemp$No..clicks)
}

# calculat ratio of clicks
df$clratio=df$clicks/df$totclicks

# look at the data frame
df
# -> approx. 1 to 3 % clicks where on the button, nearly a rare event ;)

# calculate z-score
df$z=numeric(length(names))
for (ii in 1:length(names)) {
p=df$clratio[ii] # conversation rate
pc=df$clratio[1] # control conversation rate
N=df$totclicks[ii]
Nc=df$totclicks[1]
df$z[ii]=(p-pc)/(sqrt(p*(1-p)/N+pc*(1-pc)/Nc))
}

# now what could also be important is the duration of the a/b test and the number of visitors on the page not only the clicks on any button
