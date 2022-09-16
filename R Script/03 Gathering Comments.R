# devtools::install_github("vosonlab/SocialMediaLab/SocialMediaLab")

Authorize <- AuthenticateWithYoutubeAPI(key)

# List of video Ids
videoIds <- as.data.frame(video_final.df$ytVideoID)
videoIds <- unique(videoIds$`video_final.df$ytVideoID`)
videoIds <- as.data.frame(videoIds)
colnames(videoIds)[1] <- "videoId"
videoIds <- videoIds %>%
  filter(videoId != "YBYI7E2PqWE")

comments_all <- data.frame()
for(i in 1:nrow(videoIds)){
  videoId <- c(videoIds[i, 1])
  print(videoId)
  commentData <- CollectDataYoutube(videoIDs = videoId, apiKeyYoutube = key, writeToFile = FALSE)
  
  comments_all <- rbind(comments_all, commentData)
}


comments_all$Comment <- tolower(comments_all$Comment)
comments_all$Comment <- replace_emoji(comments_all$Comment)
comments_all$Comment <- replace_emoticon(comments_all$Comment)


# Remove all rows which contained emoji or emoticons
comments_all <- comments_all[- grep("<", comments_all$Comment),]
comments_all <- comments_all[- grep("Joma Tech", comments_all$User),]


# Only keep the first comments
comments_all <- comments_all[grep("FALSE", comments_all$ReplyToAnotherUser),]

# Dataset Size Transition: 16846 -> 11049 -> 11002 -> 7078 -> 7010

# Sentiment Analysis
comments_all$sentimentQDAP <- analyzeSentiment(comments_all$Comment)
comments_all$Sentiment <- convertToDirection(comments_all$sentimentQDAP)


write.csv(comments_all, "commentData.csv", row.names = FALSE)

commentData <- read.csv("commentData.csv", header = TRUE)
commentData <- commentData %>%
  drop_na(Sentiment.SentimentQDAP)


# Plots
commentData %>%
  group_by(Sentiment.SentimentQDAP) %>%
  summarise(NumComments = n()) %>%
  ggplot(aes(x = reorder(Sentiment.SentimentQDAP, -NumComments) , y = NumComments, fill = Sentiment.SentimentQDAP)) + geom_bar(stat = "identity", 
                                                                                                                               colour = 'black') +
  scale_x_discrete(guide = guide_axis(angle = 90)) +
  labs(x = "Sentiments", y = "Num. Comments", title = "Number Of Comments Which Fall Under Each Sentiment", fill = "Sentiments:") + 
  theme_light() + scale_fill_manual(values = c(rgb(15, 76, 92, max = 255), 
                                                 rgb(227, 100, 20, max = 255),
                                                 rgb(153, 3, 30, max = 255)
                                                 ))


