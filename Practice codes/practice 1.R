#########   Practice-1: Data Visualization  ###########


#What happens when you put the geom_smooth() function before geom_point() 
#instead of after it? What does this tell you about how the plot is drawn? 
#Think about how this might be useful when drawing plots.

#Load library
library(tidyverse)
library(socviz)
library(gapminder)

#load library for data
library(gapminder)

#load the data
gapminder

#first, correct version
p <- ggplot(data = gapminder,
           mapping = aes(x = gdpPercap,
                         y = lifeExp))
p + geom_point(mapping = aes(color = continent)) +
  geom_smooth(method = "loess") + 
  scale_x_log10()

#false version
p + geom_smooth(method = "loess") + 
    geom_point(mapping = aes(color = continent)) +
    scale_x_log10()

#It is seen that when we put geom_point after geom_smooth, it plots the line 
#at first, then plot all points. 


#Change the mappings in the aes() function so that you plot Life Expectancy 
#against population (pop) rather than per capita GDP. What does that look like? 
#What does it tell you about the unit of observation in the dataset?

p <- ggplot(data = gapminder,
            mapping = aes(x = pop,
                          y = lifeExp,
                          color = continent,
                          fill = continent))
p + geom_point() +
  geom_smooth(method = "loess") + 
  scale_x_log10()

#Try some alternative scale mappings. Besides scale_x_log10() you can try
#scale_x_sqrt() and scale_x_reverse(). There are corresponding functions for
#y-axis transformations. Just write y instead of x. Experiment with them to see
#what sort of effect they have on the plot, and whether they make any sense to use.

p + geom_point() +
  geom_smooth(method = "loess") + 
  scale_y_reverse()


#What happens if you map color to year instead of continent? Is the result what 
#you expected? Think about what class of object year is. 

p <- ggplot(data = gapminder,
            mapping = aes(x = pop,
                          y = lifeExp,
                          color = year,
                          fill = year))
p + geom_point() +
  geom_smooth(method = "loess") + 
  scale_x_log10()

#Instead of mapping color = year, what happens if you try color = factor(year)?

p <- ggplot(data = gapminder,
            mapping = aes(x = pop,
                          y = lifeExp,
                          color = factor(year),
                          fill = factor(year)))
p + geom_point() +
  geom_smooth(method = "loess") + 
  scale_x_log10()

#Fig-13.13
p <- ggplot(data = gapminder, 
            mapping = aes(x = gdpPercap,
                          y = lifeExp))

p + geom_point(alpha = 0.3, color = "purple") + 
  geom_smooth(color  = "red", size = 2, se = F, method = "lm") + 
  scale_x_log10(labels = scales::dollar) + 
  labs( x = "GDP per capita", y = "Life Expectancy",
        title = "Economic growth vs. Life Expectancy", 
        subtitle = "Data points are country-years", 
        caption = "Source: Gapminder")

#We worked it up to the point where it was reasonably polished, 
#but is it really the best way to display this country-year data? What are we 
#gaining and losing by ignoring the temporal and country-level structure of the 
#data? How could we do better? Sketch out what an alternative visualization might look like.

p <- ggplot(data = gapminder, 
            mapping = aes(x = gdpPercap,
                          y = lifeExp,
                          color = continent,
                          fill = continent))
p + geom_point() + 
  geom_smooth(method = "lm") + 
  scale_x_log10(labels = scales::dollar) + 
  labs( x = "GDP per capita", y = "Life Expectancy",
        title = "Economic growth vs. Life Expectancy", 
        subtitle = "Data points are country-years", 
        caption = "Source: Gapminder")

#save the figure
ggsave(filename = "Continent-level-fig.pdf", height = 7, width = 10)
