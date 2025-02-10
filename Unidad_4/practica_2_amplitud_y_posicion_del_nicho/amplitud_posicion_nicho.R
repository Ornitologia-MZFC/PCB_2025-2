# # Realización del análisis OMI
# El outlying mean index (OMI; Dolédec, Chessel, & Gimaret‐Carpentier 2000) 
# es una técnica de ordenación diseñada para tener en cuenta explícitamente 
# el nicho ecológico de cada especie dentro de una comunidad (Dolédec, et al, 2000).

# En el análisis OMI, la posición de cada especie en el espacio multidimensional 
# depende de su desviación del nicho en relación con una especie teórica 
# distribuida uniformemente, que ocurriría bajo todas las condiciones de hábitat disponibles.

# El método OMI da un valor alto cuando la mayoría de los individuos ocurren 
# hacia un extremo del gradiente ambiental.
# Un valor alto de OMI se interpreta como una posición “marginal” del nicho. 

# Proporciona información sobre el ancho del nicho o la tolerancia de las especies 
# donde “los valores altos de tolerancia están asociados con taxones 
# que ocurren en una amplia gama de condiciones ambientales (taxones generalistas). 

# Los valores bajos de tolerancia implican que los taxones se distribuyen en 
# un rango limitado de condiciones ambientales (taxones especialistas)” 
# Las especies con valores más altos tienen nichos más amplios.

# Actividades:
# 1.- Describe brevemente el trabajo de campo tendrías que hacer para obtener datos como los de la base drome. 
# 2.- Describe brevemente, en terminos de R, la base drome. 
# 3.- Qué especies muestran un reducido NB?
# 4.- Qué especies muestran un amplio NB?
# 5.- Qué especie(s) se comporta más distintamente al resto en términos de la posición del nicho?

# Práctica 2.1.

# Install some packages:
install_github("andrewljackson/siar@master")
devtools::install_github("KarasiewiczStephane/WitOMI", force = TRUE)
install.packages("knitr")
install.packages("adegraphics")
install.packages("vegan3d")

# load the required libraries
library(vegan3d)
library(knitr)
library(subniche)
library(siar)
library(devtools)
library(adegraphics)
library(ade4)
library(vegan)
library(FactoMineR)
library(factoextra)
library(corrplot)

# Set our working directory
setwd("C:/Users/vicen/Documents/pcb_2025_2/Unidad_4/practica_2_amplitud_y_posicion_del_nicho")

# Getting the data
# data set includes fish species occurrence along with environmental variables (Karasiewicz et al., 2017).
drome

# Vars:
# DSOU: distance to the source. 
# DISCHARGE: mean annual discharge. 
# LMIN: lowest monthly discharge. 
# WIDTH: mean stream width. 
# SLOPE.
# ALTITUDE.

#Rename locations
names_loc <- c()
rownames(drome$fish)
for (i in seq_along(rownames(drome$fish))) {
  name_loc <- paste0("loc_",i)
  names_loc <- c(names_loc, name_loc)
}

rownames(drome$fish) <- names_loc
rownames(drome$env) <- names_loc
#Check
drome

# Para describir la variación ambiental
#PCA de variables ambientales
pca_drome <- PCA(drome$env[,-1], scale.unit = TRUE, ncp = 5, graph = TRUE)

#Contribución de cada componente
fviz_eig(pca_drome, addlabels = TRUE)

#Contribución de cada variable a cada componente
var <- get_pca_var(pca_drome)
corrplot(var$cos2, is.corr=FALSE)
pca_drome$var$contrib

# Color by cos2 values: quality on the factor map
fviz_pca_var(pca_drome, col.var = "cos2",
             gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"), 
             repel = TRUE # Avoid text overlapping
)
pca_drome$var$contrib

# Habiendo descrito las vars ambientales, vamos a decribir el sistema. 
# PCA 
pca_drome <- dudi.pca(drome$env[,-1], scale = TRUE, nf = 6, scannf = FALSE)
summary(pca_drome)

#Summary plot 
niche_description <- niche(pca_drome, drome$fish, scann = FALSE)
niche_description

g10 <- plot(niche_description)
class(g10)
names(g10)
g10$niches
g10$species

## Revisar argumentos del objeto
#Axis
g1 <- s.corcircle(niche_description$as)
zoom(g1, zoom = 0.7)

# Vars ambientales
g2 <- s.corcircle(niche_description$c1)
adegpar("plabels")
adegpar(plabels = list(col = "blue", cex = 0.5, alpha = 0.5, boxes = list(alpha = 0.5)),  paxes.draw = TRUE)
g2 <- s.corcircle(niche_description$c1)

# Localidades
plot(niche_description$ls, pch = 19)
text(niche_description$ls,
     labels = row.names(drome$fish),
     cex = 0.6, pos = 4, col = "blue")

# Localidades y especies
plot(niche_description$ls, pch = 19)
text(niche_description$li,
     labels = row.names(niche_description$l1),
     cex = 0.6, pos = 4, col = "blue")

# Niches
s.distri(niche_description$ls, dfdistri = drome$fish)

#####
#Some statistics
kable(niche.param(niche_description))

# Explanation of the values
# The variability of the niche of species j is decomposed into three components: 
# (1) Inertia of species j as the weighted sum of squared distances to the origin.
# (2) Index of marginality, i.e., the average distance of species j to the uniform distribution. 
# Un valor alto de OMI se interpreta como una posición “marginal” del nicho. 
# Alta correlación entre Inertia and OMI
plot(niche.param(niche_description)[ , 2], niche.param(niche_description)[ , 1],
     pch = 19)
text(niche.param(niche_description)[ , 2], niche.param(niche_description)[ , 1],
     labels = row.names(niche.param(niche_description)),
     cex = 0.6, pos = 1, col = "blue")
r = cor(niche.param(niche_description)[ , 2], niche.param(niche_description)[ , 1])
# r = 0.92
# r2 = 0.84

# (3) Index of tolerance or niche breadth.  
plot(niche.param(niche_description)[ , 2], niche.param(niche_description)[ , 1],
     pch = 19, cex = niche.param(niche_description)[ , 4])
text(niche.param(niche_description)[ , 2], niche.param(niche_description)[ , 1],
     labels = row.names(niche.param(niche_description)),
     cex = 0.6, pos = 1, col = "blue")

# (4) Residual tolerance, i.e., an index that helps to determine the reliability 
# of a set of environmental conditions for the definition of the niche of species j.
# Values to the right represent the corresponding percentages of variability.


###Parte 2
#Análisis de Correspondencia Canónica (CCA).
# El CCA es un análisis particular de variables instrumentales.
# La característica principal del CCA es que está relacionado con el principio de promedio ponderado
# y, por lo tanto, proporciona una estimación de la respuesta unimodal del nicho al gradiente ambiental.
# Si no es unimodal entonces Canonical Correlation Analysis (CANCOR) or Redundancy Analysis (RDA). 

# Análisis de variables instrumentales
# En los estudios especie-ambiente, a menudo se asume que las condiciones ambientales
# influyen en la distribución de las especies.
# Los métodos basados en variables instrumentales consideran explícitamente 
# que una tabla contiene variables de respuesta  (especies) que deben ser explicadas
# por una segunda tabla de variables explicativas (instrumentales) en este caso las vars ambientales.

# Continuamos trabajando con nuestra base. 
# Data
drome$fish

# Vars ambientales para cada localidad
drome$env[ ,2:7]

# Canonical correspondece analysis 
vare.cca <- cca(drome$fish ~ Altitude+DSou+slope+width+Lmin+Dicharge, 
                data=drome$env[ ,2:7])

#Plot 2d
plot(vare.cca)

# Resumen de los estadísticos   
summary(vare.cca)
# "La Inercia Total" es la varianza total en las distribuciones de las especies. 
# "La Inercia Restringida" es la varianza explicada por las variables ambientales.

# Calcular los Factores de Inflación de Varianza (VIF) para cada una de las restricciones 
# (variables) de la matriz "env" (matriz ambiental). 
# Si encontramos una variable ambiental con un VIF > 10, 
# esta variable presenta colinealidad con otra u otras variables. 
vif.cca(vare.cca)

# Canonical correspondece analysis 
vare.cca2 <- cca(drome$fish ~ Altitude+slope+width+Lmin+Dicharge, 
                data=drome$env[ ,2:7])

# Calcular los Factores de Inflación de Varianza (VIF)
vif.cca(vare.cca2)

# Testing the significance of CCA axes 
# (at least the first two or three should present a significant p value):
anova.cca(vare.cca, by="axis")