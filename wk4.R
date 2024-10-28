install.packages("ggplot2")
library(ggplot2)
ggplot(data = merged_data) +
  geom_sf(aes(fill = inequality_difference_2010_2019), color = NA) +
  scale_fill_viridis_c() +
  labs(title = "World Map of Inequality Difference (2010-2019)",
       fill = "Inequality Difference") +
  theme_minimal()

