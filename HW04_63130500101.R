library(dplyr)
library(readr)
library(assertive)
library(stringr)
library(tidyr)
library(ggplot2)
library(forcats)


books <- read_csv("https://raw.githubusercontent.com/safesit23/INT214-Statistics/main/datasets/prog_book.csv")
View(books)
glimpse(books)

#1
book_price_plot <- books %>% mutate(Type = fct_lump(Type,n=4)) %>% count(Type,sort = T)


#2
book_rt_plot <- books %>% mutate(Type = fct_lump(Type,n=5)) %>%  group_by(Type) %>%
  summarise(mean = mean(Rating, na.rm = TRUE))


#3
books %>% mutate(Type = fct_lump(Type,n=6)) %>%  group_by(Type) %>%
  summarise(mean = mean(Price, na.rm = TRUE))


#4
books %>% select(Book_title,Number_Of_Pages,Price,Rating) %>% filter(Rating > 4.50)

#5
books %>% filter(Rating < mean(Rating, na.rm = TRUE)) %>% group_by(Type) %>% count()

#6
books %>% filter(Reviews < 200 & Rating > 4.00 ) %>% group_by(Type) %>% count()


#graph1
book_price_plot <- book_price_plot %>% ggplot(aes(x = fct_infreq(Type),y = n)) + geom_bar(stat="identity", fill="#f68060", alpha=.6, width=.4) +
  coord_flip() + theme_bw()

book_price_plot + ggtitle("Price Average of Type Book") + xlab("Type") + ylab("Price average")

#graph2
book_rt_plot <- book_rt_plot %>% ggplot(aes(x = Type,y = mean)) + geom_point(aes(color=Type)) 

book_rt_plot + ggtitle("Rating Average of Type Book") +
  xlab("Type") + ylab("Rating average")

