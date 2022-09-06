
## Section 2: Reformatting video_final.df dataframe
##############################################################

video_final.df <- video_final.df %>%
  select(contentDetails.videoId, snippet.publishedAt, snippet.channelId, snippet.title, snippet.channelTitle,
         snippet.position, status.privacyStatus, contentDetails.duration,
         contentDetails.caption, statistics.viewCount, statistics.likeCount, statistics.favoriteCount,
         statistics.commentCount) %>%
  rename(ytVideoID = contentDetails.videoId, ytPublishedDateTime = snippet.publishedAt, ytChannelID = snippet.channelId,
         ytTitle = snippet.title, ytChannelName = snippet.channelTitle, ytPosition = snippet.position, 
         ytPrivacyStatus = status.privacyStatus, ytDuration = contentDetails.duration, ytCaptionsProvided = contentDetails.caption,
         ytViewsCount = statistics.viewCount, ytLikesCount = statistics.likeCount, ytFavouriteCount = statistics.favoriteCount,
         ytCommentCount = statistics.commentCount)


## Format each column:
video_final.df$ytCaptionsProvided <- str_to_title(video_final.df$ytCaptionsProvided)
video_final.df$ytPrivacyStatus <- str_to_title(video_final.df$ytPrivacyStatus)
video_final.df$ytPublishedDate <- as.Date(video_final.df$ytPublishedDateTime)
video_final.df$ytPublishedDateTime <- gsub("T", " ", video_final.df$ytPublishedDateTime, fixed=TRUE)
video_final.df$ytPublishedDateTime <- gsub("Z","",as.character(video_final.df$ytPublishedDateTime))
video_final.df$ytPublishedTime <- format(as.POSIXct(video_final.df$ytPublishedDateTime), format = '%H:%M:%S')
