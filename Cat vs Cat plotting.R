############ Cat vs Cat plot ############3



library(ggplot2)

p <- ggplot(mpg, 
            aes(x = class,
                fill = drv)) + 
    geom_bar(position = "stack") +
  theme_minimal()
p

# grouped bar plot
ggplot(mpg, 
       aes(x = class, 
           fill = drv)) + 
  geom_bar(position = "dodge")

# grouped bar plot preserving zero count bars
ggplot(mpg, 
       aes(x = class, 
           fill = drv)) + 
  geom_bar(position = position_dodge(preserve = "single"))

# bar plot, with each bar representing 100%
ggplot(mpg, 
       aes(x = class, 
           fill = drv)) + 
  geom_bar(position = "fill") +
  labs(y = "Proportion")


# bar plot, with each bar representing 100%, 
# reordered bars, and better labels and colors
library(scales)
ggplot(mpg, 
       aes(x = factor(class,
                      levels = c("2seater", "subcompact", 
                                 "compact", "midsize", 
                                 "minivan", "suv", "pickup")),
           fill = factor(drv, 
                         levels = c("f", "r", "4"),
                         labels = c("front-wheel", 
                                    "rear-wheel", 
                                    "4-wheel")))) + 
  geom_bar(position = "fill") +
  scale_y_continuous(breaks = seq(0, 1, .2), 
                     label = percent) +
  scale_fill_brewer(palette = "Set2") +
  labs(y = "Percent", 
       fill = "Drive Train",
       x = "Class",
       title = "Automobile Drive by Class") +
  theme_minimal()

# create a summary dataset
library(dplyr)
plotdata <- mpg %>%
  group_by(class, drv) %>%
  summarize(n = n()) %>% 
  mutate(pct = n/sum(n),
         lbl = scales::percent(pct))
plotdata


# create segmented bar chart
# adding labels to each segment

ggplot(plotdata, 
       aes(x = factor(class,
                      levels = c("2seater", "subcompact", 
                                 "compact", "midsize", 
                                 "minivan", "suv", "pickup")),
           y = pct,
           fill = factor(drv, 
                         levels = c("f", "r", "4"),
                         labels = c("front-wheel", 
                                    "rear-wheel", 
                                    "4-wheel")))) + 
  geom_bar(stat = "identity",
           position = "fill") +
  scale_y_continuous(breaks = seq(0, 1, .2), 
                     label = percent) +
  geom_text(aes(label = lbl), 
            size = 3, 
            position = position_stack(vjust = 0.5)) +
  scale_fill_brewer(palette = "Set2") +
  labs(y = "Percent", 
       fill = "Drive Train",
       x = "Class",
       title = "Automobile Drive by Class") +
  theme_minimal()


#new data
data(Salaries, package="carData")

# calculate mean salary for each rank
library(dplyr)
plotdata <- Salaries %>%
  group_by(rank) %>%
  summarize(mean_salary = mean(salary))

# plot mean salaries
ggplot(plotdata, 
       aes(x = rank, 
           y = mean_salary)) +
  geom_bar(stat = "identity")

# plot mean salaries in a more attractive fashion
library(scales)
ggplot(plotdata, 
       aes(x = factor(rank,
                      labels = c("Assistant\nProfessor",
                                 "Associate\nProfessor",
                                 "Full\nProfessor")), 
           y = mean_salary)) +
  geom_bar(stat = "identity", 
           fill = "cornflowerblue") +
  geom_text(aes(label = dollar(mean_salary)), 
            vjust = -0.25) +
  scale_y_continuous(breaks = seq(0, 130000, 20000), 
                     label = dollar) +
  labs(title = "Mean Salary by Rank", 
       subtitle = "9-month academic salary for 2008-2009",
       x = "",
       y = "")
     

