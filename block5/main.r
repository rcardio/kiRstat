library(tidyverse)
library(survival)

data(jasa, package="survival")
view(jasa)

write_csv(jasa, "jasa.csv")