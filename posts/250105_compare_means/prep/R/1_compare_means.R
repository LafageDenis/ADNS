## Chargement librairies

library(palmerpenguins)
library(ggplot2)
library(dplyr)
library(tidyr)
library(broom)
library(nortest)

# Chargement données
data(package = "palmerpenguins")
penguins <- penguins %>% 
  drop_na()
head(penguins)
glimpse(penguins)

# Graph comparaison taille

gbill <- ggplot(data = penguins,
                aes(x = sex,
                    y = bill_length_mm #, 
                    #color = species
                    )
)

gbill + geom_boxplot()


# Testing normality

## Graph

gdbill <- ggplot(data = penguins,
                 aes(x = bill_length_mm, color = sex))
gdbill + geom_density()

## Test

with(penguins, tapply(bill_length_mm, sex, shapiro.test))
with(penguins, tapply(bill_length_mm, sex, ad.test))

# Test homoscédasticité

bartlett.test(bill_length_mm ~ sex, data = penguins)

# Comparaison des moyennes

# Compare two samples

t.test(bill_length_mm ~ sex,  data = penguins)
