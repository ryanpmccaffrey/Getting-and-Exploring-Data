# Need to install httr, httpuv and jsonlite packages

library(httr)
library(httpuv)

# 1. Find OAuth settings for github:
#    http://developer.github.com/v3/oauth/
oauth_endpoints("github")

# 2. Register an application at https://github.com/settings/applications
#    Insert your values below - if secret is omitted, it will look it up in
#    the GITHUB_CONSUMER_SECRET environmental variable.
#
#    Use http://localhost:1410 as the callback url
myapp <- oauth_app("Github API", "d45a1e9832703318b6bb","3bf4a2ce45fafcf4c08181b89950e6e74928ce56")

# 3. Get OAuth credentials
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)

# 4. Use API
req <- GET("https://api.github.com/users/jtleek/repos", config(token = github_token))
stop_for_status(req)
content(req)

library(jsonlite)
json1 = content(req)
json2 = jsonlite::fromJSON(toJSON(json1))
repo <- json2[4,]
names(repo)
print (repo$created_at)

# Need to install sqldf package
install.packages("sqldf")
library("sqldf")

acs <- read.csv("/Users/ryanmccaffrey/Documents/Getting and Exploring Data/getdata-data-ss06pid.csv")

# Problem 4

connection <- url("http://biostat.jhsph.edu/~jleek/contact.html")
htmlCode <- readLines(connection)
close(connection)
nchar(htmlCode[10])
