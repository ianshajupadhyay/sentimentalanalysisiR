library(syuzhet)
library(wordcloud2)
library(tm)

txt <- readLines(file.choose())

docs = Corpus(VectorSource(txt))

docs = tm_map(docs,tolower)
docs = tm_map(docs,removeNumbers)
docs = tm_map(docs,removePunctuation)
docs = tm_map(docs,removeWords,stopwords("english"))
docs = tm_map(docs,stripWhitespace)

tdm = TermDocumentMatrix(docs)
tdm =as.matrix(tdm)
w<-rowSums(tdm)
w
w_subset = subset(w,w>=2)
w_subset
barplot(w_subset,las=2,col = rainbow(20))

w1 <- data.frame(names(w),w)
colnames(w1) <- c('names','freq')
wordcloud2(w1,shape='circle',size=0.5)

txt <- iconv(txt,"UTF-8")
txt1 <- get_nrc_sentiment(txt)
barplot(colSums(txt1),las=2,col=rainbow(20))

s1 <- get_sentiment(txt,method = "bing")
s2<- get_sentiment(txt,method = "nrc")
s3<-get_sentiment(txt,method= "afinn")
s1
s2
s3
