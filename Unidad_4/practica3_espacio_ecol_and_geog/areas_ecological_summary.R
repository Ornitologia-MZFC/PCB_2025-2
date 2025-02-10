# Load libraries
library(rgdal)
library(raster)
library(terra)

# Primero lo primero
setwd ("C:/Users/vicen/Documents/pcb_2025_2/Unidad_4/practica3_espacio_ecol_and_geog")

# Ecoregions from Dynerstein et al., 2017
# Un vector con nombre de los shapes de las ecorregiones
shapes_names <- c("tropical_coniferous_forest",
                  "temperate_coniferous_forest",
                  "yp_dryforest",
                  "montane_grassland_sa",
                  "temperate_mixed_forest_2",
                  "moistforest_ca2", #sa
                  "moistforest_antillas",
                  "moistforest_yp",
                  "moistforest_ca1",
                  "dryforest_ca",
                  "dryforest_sa",
                  "dryforest_antillas")

#America
shape_america <- readOGR(dsn=path.expand("shapes_figura/"),
                      layer="America")
plot(shape_america)

# Read and assign name to the shape files.
# Shapefiles en la carpeta shapes_figura

for (i in seq_along(shapes_names)) { 
shape_ecos <- readOGR(dsn=path.expand("shapes_figura/"),
        layer=paste0(shapes_names[i]))
plot(shape_ecos)
assign(paste0(shapes_names[i]), shape_ecos)
print(paste0(shapes_names[i]))
}

#Objects
dryforest_antillas

# Make a stack with the 19 bioclimatic variables and altitude layer.
# Bioclimate bios estan en el folder wc_2_5.
wlclim_bios <- list.files(path="wc_2_5", pattern = ".tif", full.names=TRUE)
#saveRDS(wlclim_bios,  file = "wlclim_bios.RDS")
#wlclim_bios <- readRDS("wlclim_bios.RDS")

#Hacer un objeto raster
wlclim_bios_raster <- raster(wlclim_bios[1])

# Hacer un objeto stack
wlclim_bios_stack <- stack(wlclim_bios)

#Seleccionar las vars de interés
wlclim_bios_stack_sub <- raster::subset(wlclim_bios_stack, c(1,4,5,6,13,14))


# NOTA Checar los objetos es una buena práctica!
wlclim_bios_stack 

# Make an stack for each biome
# Comentar este for loop
CRS.new<-CRS("+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0")  
for (i in seq_along(shapes_names)) {
  for (j in seq_along(1:6)) {
  shape_get <- get(shapes_names[i]) 
  pres.stack.cut.ecos <- crop(wlclim_bios_stack_sub[[j]], shape_get)
  pres.stack.cut.ecos_mask <- mask(pres.stack.cut.ecos, shape_get)
  proj4string(pres.stack.cut.ecos_mask) <- CRS.new
  if (j == 1) { 
    add_layer <- stack() 
    add_layer <- addLayer(add_layer, pres.stack.cut.ecos_mask)
  } else {
    add_layer <- addLayer(add_layer, pres.stack.cut.ecos_mask)
  }
  if (j == 6) {
  assign(paste0(shapes_names[i], "_stack"), add_layer)
    print(paste("Este es el bioma ", shapes_names[i]))
    get_biome <- get(paste0(shapes_names[i], "_stack"))
    plot(get_biome)
  } else { 
    print("cargando capas")
     }
  }}

# Objects from the for loop
plot(moistforest_ca1_stack[[1]])
plot(moistforest_yp_stack[[1]])


# Transfer to the environmental space
# Extract values
extract.area_table <- c()
for (i in seq_along(shapes_names)) { 
    
# Stack for each area
area_stack <-  paste0(shapes_names[i], "_stack")
print(paste0(shapes_names[i], "_stack"))
area_stack_get <- get(area_stack)

# Extract COORDINATES
coordinates_area <- xyFromCell(area_stack_get, 1:ncell(area_stack_get))
coordinates_area_df <- as.data.frame(coordinates_area)
# make object a spatial points
sp.geog.area <- SpatialPoints(coordinates_area_df)
proj4string(sp.geog.area) <- CRS.new
#Extract values
extract.vals.area <- raster::extract (area_stack_get, sp.geog.area)
extract.area_table <- cbind(coordinates_area_df, extract.vals.area)
names(extract.area_table) <- c("Longitude", "Latitude", names(moistforest_yp_stack))

# paste the extracted values to dataframe 
assign(paste0(shapes_names[i], "_extract"), extract.area_table)
}

# objects
paste0(shapes_names[i], "_extract")
#dryforest_antillas_extract
get(paste0(shapes_names[i], "_extract"))

# Merge tables
for (i in seq_along(shapes_names)) { 
coordinates_area_extract <- paste0(shapes_names[i], "_extract")
coordinates_area_extract_get <- get(coordinates_area_extract)

#Select 10 thousand at random
extract.vals.area_val <- na.omit(coordinates_area_extract_get)
if (nrow(extract.vals.area_val) < 10000) { 
print("cool")
print(nrow(extract.vals.area_val))
assign(paste0(shapes_names[i], "_extract_table"), extract.vals.area_val)
  } else { 
random_coordinates <- extract.vals.area_val[sample(nrow(extract.vals.area_val), 10000), ]
  print(nrow(extract.vals.area_val))
assign(paste0(shapes_names[i], "_extract_table"), random_coordinates)
}}

# Objects
yp_dryforest_extract_table
moistforest_yp_extract_table

# Merge all tables
table_ecos <- c()
# Final table ecos
for (i in seq_along(shapes_names)) { 
extract_table <- get(paste0(shapes_names[i], "_extract_table"))
extract_table <- extract_table[1:8]
extract_table$id <- NA
extract_table$id <- paste0(shapes_names[i])
table_ecos <- rbind(table_ecos, extract_table)
}

# Table master
table_ecos

# FIGURE plot
library(factoextra)
library(ggfortify)
library(ggplot2)

names_ecosystems <- c(
  "Dry-forest Antilles",
  "Dry-forest Central-America",
  "Dry-forest South-America",
  
  "Moist-forest Antilles",
  "Moist-forest Central-America",
  "Moist-forest South-America",
  "Moist-forest Yucatan Peninsula",
  
  "Montane grassland South-America",
  "Temperate coniferous forest",
  "Temperate mixed forest",
  "Tropical coniferous forest",
  "Dry-forest Yucatan Peninsula")

pca_areas <- prcomp(table_ecos[ ,c(3:8)], scale = TRUE)

summary(pca_areas)
pca_areas$rotation

# Show the percentage of variances explained by each principal component.
 fviz_eig(pca_areas)

iriscolors<-setNames(c("darkgreen","green4","green3",
                       "orange", "yellow3",
                       "orange3","yellow",
                       "skyblue","darkblue", "blue3", "lightblue",
                       "lightgreen"),levels(table_ecos$id))  
bp <- ggplot(pca_areas$x) +
  aes(PC1, PC2, color = as.factor(table_ecos$id)) + 
  geom_point(size = 0.1, alpha = 0.2) +
  ylim(-2.5, 5) +
  xlim(-5, 5) +
  xlab("PC1: 52.95%")+
  ylab("PC2: 22.07%") +
  stat_ellipse(geom="polygon", level=0.80, alpha=0.2, lwd = 1.4) +
  scale_colour_manual(name="Biome", labels = names_ecosystems, values = iriscolors) 

bp 

# Plot in the Geographic space
plot(shape_america)
plot(tropical_coniferous_forest, col = "green", add=T)
plot(montane_grassland_sa, col = "lightgreen", add=T)
plot(temperate_mixed_forest_2, col = "blue3", add=T)
# etc

# Practica 1:
# Repetir para el área de estudio.