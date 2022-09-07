devtools::install_github("vosonlab/SocialMediaLab/SocialMediaLab")
library(SocialMediaLab)

Authorize <- AuthenticateWithYoutubeAPI(key)

videoId <- c("-UdWguw90g4")
commentData <- CollectDataYoutube(videoIDs = videoId, apiKeyYoutube = key, writeToFile = FALSE)
