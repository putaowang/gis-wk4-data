> gii_data <- read.csv("/Users/muhenghe/Desktop/GIS/homework week4/Prac4 data/HDR23-24_Composite_indices_complete_time_series.csv")
> gii_data <- data %>%
  +     dplyr::select(iso3, country, hdicode, region, gii_2010:gii_2019)
> write.csv(gii_data, "HDR23-24_GII_2010_2019.csv", row.names = FALSE)
> names(gii_data)
> View(gii_data)
> library(ggplot2)
> library(tmap)
> world_data <- st_read("/Users/muhenghe/Desktop/GIS/homework week4/Prac4 data/World_Countries_(Generalized)_9029012925078512962 (1).geojson")
> View(world_data)
> View(gii_data)
> gii_data <- gii_data %>%
  +     mutate(
    +         inequality_difference_2010_2019 = gii_2019 - gii_2010
    +     )
> gii_data <- gii_data %>%
  +     mutate(
    +         inequality_difference_2010_2011 = gii_2011 - gii_2010,
    +         inequality_difference_2011_2012 = gii_2012 - gii_2011,
    +         inequality_difference_2012_2013 = gii_2013 - gii_2012,
    +         inequality_difference_2013_2014 = gii_2014 - gii_2013,
    +         inequality_difference_2014_2015 = gii_2015 - gii_2014,
    +         inequality_difference_2015_2016 = gii_2016 - gii_2015,
    +         inequality_difference_2016_2017 = gii_2017 - gii_2016,
    +         inequality_difference_2017_2018 = gii_2018 - gii_2017,
    +         inequality_difference_2018_2019 = gii_2019 - gii_2018
    +     )
> gii_data <- gii_data %>%
  +     mutate(
    +         inequality_difference_2010_2019 = gii_2019 - gii_2010
    +     )
> gii_difference_data <- gii_data %>%
  +     select(iso3, country, hdicode, region, inequality_difference_2010_2019)
> write.csv(gii_difference_data, "gii_difference_data.csv", row.names = FALSE)
View(gii_difference_data)

names(world_data)
merged_data <- world_data %>%
  +     left_join(gii_difference_data %>%
                    +                   select(iso3, country, hdicode, region, inequality_difference_2010_2019),
                  +               by = c("ISO" = "iso3"))
> View(merged_data)
> print(head(merged_data))
> merged_data <- merged_data %>%
  +     mutate(
    +         country = coalesce(country, gii_difference_data$country[match(ISO, gii_difference_data$iso3)]),
    +         hdicode = coalesce(hdicode, gii_difference_data$hdicode[match(ISO, gii_difference_data$iso3)]),
    +         region = coalesce(region, gii_difference_data$region[match(ISO, gii_difference_data$iso3)]),
    +         inequality_difference_2010_2019 = coalesce(inequality_difference_2010_2019,
                                                         +                                                    gii_difference_data$inequality_difference_2010_2019[match(ISO, gii_difference_data$iso3)])
    +     )
merged_data <- world_data %>%
  left_join(
    gii_difference_data %>%
      select(iso3, country, hdicode, region, inequality_difference_2010_2019),
    by = c("COUNTRY" = "country")
  )
ggplot(data = merged_data) +
  geom_sf(aes(fill = inequality_difference_2010_2019), color = NA) +
  scale_fill_viridis_c() +
  labs(title = "World Map of Inequality Difference (2010-2019)",
       fill = "Inequality Difference") +
  theme_minimal()

