
# TEST APPS

print("TEST APPS: START")

library(farver)
library(ggplot2)

ggplot(mtcars, aes(mpg, wt)) + geom_point()
ggsave("mtcars.png")

print("TEST APPS: OK")
