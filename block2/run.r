# Här kan man skriva exempelkod och köra den. Alterantivt kan man använda terminalen för att utvärdera sin kod.
# Får att enkelt kunna redovisa svaret på uppgifterna kan man använda "block_2.qmd" som är ett sätt att redovisa sin kod och även
# plotta in sina figurer på ett smidigt sätt i ett docx eller pdf format (som läggs i /output mappen). För att köra sin R kod i 
# .qmd(quarto) måste man använda ```{r}skriv din kod här ```
# Här kommer lite exempel på kod som efterfrågas i block 2:

area_kvadrat = 5^2
print(area_kvadrat)

CircleArea <- function(radius) {
  radius*radius*pi
}

radier <- c(1:9)
areor <- c(CircleArea(radier))
plot(radier, areor)
lines(radier, areor, col = "blue")