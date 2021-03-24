setwd('C:/Users/valer/OneDrive - Universidad Nacional de Colombia/2021-1 M-Primer Semestre/Mineria de datos')
train = read.csv('train_data.csv',encoding = "UTF-8")
test = read.csv('test_data.csv',encoding = "UTF-8")
example = read.csv('example_submission.csv',encoding = "UTF-8")
library(tidyverse)
dataC = bind_rows(train,test)
datatrain = train %>% mutate(mt2 = valorventa/area)
datatest = test %>% mutate(mt2 = valorventa/area)
data1 = datatest %>% mutate(mt2 = valorventa/area) %>% 
  inner_join(example %>% rename(mt1 = valormt2_predicted),by = 'id')
1/nrow(data1)*sum(abs(data1$mt1 - data1$mt2)*100/data1$mt2)

#data_pred = jsonlite::fromJSON('https://datosabiertos.bogota.gov.co/dataset/a0ad3bf4-1e97-4cf9-b853-76558158036f/resource/875e877d-ee4b-4451-9d19-374cc59a441a/download/v_ref2.geojson')
library(sf)
data_shp = read_sf("valor_ref_2020/Valor_Ref_M.shp")
data2 = data_shp %>% select(V_REF,geometry) %>%
  mutate(longitud2 = unlist(map(geometry,function(x){x[[1]][[1]][1,1]})),
         latitud2 = unlist(map(geometry,function(x){x[[1]][[1]][1,2]}))) %>%
  select(V_REF,latitud2,longitud2)


