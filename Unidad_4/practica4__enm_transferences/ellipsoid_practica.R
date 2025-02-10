# load libraries 
library(raster)
library(ntbox)
library(ellipsenm)
library(rgdal)
library(sp)

# set the working directory 
setwd ("C:/Users/vicen/Documents/pcb_2025_2/Unidad_4/practica4__enm_transferences")

#America
shape_america <- readOGR(dsn=path.expand("../practica3_espacio_ecol_and_geog/shapes_figura/"),
                         layer="America")
plot(shape_america)
# Worldclim Vars

wlclim_bios <- list.files(path="../practica3_espacio_ecol_and_geog/wc_2_5", pattern = ".tif", full.names=TRUE)
wlclim_stack<-stack(wlclim_bios)
plot(wlclim_stack[[1]])

#Seleccionar vars no correlacionadas
wlclim.subset.vars <- raster::subset(wlclim_stack, c("wc2.1_2.5m_bio_2","wc2.1_2.5m_bio_3", "wc2.1_2.5m_bio_5","wc2.1_2.5m_bio_13", "wc2.1_2.5m_bio_15","wc2.1_2.5m_bio_18"))

# Area calibration
area_calibration <- readOGR(dsn=path.expand("../practica3_espacio_ecol_and_geog/shapes_figura/"),
                            layer="America")


area_calibration <- readOGR("calibration_area/",
                            layer="psilorhinus_aream")
crs(area_calibration) <- "+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0"

# Plot
plot(area_calibration)

# cut all layers with total area calibration
area_calibration_stack <- crop(wlclim.subset.vars , extent(area_calibration))
area_calibration_stack_mask <- mask(area_calibration_stack, area_calibration)
plot(area_calibration_stack_mask)


# Ellipses in the geography
#PCA for 6 vars
pca_vars_6 <- spca(area_calibration_stack_mask)
pca_vars_6
plot(pca_vars_6[[1]])

# Preparing training and testing data


#Read csv
presences_sp <- read.csv("C:/Users/vicen/Documents/pcb_2025_2/Unidad_4/practica4__enm_transferences/databases/pmorio_20km.csv")
presences_sp_df <- as.data.frame(presences_sp)

# RAMDOMIZATION DO NOT REPEAT
psilorhinus.data.split <- split_data(presences_sp_df[1:135, ], method = "random", longitude = "Longitude",
                                 latitude = "Latitude", train_proportion = 0.80)

# Methods
methods <- c("covmat", "mve1")
sets <- list(set_1 = c("PC1", "PC2", "PC3"),
             set_2 = c("PC1", "PC2", "PC4")) # change as needed

variable_sets <- prepare_sets(pca_vars_6[[1]][[1:4]], sets)

calib_psilorhinus <- ellipsoid_calibration(psilorhinus.data.split, species = "Species", longitude = "Longitude", 
                                       latitude = "Latitude", variables = variable_sets,
                                       methods = methods, level = 99, selection_criteria = "S_OR_P",
                                       error = 5, iterations = 500, percentage = 50,
                                       output_directory = "psilorhinus_calibration_results", overwrite = TRUE)

#Object 
calib_psilorhinus


#psilorhinus
psilorhinus.data.split$train
psilorhinus.extract.pca <- raster::extract(pca_vars_6[[1]][[1:3]], psilorhinus.data.split$train[ , c( "Longitude", "Latitude")])
psilorhinus.extract.pca <-na.omit(psilorhinus.extract.pca)
niche_sub <- ntbox::cov_center(psilorhinus.extract.pca, mve = T,
                               level = 0.95,vars = c(1,2,3))

psilorhinus_niche_geography <- ntbox::ellipsoidfit(envlayers = pca_vars_6$pc_layers[[c(1,2,3)]],
                                                   centroid = niche_sub$centroid,
                                                   covar = niche_sub$covariance, size=1)

plot(psilorhinus_niche_geography$suitRaster)

##################
# cut all layers with total area calibration

america_back <- extent(c(-85 , -30 , -60,10))

transference_area <- crop(wlclim.subset.vars, extent(america_back))
plot(transference_area)


# STACK
present_stack.s.c <- stack(transference_area)

psilorhinus_geography <- ellipsoid_model(data = psilorhinus.data.split$train, 
                                     species = "Species",
                                     longitude = "Longitude", 
                                     latitude = "Latitude",
                                     raster_layers = area_calibration_stack_mask, 
                                     method = "covmat", 
                                     level = 99,
                                     replicates = 1, 
                                     replicate_type = "bootstrap",
                                     bootstrap_percentage = 80, 
                                     projection_variables = list(projection = present_stack.s.c), 
                                     prediction = "suitability", 
                                     return_numeric = TRUE,
                                     format = "GTiff", 
                                     overwrite = TRUE,
                                     output_directory = paste0("geographic_transferences/"))


# Ejercicio en parejas
# Hacer el ejercicio de transferencia en el espacio geográfico para dos especies (una especie por persona).  
# Nota: van a ocupar las especies que escojan para la práctica 6, 
#       donde vamos a comparar los nichos climáticos. Decidan con base en eso.
#       Guarden los objetos y resultados. 
# El reporte se entrega en formato R, e incluirá las 2 prácticas.
