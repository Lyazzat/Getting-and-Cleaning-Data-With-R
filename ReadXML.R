install.packages("XML")
library (XML)
fileURL <-"http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"  #Reading XML off the Internet
#if your linksis secure - https, then remove "s" at the end of the http and you will be able to read the file 
#directly from the internet. 
#Now we are parsing the xml file. useInteralNodes equal to True means yes, use all columns
xmlFile <-xmlTreeParse(fileURL, useInternalNodes = TRUE)
rootNode<-xmlRoot(xmlFile)
xmlName(rootNode)
xmltop = xmlRoot(xmlFile)  
rootNode[[1]][[2]]

#Q4. How many restaurants have zipcode 21231?
sum(xpathSApply(rootNode, "//zipcode", xmlValue) == "21231")


#xmlSApply(rootNode, xmlValue)  # this will give you all the elements of the rootnode of the entire document
#To extract more specific use this function:
#xpathSApply(rootNode, "//zipcode", xmlValue) 
 
# ####Method 2. Downloading Data
# getwd()
# setwd("C:/Users/Lilu/Documents/IoE/HomeWork/R")
# getwd()
# # if (!file.exists(("data")) {
# #   dir.create("data")
# # }
# 
# download.file(fileURL, destfile = "BaltimoreRest.xml")
# #List what is in the current work.directory
# list.files()
# xmlFile <-xmlTreeParse("BaltimoreRest.xml", useInternalNodes = TRUE)


