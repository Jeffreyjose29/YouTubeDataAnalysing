# devtools::install_github("vosonlab/SocialMediaLab/SocialMediaLab")

Authorize <- AuthenticateWithYoutubeAPI(key)

videoId <- c("-UdWguw90g4")
commentData <- CollectDataYoutube(videoIDs = videoId, apiKeyYoutube = key, writeToFile = FALSE)

# Attaching a sentiment value and the matching sentiment to each comment in the dataset.
commentData$sentimentQDAP <- NA
commentData$Sentiment <- NA
for(i in 1:nrow(commentData)){
  commentData[i, 10] <- analyzeSentiment(commentData[i, 1])
  commentData[i, 11] <- convertToDirection(commentData[i, 10])
}
