#Check the version
version

#Update if needed
update.packages()


#Install package
install.packages("RODBC")

#Use library
library(RODBC)

#List all your ODBC connections
odbcDataSources(type = c("all", "user", "system"))

#Create connection - Note if you leave uid and pwd blank it works with your existing Windows credentials
Local <- odbcConnect("Example", uid = "", pwd = "")

#Query a database (select statement)
Olympics <- sqlQuery(Local, "SELECT * FROM Olymics.dbo.Olympics")
Country <- sqlQuery(Local, "SELECT * FROM Olymics.dbo.Country")



#View data
View (Olympics)
View (Country)

#Check the structure of the data
class(Olympics)
str(Olympics)
str(Country)

#Change data type of Athlete
Olympics$Year <-  as.numeric(Olympics$Year)
Olympics$Athlete <- as.character(Olympics$Athlete)

as.numeric(Country$Population)
as.numeric(Country$GDP)

names(Olympics)[6]<-"Code"

#Quick summary to describe the data
dim(Olympics)
summary (Olympics)  
colnames(Olympics)

df<-merge(Olympics,Country,by = "Code",All = TRUE)











#Best practice - don't leave the connection open and ensures you get the latest data
odbcCloseAll()
