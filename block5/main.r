# Loading functions, csv file and data. Saving data as .rda file.
source("block5/funs.r")
output_path <- "block5/data/jasa.csv"
initiate(output_path)
data <- read.csv("block5/data/jasa.csv")
save(data, file = paste0("block5/data/jasa_", Sys.Date(), ".rda"))

# Attention: If open data "jasa" not available, load it from the .rda file.

# Starting EDA
glimpse(data)

# Convert character strings that are dates to Date type
data <- data %>%
  mutate(across(where(~ is.character(.) && any(!is.na(as.Date(.)))), as.Date))

# Convert all 0 and 1 integer columns to booleans
data <- data %>%
  mutate(across(where(~ all(. %in% c(0, 1)) && is.numeric(.)), as.logical))

# It appears that the 'reject' and 'hla.a2'
# columns are still numeric, not logical.

# Explicitly convert 'reject' and 'hla.a2' to logical, preserving NAs
data <- data %>%
  mutate(across(c(reject, hla.a2), as.logical))

# Factorize columns with fewer than 10 discrete values
data <- data %>%
  mutate(across(where(~ n_distinct(.) < 10), as.factor))


####### Initial cleaning done #######

# Check distributiuons of numeric values
data %>%
  select_if(is.numeric) %>%
  gather(key = "variables", value = "values") %>%
  ggplot(aes(x = values)) +
  facet_wrap(~variables, scales = "free") +
  geom_histogram(bins = 30)

# Boxplots for numeric variables to spot outliers
data %>%
  select_if(is.numeric) %>%
  gather(key = "variables", value = "values") %>%
  ggplot(aes(x = variables, y = values)) +
  geom_boxplot() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

# Correlation matrix for numeric variables
data %>%
  select_if(is.numeric) %>%
  cor() %>%
  as_tibble(rownames = "Variable") %>%
  pivot_longer(-Variable, names_to = "Variable2", values_to = "Correlation") %>%
  ggplot(aes(x = Variable, y = Variable2, fill = Correlation)) +
  geom_tile() +
  scale_fill_viridis_c()

# Scatter plots for pairs of variables
pairs(data %>% select_if(is.numeric))

# Categorical data analysis
data %>%
  select(where(is.factor)) %>%
  pivot_longer(cols = everything(), names_to = "variables", values_to = "values") %>% #nolint
  ggplot(aes(x = values)) +
  facet_wrap(~variables, scales = "free_x") +
  geom_bar() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))