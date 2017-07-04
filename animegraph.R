library(ggplot2)
install.packages("readr")
library(readr)
install.packages("repr")
library(repr)

options(repr.plot.width=4, repr.plot.height=3.5)
system("ls ../input")

anime_data <- read.csv(file="C:\\Users\\rpeezy\\Documents\\Big Data Semester 1\\capstone\\anime ratings\\anime.csv", stringsAsFactors=T)
head(anime_data)

anime_data$episodes <- as.numeric(anime_data$episodes)
summary(anime_data)

##I'm going to focus on the shows that have both been rated and have finished.

anime_data <- anime_data[!is.na(anime_data$rating),]
anime_data <- anime_data[anime_data$episodes!='Unknown',]
anime_data$episodes <- as.numeric(as.character(anime_data$episodes))
summary(anime_data)

ggplot(data=anime_data, aes(x=0, y=rating)) +
  geom_boxplot() +
  xlab('') +
  scale_x_discrete(breaks=NULL) +
  scale_y_continuous(lim=c(1,10), breaks=seq(1,10,1))

#Let's look at the distribution of types of shows.

type_df <- data.frame(sort(table(anime_data$type), decreasing=T))[0:6,]
colnames(type_df) <- c('Type', 'Count')
ggplot(data=type_df, aes(x=Type, y=Count)) +
  geom_bar(stat="identity", fill="#999933", colour="black")

##Let's look at a histogram of the ratings.
rating_df <- data.frame(anime_data$rating)
colnames(rating_df) <- 'Rating'
ggplot(data=rating_df, aes(x=Rating)) +
  geom_histogram(binwidth=0.25, colour="black", fill="light blue")

#Now onto episodes vs. rating.
ggplot(data=anime_data, aes(x=episodes, y=rating)) +
  geom_point(size=0, colour='blue') +
  scale_y_continuous(breaks=seq(0,10,1)) +
  scale_x_continuous(breaks=seq(0,2000,500))

##Those shows with a lot of episodes are making it hard to see the 'regular' shows.
ggplot(data=anime_data[anime_data$episodes<200,], aes(x=episodes, y=rating)) +
  geom_point(size=0, colour='blue') +
  scale_y_continuous(breaks=seq(0,10,1)) +
  scale_x_continuous(breaks=seq(0,200,20))

##Hmm... better but this takes into account movies, OVAs, etc. Let's see just shows.
shows_df <- anime_data[anime_data$type=='TV',]

ggplot(data=shows_df[shows_df$episodes<200,], aes(x=episodes, y=rating)) +
  geom_point(size=0, colour='blue') +
  scale_y_continuous(lim=c(1,10), breaks=seq(1,10,1)) +
  scale_x_continuous(breaks=seq(0,200,20))

## rating v members
ggplot(data=anime_data, aes(x=members, y=rating)) +
  geom_point(size=0, colour='red')

##shows only
ggplot(data=anime_data[anime_data$type=='TV',], aes(x=members, y=rating)) +
  geom_point(size=0, colour='red') +
  scale_y_continuous(lim=c(1,10), breaks=seq(1,10,1))


