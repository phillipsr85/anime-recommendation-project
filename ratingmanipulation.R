##Linux uncle

library(recommenderlab)
library(reshape2)
library(ggplot2)
test.rating<-alpha.rating
head(test.rating)
colnames(test.rating)
nrow(test.rating)

##remove -1
test.rating<-test.rating[test.rating$rating!=-1, ]

##remove hentai
colnames(alpha.anime)
unique(alpha.anime$genre)
alpha.anime$anime_id[alpha.anime$genre=="Hentai"]
t<-test.rating[test.rating$user_id!=alpha.anime$anime_id[alpha.anime$genre=="Hentai"]
head(t)               

hvec<- as.vector(alpha.anime$anime_id[alpha.anime$genre=="Hentai"])
test.rating<-test.rating[ ! test.rating$user_id %in% hvec, ]

##test/train
train_index <- sample(1:nrow(test.rating), 0.6 * nrow(test.rating))
train.set <- test.rating[train_index,]
test.set  <- test.rating[-train_index,]

nrow(train.set)
ncol(test.rating)


##
g<-acast(train.set, user_id ~ anime_id)
class(g)
R<-as.matrix(g)