# 5 basic/atomic classes of objects in R

# Vectors
# numeric
num_vect <- c(0.5, 0.6, 3, 126)
class(num_vect)
length(num_vect)
dim(num_vect)
str(num_vect)

# integer
int_vect <- c(9:29,102,200:190) # this is numeric
class(int_vect)
int_vect <- c(9L:29L,102L,200L:190L) # adding L will make it integer vector
int_vect <- c(int_vect,1.5) # no longer integer, will be coerced to numeric

# complex
x <- c(1+0i, 2+4i)

# logical
logic_vect <- c(TRUE, FALSE, F, F, T)
class(logic_vect)

# character
char_vect <- c("a", "b", "c", 5, TRUE) # all elemnets will be coerced to character
str(char_vect)

# Empty vector definitions
vector() # empty vector, with length of 0
a <- vector(mode = "numeric", length = 5)
numeric(length=5)
identical(a, numeric(5))
vector("character", 5)
character(5)

# Lists, can store different types of classes within the same list
list_example <- list(1, c("a","b","c","d"), gold=c(TRUE,F,F,T,F), 1 + 4i)
str(list_example)
names(list_example)

# matrices
m <- matrix(1:6, nrow = 2, ncol = 3) # fills up the matrix by columns and not by rows!
m
str(m)
length(m) # returns number of elements in the matrix
dim(m)
nrow(m)
ncol(m)

# data frames = dataset
df <- data.frame(foo = 1:4, bar = c(T, T, F, F), c(5,2)) # no warning or error, R fills up the last column, no missing values for 3rd and 4th line
df
nrow(df)
ncol(df)
str(df)
attributes(df)
names(df)
length(df) # return number of columns

df <- data.frame(foo = 1:4, bar = c(T, T, F, F), c(5,2,3)) # gives an error due to last column


# Explicit coercion as. functions example
as.numeric(logic_vect)
as.numeric(char_vect) # Nonsensical coercion results in NAs
as.character(num_vect)
as.logical(num_vect)
as.logical(c(0,-1,0.4,NA))


# NaN - not a number, NA, NULL
x <- c(1, 2, NA, 10, 3)
is.na(x)
is.nan(x)
is.null(x)

x <- c(1, 2, NaN, NA, 4)
is.na(x)
is.nan(x)
is.null(x)

x <- NULL
is.na(x)
is.nan(x)
is.null(x)

x <- c(NA,"a",NA, "f","NA","", NULL, NA) # NULL is nothing
x
is.na(x)
is.nan(x)
is.null(x)
x==""
 
# NaN example
log10(-1)


# dplyr package
library(dplyr)
library(datasets) # Contains various datasets to play with 

# Subsetting

# Base R
# Vector
int_vect
int_vect[1]
int_vect[4:6]
int_vect[6:4]
int_vect[c(10:8,1,5,1)]
int_vect[-5]
int_vect[-c(10, 1:3, length(int_vect))]
int_vect[int_vect>5]

x
x[x>"b"] # NA elements will return as well!
x[x<"b"] # NA elements will return as well!
x[x=="b"] # NA elements will return as well!
good <- x>"b"
good
x[good]
x[c(T,T,F,F,T)]
x[c(T,T,F)]

# Matrix
m
m[2,3]
m[2]
m[1,]
m[,2:3]
m[m[,1]==2,]

# List
list_example
list_example[2] # returns a list
list_example[c(2,3)] # returns a list
list_example[[2]] # returns a vector
list_example[[2:3]] # returns the 3rd element of the 2nd list
list_example[[2]][3] # returns the 3rd element of the 2nd list
list_example$gold # returns a vector
list_example[["gold"]][3] # returns a vector
list_example$gold[1:3] # returns a vector

# Data frame
df
df[,2] #returns a vector
df[,c(1,2)] # returns a dataframe
df$bar #returns a vector
df[1,] # returns a data frame
df[c(4:1,1),]
df["foo"] # returns a data frame
# Below 4 lines results in the same outcome
df[df[,1]<3,]$bar
df[df$foo<3,]$bar
df[df$foo<3,2]
df[df[,1]<3,2]

# mtcars examples
?mtcars # pulling up description of the dataset from R help
str(mtcars)
head(mtcars,n=10) # first 10 rows printed on the console
tail(mtcars) # last x rows printed on the console

# Filtering rows
# base R 1
mtcars[mtcars$cyl==4 & mtcars$hp>100,]
mtcars[mtcars[,2]==4 & mtcars$hp>100,]
mtcars[mtcars[,2]==4 & mtcars["hp"]>100,]
# base R 2
subset(mtcars, cyl==4 | hp>200)

df1 <- data.frame(col1=c(5,10,77,1,NA,12,99,NA),col2=c("a","c","H",NA,"Y","z","T","m"))
df1[df1$col1<=10,] # NAs will return! but col2 will be NAs on those rows as well!
subset(x = df1, subset = col1<=10) # NAs will not return!
# dplyr
filter(mtcars, cyl==4 & hp>100)
filter(mtcars, cyl==4, hp>100) # this is the same as above, i.e., it is interpreted as &
filter(mtcars, hp %in% c(110, 150)) # example for 'in' operator in R
filter(df1, col1<=10) # NAs will not return!

# Selecting columns
# base R 1
mtcars[,c(11,1:5,11)]
mtcars[,"hp"] # returns a vector, in many cases R tries to "simplify" the outcome object's class
mtcars["hp"] # returns a data frame
mtcars[,c("hp","mpg")] # returns a data frame
mtcars[c("hp","mpg")] # returns a data frame
# base R 2
subset(mtcars, select=c(hp, mpg, disp))
subset(mtcars, select=-c(hp, mpg, disp))
subset(mtcars, select=-(hp:qsec))
subset(mtcars, select=qsec:hp)
subset(mtcars, cyl==4 | hp>200, c(1:5))
subset(x= mtcars, subset= cyl==4 | hp>200, select= c(1:5))
subset(mtcars, select=hp) # returns a data frame
# dplyr
select(mtcars,c(11,1:5))
select(mtcars,mpg,hp,cyl)
select(mtcars,mpg:wt)
select(mtcars,c(mpg:wt,carb))
select(mtcars,mpg:wt,carb)
select(mtcars,mpg:wt,-hp)
select(mtcars,mpg,mpg,hp) # select does not allow for the same column to be selected multiple times. It is selected only once.
select(mtcars,mpg:wt,hp) # another example for above
select(mtcars,-(8:11))

# Rename a column/variable
# base R
df
names(df)
names(df)[3] <- "V3"
df
names(df)[1:2] <- c("V1","V2")
df
# dplyr
df <- rename(df,W1=V1,W3=V3,W2=V2)
df

# New variable or change existing variable
# base R 1
df$new1 <- df$W1+100
df
# base R 2
new2 <- c(1:2)
df <- cbind(df,new2) # R fills up 
df <- cbind(df,new2) # R has no problem having columns with the same name. Be careful!
df
df$W2 <- !df$W2 # ! is the negation character in R
df$W1 <- !df$W1 # ! coercing the numeric to logical
df[1:2,2] <- c(F,NA) # change a subset of a column
cbind(mtcars,new99=row.names(mtcars),new101=mtcars$cyl+100)
# dplyr
df <- mutate(df, new3=new1-50, new4=new3-50) # Now here R cries due to new2 twice
names(df)[length(df)] <- "new2.1"
df <- mutate(df, new3=new1-50, new4=new3-50, W1=W1+100)
df
row.names(mtcars)
dimnames(mtcars)
mtcars <- mutate(mtcars, car=row.names(mtcars))

# Sorting
# base R 1
x <- c(5,99,NA,55,2,33,56,34,NA,88)
sort(x) # returns the sorted vector. Sort can sort vectors only, by default NAs are removed.
sort(x, na.last=TRUE) # NAs at the end
sort(x, na.last=FALSE) # NAs at the beginning
sort(x, na.last=NA, decreasing = TRUE) # NAs are removed, decreasing order
sort(mtcars$hp)
sort(c(mtcars$hp,mtcars$cyl)) # concatenates the 2 vectors and then sort them as one vector
# base R 2
ord <- order(x) # returns an integer vector that tells in which order the elements have to be selected to have the R object sorted
class(ord)
x[ord]
airq <- head(airquality, n=20)
order(airq$Ozone, airq$Temp) # default is NAs at the end, it can order by multiple variables
airq[order(airq$Ozone, airq$Temp),]
airq[order(airq$Ozone, airq$Solar.R),]
airq[order(airq$Temp, -airq$Ozone),]
airq[order(airq$Temp, -airq$Ozone, na.last=F),]
airq[order(airq$Temp, airq$Ozone, na.last=NA, decreasing = c(FALSE, TRUE)),]
# dplyr
arrange(airq, Ozone, Temp) # can be used on any type of data frames only. NAs are always sorted at the end.
arrange(airq, Ozone, airq[,2])
arrange(airq, Temp, -Ozone)
arrange(airq, desc(Ozone), Temp)

# Summarizing data
# base R
summary(mtcars)
summary(df1)
mtcars2 <- mtcars
mtcars2$vs <- as.factor(mtcars2$vs)
mtcars2 <- mutate(mtcars2, car2=as.factor(substr(car,1,1)))
summary(mtcars2)
summary(mtcars2$hp)
summary(mtcars2[13:10])

quantile(mtcars$hp)
quantile(mtcars$hp, probs = c(0, 0.2, 0.4, 0.6, 0.8, 1))
quantile(mtcars$hp, probs = seq(from=0, to=1, by=0.1))

summary(airq)
mean(airq$Ozone) # NA is returned if there is any in the data
mean(airq$Ozone, na.rm=T)
quantile(airq$Ozone) # error message due to NA/NaN values
quantile(airq$Ozone, na.rm=TRUE) # na.rm=T needs to be set if NAs are not removed from the data upfront

# dplyr
# summarize and summarise are the same
summarize(mtcars, mean_hp=mean(hp), freq=n(), freq_uni=n_distinct(cyl), range_hp=max(hp)-min(hp))
summarise(airq, min=min(Solar.R, na.rm=T), Q1=quantile(Solar.R, probs=0.25, na.rm=T),
                median=median(Solar.R, na.rm=T), mean=mean(Solar.R, na.rm=T),
				Q3=quantile(Solar.R, probs=0.75, na.rm=T), max=max(Solar.R, na.rm=T),
				na_freq=sum(is.na(Solar.R)), non_na_freq=sum(!is.na(Solar.R))
		 )


# Grouping data and then summarize
# dplyr
mtcars_gr <- group_by(mtcars,vs,cyl)
str(mtcars)
str(mtcars_gr)
summarize(mtcars, mean_hp=mean(hp), freq=n(), freq_uni=n_distinct(cyl), min_hp=min(hp), max_hp=max(hp), range_hp=max(hp)-min(hp))
summarize(mtcars_gr, mean_hp=mean(hp), freq=n(), freq_uni=n_distinct(cyl), min_hp=min(hp), max_hp=max(hp), range_hp=max(hp)-min(hp))

# chaining %>% in dplyr to substitute deeply nested and hard to read code
summarize(group_by(mutate(select(filter(mtcars,hp>100),vs,mpg,hp,car),car2=substr(car,1,1)),vs,car2),mean_mpg=mean(mpg), mean_hp=mean(hp), freq=n())

mtcars %>% filter(hp>100) %>%
           select(vs,mpg,hp,car) %>%
		   mutate(car2=substr(car,1,1)) %>%
		   group_by(vs,car2) %>%
           summarize(mean_mpg=mean(mpg), mean_hp=mean(hp), freq=n())

# Merging, joining datasets
df1 <- data.frame(v1=c(1:9,NA), v2=c(50,60,33,20,NA,89,10,100,46,NA), 
                  v3=c("A","B","C","D","E",NA,"G","H","I","J"),
                  var5=c(1001:1010))
df2 <- data.frame(v1=c(1,1,2,NA,2,10,3,4,5,9,6,10,3,4,11),
                  v2=c(55,50,60,NA,NA,86,33,20,100,57,34,23,46,20,11),
                  v3=c("Y","A","Z","W",NA,"U","H","X","L","V",NA,"X","M","Z","K"),
                  v4=c(101:115))
df3 <- data.frame(v1=c(1), v99="T")

# base R
# default key is intersect of the variables of the 2 datasets, if not specified otherwise
# default is inner join, i.e. records with matching keys are kept only from both datasets
df4 <- merge(df1,df2) 
intersect(names(df1),names(df2))
df4 <- merge(df1, df2, by=c("v1","v2")) # default suffixes added if there are variables with the same name
df4 <- merge(df1, df2, by=c("v1","v2"), suffixes = c("_df1", "_df2")) # suffixes only used for variables with the same name
df4 <- merge(df1, df2, by.x="v1", by.y="v1")
df4 <- merge(df1, df2, by.x="v1", by.y="v1", all=FALSE) # inner join, default
df4 <- merge(df1, df2, by.x="v1", by.y="v1", all=TRUE) # full join
df4 <- merge(df1, df2, by.x="v1", by.y="v1", all.x=TRUE) # left join
df4 <- merge(df1, df2, by.x="v1", by.y="v1", all.y=TRUE) # right join
df4 <- merge(df1, df2, by=NULL) # Cartesian product
# list of key values which will be ignored while looking for matching key values
# incomparable works only on one column keys
df4 <- merge(df1, df2, by="v1", incomparables=c(NA,1))
df4 <- merge(df1, df2, by="v3")
df4 <- merge(df1, df2, by.x="v3", by.y="v3", incomparables=c("A",NA))

df4 <- merge(merge(df1, df2, by="v1"), df3, by="v1")

# plyr package
# If dplyr is used in the same R session as well then dplyr needs to be loaded first!
# Otherwise group_by will not work! Instead of by group results in summarize, overall results will return.
# If plyr was loaded first then a new session needs to be started to make dplyr work again as expected
# I would not use it, due to limited options and some unexpected features
library(plyr)
join(df1, df2) # default is left join on common variables, if key is not defined
join(df1, df2, by=c("v1", "v2")) # key variable names need to match, does not bother variables with the same name
join(df1, df2, by="v1", type="inner")
join(df1, df2, by="v1", type="left")
join(df1, df2, by="v1", type="right")
# Unexpected feature
# Full join eliminates columns with the same name from the "y" dataset on the rows from "x" dataset
join(df1, df2, by="v1", type="full")
join(df1, df2, by="v1", type="left", match="all")
join(df1, df2, by="v1", type="left", match="first")
join(df1, df2, by="v1", type="right", match="first") # error
join(df1, df2, by="v1", type="inner", match="first") # error
join(df1, df2, by="v1", type="full", match="first") # to me it does not much make sense what returns
    
# Smart solution for lookup tables with one numeric value key
# It usability is very limited but I think it's very smart
a <- data.frame(id=c(1,2,3), value=c("walk","sleep","run"))
b <- data.frame(subj=1:11, id=c(1,2,3,2,3,NA,1,2,3,1,99))
b$new <- a[b$id, 2]
b$new <- a[b$id,]$value


# Factors
table(mtcars2$car2)
unclass(mtcars2$car2) # Shows the corresponding numeric values and levels of the factor variable
mtcars2$car2=factor(mtcars2$car2, levels = sort(attributes(mtcars2$car2)$levels, decreasing = T)) # Levels argument defines the order of categories
unclass(mtcars2$car2)
help1 <- table(mtcars2$car2)
help2 <- names(help1)[order(-help1)]
mtcars2 <- mutate(mtcars2, car3=factor(substr(car,1,1), levels=help2))
test_csv <- mutate(test_csv, daytype=factor(weekdays(EXDT),
                               levels = c("Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday"),
                               labels = c("weekday", "weekday", "weekday", "weekday", "weekday", "weekend", "weekend")),
							 day=weekdays(EXDT)
							 
				  )
test_csv <- mutate(test_csv, daytype=factor(weekdays(EXDT),
                               levels = c("Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"),
                               labels = c("weekend","weekday", "weekday", "weekday", "weekday", "weekday", "weekend")),
							 day=weekdays(EXDT)
							 
				  )


# Dates
# Base R
# Date class for dates, starting point is 1970-01-01 which is equals to 0
origo_day <- as.Date("1970-01-01") 
class(origo_day)
as.numeric(origo_day) # Counting starts with 0
unclass(origo_day)
as.Date(0, origin="1970-01-01") # only accepts numeric input if origin is given
as.Date(366, origin="1960-01-01") # if dates are imported into R from other platforms as numeric data e.g., SAS or excel
?as.Date
as.Date("1969-12-31") # R can process this properly by default
as.Date("1970/01/02") # R can process this properly by default
as.Date("22-08-2001") # R "manages" to convert but the outcome is wrong
as.Date(x = "22-08-2001", format = "%d-%m-%Y") # strongly advised to pass on the format argument as well
as.Date("02/29/04", "%m/%d/%y")
as.Date("22-08-2001", "%m-%d-%Y") # R by default returns NA if it cannot apply the provided format, no error or warning
as.Date("27dec1985")
as.Date("27dec1985", optional=F) # error message will be returned, this is the default
as.Date("27dec1985", optional=T) # NA will be returned, no error or warning
as.Date("27dec1985","%d%b%Y")

date() # system datetime as character
Sys.time() # system datetime as character
Sys.Date() # system date as character

weekdays(origo_day)
weekdays(as.Date(Sys.Date()), abbreviate=T)

months(origo_day)
months(origo_day, abbreviate=T)

quarters(origo_day+180)


# Datetimes

# For datetime variables (POSIX classes) OS locale settings matter a lot in R
Sys.getlocale()
Sys.getlocale("LC_TIME")

# POSIXct: numeric datetime. Counting seconds from 1970-01-01
ct <- as.POSIXct(Sys.time())
class(ct)
unclass(ct)
unclass(as.POSIXct("1970-01-01 00:00:00", tz="GMT"))
as.numeric(as.POSIXct("1970-01-01 00:00:01", tz="GMT"))
unclass(as.POSIXct("1970-01-01 00:00:00", tz="Europe/Budapest"))
unclass(as.POSIXct("1970-01-01 00:00:00", tz="CET"))
weekdays(ct)
months(ct)

# POSIXlt: stores detailed information in a list
lt <-as.POSIXlt("2020-06-21 07:53:44")
weekdays(lt)
months(lt, abbreviate = TRUE)
quarters(lt)

unclass(lt)
names(unclass(lt))
summary(unclass(lt))

# Referencing list elements of POSIXlt datetimes
lt$sec
lt$mon # keep in mind January = 0 to December = 11!
lt$mon+1
lt$year # keep in mind it's the number of years since 1900!
lt$year+1900
lt$wday # keep in mind Sunday=0 to Saturday=6!
?DateTimeClasses # you can look up here the value lists of the elements

?strptime # you can check abbreviations for %Y, %y, etc.
# If locale has non-English date/time settings, below will not work properly and
# will return NA if R cannot do the conversion. R/POSIX expects input data
# according to local settings!!!
dates_vect1 <- c("January 10, 2012 10:40", "December 9, 2011 9:10")
lt_vect <- as.POSIXct(strptime(dates_vect1, "%B %d, %Y %H:%M")) # in Hungary 1st fails, 2nd converts
lt_vect <- strptime(dates_vect1, "%B %d, %Y %H:%M")
lt_vect$sec
lt_vect$year+1900
class(lt_vect)

# Work around, if you do not want to change system setting
lct <- Sys.getlocale("LC_TIME") # store system locale into a variable
Sys.setlocale("LC_TIME", "C") # set it to "C" "which is the default for the C language and reflects North-American usage � also known as "POSIX"" from R help ?locales
dates_vect2 <- c("1jan1960", "2jan1960", "31mar1960", "30jul1960")
strptime(dates_vect2, "%d%b%Y")
format(strptime(dates_vect2, "%d%b%Y"),"%Y/%m/%d")
Sys.setlocale("LC_TIME", lct) # set locale back to system setting

Sys.time()
format(Sys.time(), "%a %b %d %X %Y %Z")

# operations on date/times
x <- as.Date("2012-01-01")
y <- strptime("9 Jan 2011 11:34:21", "%d %b %Y %H:%M:%S")
x-y # will not work
x <- as.POSIXlt(x)
x-y

x <- as.Date("2012-03-01"); y <- as.Date("2012-02-28")
x-y

Sys.timezone()
x <- as.POSIXct("2012-10-25 01:00:00") # if not defined then time zone is taken from OS
y <- as.POSIXlt("2012-10-25 06:00:00", tz = "GMT") # GMT has no daylight saving time! GMT is GMT all year around
unclass(y)
y-x

# List of time zones https://en.wikipedia.org/wiki/List_of_tz_database_time_zones
y <- as.POSIXlt("2012-10-25 06:00:00", tz = "Europe/London")
unclass(y)
y-x
as.numeric(y-x)

difftime(Sys.time(), y, units = "days")
difftime(as.Date("2012-10-31"), y, units = "days") # can handle different "date classes"
difftime(as.Date("2012-02-29"), strptime("9 Jan 2012 11:34:21", "%d %b %Y %H:%M:%S"), units = "weeks")
difftime(x, y, units = "hours")

dates_vect3 <- as.Date(c("1984-12-31", "2012-11-03", "2020-01-04", "1999-06-26"))
as.Date("2000-01-01") < dates_vect3
lt_vect
as.POSIXlt("2012-01-10 10:40") == lt_vect
as.POSIXlt("2012-01-10 10:40") <= lt_vect

# Importing SAS data formats containing dates
library(SASxport)
library(sas7bdat)

test_xpt <- read.xport("C:/Adatok/prog/stuff/test1.xpt")
str(test_xpt)
names(test_xpt)
class(test_xpt$EXDTC)
label(test_xpt) # retrieve the labels of the columns
SASformat(test_xpt) # retrieve SAS formats on the data
sum(is.na(test_xpt$EXDTC))
test_xpt[test_xpt$EXDTC=="",]

test_sas7bdat <- read.sas7bdat("C:/Adatok/prog/stuff/test1.sas7bdat", debug=FALSE)
str(test_sas7bdat)
test_sas7bdat$EXDT_new <- as.Date(test_sas7bdat$EXDT, origin = "1960-01-01")
test_sas7bdat$EXDTM_new <- as.POSIXct(test_sas7bdat$EXDTM, tz="GMT", origin = "1960-01-01 00:00:00")
test_sas7bdat$EXDTM_wrong <- as.POSIXct(test_sas7bdat$EXDTM, origin = "1960-01-01 00:00:00")

test_csv <- read.csv("C:/Adatok/prog/stuff/test1.csv")
test_csv <- read.csv("C:/Adatok/prog/stuff/test1.csv", na.strings = "")
str(test_csv)
test_csv <- mutate(test_csv,EXDT=as.Date(EXDT,"%d%b%Y"),
                   EXDTM=as.POSIXct(EXDTM,format="%d%b%Y:%H:%M:%S"))

# lubridate package
# This package is only guaranteed to work with an "en_US.UTF-8" locale
library(lubridate)
help(package = lubridate) # Pull up documentation in R help

this_day <- today()
year(this_day)
month(this_day)
day(this_day)
wday(this_day) # returns numeric, Sun=1, Mon=2, etc.
wday(this_day, label = TRUE) # returns with abbreviated name of the day according to locale
wday(this_day, label = TRUE, locale = "C")

this_moment <- now(tzone="America/New_York")
hour(this_moment)
minute(this_moment)
second(this_moment)

my_date <- ymd("1989-05-17")
class(my_date)
ymd("1989 May 17") # no idea how this can work on Hungarian time...
mdy("March 12, 1975") # no idea how the return value is computed on Hungarian time...
mdy("March 12, 1975", locale = "C")
mdy("08/04/2013")
dmy(25081985)
ymd("192012") # this will return NA with warning
ymd("1920-1-2")
ymd("19200102")
ymd(19200102)

dt1 <- "2014-08-23 17:23:02"
ymd_hms(dt1)

hms("03:22:14")

dt2 <- c("2014-05-14", "2014-09-22", "2014-07-11")
ymd(dt2)

update(this_moment, hours = 8, minutes = 34, seconds = 55)
this_moment <- update(this_moment, hours = 8, minutes = 34, seconds = 55)

ymd(dt2)+days(2)
ymd(dt2)+weeks(2)
class(weeks(2))
unclass(weeks(2))
ymd(dt2)-months(6)
ymd(dt2)-period(6, "months")
ymd(dt2)+period(num = c(2, 6), units = c("years", "months"))

with_tz(now(), tzone="Europe/London")
with_tz(now(), tzone="America/Los_Angeles")
with_tz(now(), tzone="America/New_York")

as.period(interval(start = ymd("2012-10-31"), end = mdy("08/04/2013")))
as.period(interval(start = ymd("2012-10-31"), end = mdy("08/04/2013")), unit="days")
a <- as.period(interval(ymd("2012-02-29"), dmy_hms("9 Jan 2012 11:34:21")), unit="days")
unclass(a)
a$day/7
x <- c(ymd_hms("2016-02-01 00:05:15", tz = "Europe/Budapest"), ymd_hms("2018-02-01 00:05:15", tz = "Europe/London"))
y <- ymd_hms(c("2016-03-01 01:05:55", "2021-02-18 10:50:11"), tz = "America/New_York")
interval(x, y)
interval(x, y, tzone = "America/New_York")
as.period(interval(x, y, tzone = "America/New_York"))
as.period(interval(x, y))
as.period(interval(x, y), unit="days")



# SWIRL - interactive learning/practicing
# https://swirlstats.com/
install.packages("swirl")
packageVersion("swirl")
library(swirl)
install_from_swirl("R Programming")