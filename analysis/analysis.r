# Dépendances
library(readr)
# Installer ggplot2 si ce n'est pas déjà fait
if (!require(ggplot2)) {
  install.packages("ggplot2")
}
# Charger ggplot2
library(ggplot2)
# Charger dplyr
library(dplyr)

# Chargement des données
df <- read_csv("../data/covid_testing.csv")

# Afficher les premières lignes du DataFrame
head(df)

# Afficher des informations sur le DataFrame
str(df)

# Afficher les noms des colonnes
colnames(df)

# Exemple d'affichage d'une valeur formatée
nom_colonne <- colnames(df)[1]
valeur <- df[1, 1]

# Utiliser sprintf pour formater la chaîne de caractères
message <- sprintf("La première valeur de la colonne '%s' est %s.", nom_colonne, valeur)

# Afficher le message
print(message)

# Créer un histogramme pour la colonne "age"
hist(df$age, main="Age du patient testé", xlab="Age (années)", ylab="Occurrence", col="blue", border="black")

# Résumé statistique de la colonne age
print(summary(df$age))

# Regroupement des tests par jour
ntests_per_day_df <- df %>%
  group_by(pan_day) %>%
  summarise(count = n()) %>%
  ungroup()

# Graphique XY
p <- ggplot(ntests_per_day_df, aes(x = as.numeric(pan_day), y = count)) +
  geom_point() +
  labs(title = "Nombre de par jour depuis le début de la pandémie",
       x = "Nombre de jours depuis le début de la pandémie (pan_day)",
       y = "Nombre de tests") +
  scale_x_continuous(breaks = seq(min(ntests_per_day_df$pan_day), max(ntests_per_day_df$pan_day), by = 10)) +
  theme_linedraw()
print(p)
