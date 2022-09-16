# devtools::install_github("vosonlab/SocialMediaLab/SocialMediaLab")

Authorize <- AuthenticateWithYoutubeAPI(key)

videoId <- c("1-Iu__4R_b0")
commentData <- CollectDataYoutube(videoIDs = videoId, apiKeyYoutube = key, writeToFile = FALSE)

commentData$Comment <- tolower(commentData$Comment)
commentData$Comment <- replace_emoji(commentData$Comment)
commentData$Comment <- replace_emoticon(commentData$Comment)


# Remove all rows which contained emoji or emoticons
commentData <- commentData[- grep("<", commentData$Comment),]
commentData <- commentData[- grep("Joma Tech", commentData$User),]


# Only keep the first comments
commentData <- commentData[grep("FALSE", commentData$ReplyToAnotherUser),]

# Sentiment Analysis
commentData$sentimentQDAP <- analyzeSentiment(commentData$Comment)
commentData$Sentiment <- convertToDirection(commentData$sentimentQDAP)



# Attaching a sentiment value and the matching sentiment to each comment in the dataset.
commentData$sentimentQDAP <- NA
commentData$Sentiment <- NA
for(i in 1:nrow(commentData)){
  commentData[i, 10] <- analyzeSentiment(commentData[i, 1])
  commentData[i, 11] <- convertToDirection(commentData[i, 10])
}

write.csv(commentData, "commentData.csv", row.names = FALSE)


# List of video Ids
videoIds <- as.data.frame(video_final.df$ytVideoID)
videoIds <- unique(videoIds$`video_final.df$ytVideoID`)
videoIds <- as.data.frame(videoIds)
colnames(videoIds)[1] <- "videoId"

comments_all <- data.frame()
for(i in 1:nrow(videoIds)){
  videoId <- c(videoIds[i, 1])
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