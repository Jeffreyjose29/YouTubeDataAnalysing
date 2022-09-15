# devtools::install_github("vosonlab/SocialMediaLab/SocialMediaLab")

Authorize <- AuthenticateWithYoutubeAPI(key)

videoId <- c("-UdWguw90g4")
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