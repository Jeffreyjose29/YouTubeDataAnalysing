
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
video_final.df$ytYearMonth <- format(video_final.df$ytPublishedDate, "%Y-%m")

## Adding current datetime to channel dataframe
channel.df$CurrentDate <- Sys.Date()

## Plots
video_final.df %>%
  group_by(ytChannelName, ytYearMonth) %>%
  summarise(ytSumOfViews = sum(as.integer(ytViewsCount))) %>%
  ggplot(aes(x = ytYearMonth, y = ytSumOfViews, group = ytChannelName, colour = ytChannelName)) + geom_line(size = 0.5) + geom_point() +
  labs(x = "Year-Month", y = "Num. Views", title = "Number Of Viewers For Videos Released Each Year-Month") +
  scale_x_discrete(guide = guide_axis(angle = 90)) + labs(color = "YouTube Channel:") +
  theme_light() + scale_colour_manual(values = c(rgb(153, 3, 30, max = 255), 
                                             rgb(227, 100, 20, max = 255),
                                             rgb(15, 76, 92, max = 255)
  ))

## Top 10 videos with highest views
video_final.df %>%
  group_by(ytChannelName, ytTitle) %>%
  summarise(ytViewsCount = as.integer(ytViewsCount), ytLikesCount = as.integer(ytLikesCount), ytCommentCount = as.integer(ytCommentCount)) %>%
  arrange(desc(ytViewsCount)) %>%
  slice(1:15) %>%
  ggplot(aes(x = reorder(ytTitle, -ytViewsCount), y = ytViewsCount, group = ytChannelName, fill = ytChannelName)) + geom_bar(stat = "identity", colour = 'black') +
  scale_x_discrete(guide = guide_axis(angle = 90)) +
  labs(x = "Video Title", y = "Num. Views", title = "Top 15 Videos With The Highest Views", fill = "Channel Name:") + 
  theme_light() + scale_fill_manual(values = c(rgb(15, 76, 92, max = 255), 
                                               rgb(227, 100, 20, max = 255),
                                               rgb(153, 3, 30, max = 255)
  ))


# Write out the dataframe to .csv format
write.csv(video_final.df, "videoFinal.csv", row.names = FALSE)
write.csv(channel.df, "channelInfo.csv", row.names = FALSE)
