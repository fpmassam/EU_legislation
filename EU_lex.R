require(eurlex)
require(tidyverse)

query_dir <- elx_make_query(resource_type = "regulation", 
                            include_date = TRUE, 
                            include_date_force = TRUE, 
                            include_force = TRUE)
data =  elx_run_query(query = query_dir)
data_1 = subset(data, date > "2022-06-01" & 
                  date < "2022-06-30")
data_1 = data_1 %>%
  mutate(title = map_chr(work, possibly(elx_fetch_data, otherwise = NA_character_),
                                  "title"),
         text = map_chr(work, possibly(elx_fetch_data, otherwise = NA_character_),
                         "text")
         )

write_csv(data_1; "")