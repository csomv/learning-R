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


# dates
# merge/join/okos megoldás/cbind
# apply functions
# regular expressions
# table function
# proportion calc with mean function and logical vector, each column
# functions
# own defined operators
# SWIRL