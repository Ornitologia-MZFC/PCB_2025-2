# load libraries 
library(raster)
library(ntbox)
library(ellipsenm)
library(terra)

# set the working directory 
setwd ("C:/Users/vicen/Documents/pcb_2025_2/PCB_2025-2/Unidad_4/practica_6_niche_comparison/")

# Cargar los objetos de la práctica de transferencias geográficas
load("C:/Users/vicen/Documents/pcb_2025_2/pcb_2025-2/Unidad_4/practica4__enm_transferences/enm_trnasferences_geography.RData")

# Area calibration
area_calibration_formosa <- vect("calibration_area/calocittaf_aream.shp")
crs(area_calibration_formosa) <- "+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0"

# Plot
plot(area_calibration_formosa)
plot(area_calibration)

# cut all layers with total area calibration

wlclim_bios <- list.files(path="../practica3_espacio_ecol_and_geog/wc_2_5", pattern = ".tif", full.names=TRUE)

wlclim_stack <- rast()
for (i in seq_along(wlclim_bios)) { 
  wlclim_rast<- rast(wlclim_bios[[i]])
  plot(wlclim_rast)
  wlclim_stack <- c(wlclim_stack, wlclim_rast)
}

#Seleccionar vars no correlacionadas
names(wlclim_stack)
wlclim.subset.vars <- subset(wlclim_stack, c("wc2.1_2.5m_bio_2", "wc2.1_2.5m_bio_3", "wc2.1_2.5m_bio_5",
                                             "wc2.1_2.5m_bio_13", "wc2.1_2.5m_bio_15", "wc2.1_2.5m_bio_18"))


area_calibration_stack_formosa <- terra::crop(wlclim.subset.vars, area_calibration_formosa)
plot(area_calibration_stack_formosa[[1]])
crs(area_calibration_stack_formosa) <- "+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0"
area_calibration_stack_mask_formosa <- mask(area_calibration_stack_formosa, area_calibration_formosa)
plot(area_calibration_stack_mask_formosa)

#Objeto previo
plot(area_calibration_stack_mask)

# Preparing training and testing data
#Read csv
presences_sp_formosa <- read.csv("database/formosa_20km.csv")
presences_sp_df_formosa <- as.data.frame(presences_sp_formosa)

# RAMDOMIZATION DO NOT REPEAT
formosa.data.split <- split_data(presences_sp_df_formosa, method = "random", longitude = "Longitude",
                                 latitude = "Latitude", train_proportion = 0.80)

#Objeto previo
psilorhinus.data.split 

# Overlap object
area_calibration_stack_mask <- stack(area_calibration_stack_mask)
morio.niche <- ellipsenm::overlap_object(psilorhinus.data.split$train, 
                                               species =  "Species",
                                               longitude = "Longitude", 
                                               latitude = "Latitude", method = "covmat", level = 99, 
                                               variables = area_calibration_stack_mask)



area_calibration_stack_mask_formosa <- stack(area_calibration_stack_mask_formosa)
formosa.niche <- ellipsenm::overlap_object(formosa.data.split$train, 
                                               species =  "Species",
                                               longitude = "Longitude", 
                                               latitude = "Latitude", method = "covmat", level = 99, 
                                               variables = area_calibration_stack_mask_formosa)

#### The null hypothesis is that the niches are overlapped and 
#### if the observed values are as extreme or more extreme than the lower limit 
#### of the values found for the random-ellipsoids, the null hypothesis is rejected. 
#### This is, if the observed overlap value is lower than the 95% 
#### (or the value defined in confidence_limit) of the random-derived values of overlap,
#### the niches are considered not-overlapped. If the observed value cannot be distinguished 
#### from random, the null hypothesis cannot be rejected.


# morio - formosa
morio.formosa.overlap <- ellipsenm::ellipsoid_overlap(morio.niche, 
                                                            formosa.niche,
                                                            n_points = 1000000,
                                                            significance_test = TRUE, 
                                                            replicates = 1,
                                                            confidence_limit = 0.05,
                                                            overlap_type = "all") 


# plotting only ellipsoids
plot_overlap(morio.formosa.overlap)


# "full", measures overlap of the complete volume of the ellipsoidal niches.
# Interseccion en el contexto de la aproximacion al Nicho Fundamental
ellipsenm::plot_overlap(morio.formosa.overlap,
                        background = T,
                        background_type = "full",
                        proportion = 0.95)

# "back_union", meausures overlap of ellipsoidal niches considering only the union 
# of the environmental conditions relevant for the two species (backgrounds).
# Interseccion en el contexto de las Ms
ellipsenm::plot_overlap(morio.formosa.overlap,
                        background = T,
                        background_type = "back_union", legend = TRUE,
                        proportion = 0.95)


#################################################################################
# Para revisar los puntos
#Spatial points


formosa_occur_spdf <- SpatialPoints(presences_sp_df_formosa[,2:3])
# Establecer el sistema de referencia
CRS.new <- CRS("+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0")  

# Asignar ese sistema a los puntos
proj4string(formosa_occur_spdf)<-CRS.new
plot(area_calibration_stack_mask_merge[[1]])
plot(formosa_occur_spdf, add=T)

tabla_values <- extract(area_calibration_stack_mask_merge[[1]], formosa_occur_spdf )
tabla_values_na <-  which(is.na(tabla_values))
presences_sp_df_formosa_na <- presences_sp_df_formosa[-c(tabla_values_na) , ]
#######################################################################################


# Ejercicio
# Hacer un ejercicio de comparación de nicho climático 
# para las especies con que hicieron transferencia en el espacio geográfico.
# En la práctica indicar por qué compararon esas especies, dar un breve introducción,
# mostrar y discutir los resultados.
# Comentar el script.
# Se entrega en formato R.


