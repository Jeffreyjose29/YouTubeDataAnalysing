# YouTube Data Analysis
![YouTube Logo](https://static.vecteezy.com/system/resources/previews/003/206/623/original/youtube-editorial-app-icon-free-vector.jpg)

**Aim:** The aim of this project is to dwell into the statistics of any given YouTube channel and identify important stats such as viewership growth, key video titles which drive views and other key information.  

The project is completed using R as the primary language and RStudio as the IDE of choice. 

## Channel In Focus

The channel used throughout this project is called **Joma Tech**. 

![img](https://i.ytimg.com/vi/0oBi8OmjLIg/maxresdefault.jpg)

Joma Tech is an educational and parody channel with the main focus centering around the field of computer science and software engineering 🖥️. Joma first created his channel back in August 31st 2016 and has uploaded 102 videos and amassed 145,736,829 views at the time of writing (7th September 2022). 

He is currently based in the United States of America. 🇺🇸

*Check out Joma Tech's Channel:* https://www.youtube.com/c/JomaOppa/featured  

*Joma Tech Social Blade:* https://socialblade.com/youtube/channel/UCV0qA-eDDICsRR9rPcnG7tw

## Data Sources

A large majority of the data used within this project is web-scraped using the Google YouTube API pass which allows an user to scrap the latest data on any social channel through the script itself.  

**There are 3 steps in order to scrap YouTube data:**

1. Get your YouTube API key for free.
2. Sample YouTube Data API calls.
3. Sample Code in R. 

## Step 1: Get a YouTube API Key 

YouTube shares information through their product, the <a href = "https://developers.google.com/youtube/v3/"><i>YouTube Data API</i></a>.

The YouTube Data API is part of the Google Cloud Platform and it is essential that in order to legally extract data from YouTube, you would be required to sign-up for a **Google Cloud Account**, using your **Google Account**.

*Link to creating your YouTube API*: https://console.cloud.google.com/apis/api/youtube.googleapis.com/metrics?project=digiinnovations-214009  

## Step 2: Install R

R is a tool for data science, visualization, automating data processes and many other data operations. 

Installers for Windows, Mac and Linux can be installed from their <a href = "https://cran.r-project.org/mirrors.html">official site</a>.

### Packages: httr, jsonlite and dplyr packages

Once you have installed R, you need to install 3 additional packages: `httr`, `jsonlite`, and `dplyr`.   

The `httr` package allows us to communicate with the API and get the raw data from YouTube in JSON format.

Afterwards, the `jsonlite` package takes this raw data and transforms it into a readable format.

The `dplyr` is an all-around package for manipulating data in R.

Live streaming videos do not count views. In some videos, comments are disabled. Since videos in YouTube can have different properties, some results are not consistent with the others.

Instead of `rbind`, we can use `bind_rows` in `dplyr` to handle binding data with mismatched columns.  

## Step 3: Source Code To Extract Video Information  

Below is a step process into extracting YouTube data in R.  
YouTube data can be categorized by emphasizing either the **channel id** or the **user id**.  

Follow the documented step in <a href = "https://github.com/Jeffreyjose29/YouTubeDataAnalysing/blob/main/R%20Script/01%20Gathering%20Data.R">01_Extracting_Data.R</a> for sample code.

## Informational Reading Material

**Title:** Sentiment Analysis on YouTube Comments to Predict YouTube Video Like Proportions  
**Author:** Isac Lorentz & Gurjwan Singh  
**Link:** http://www.diva-portal.org/smash/get/diva2:1593439/FULLTEXT01.pdf 







