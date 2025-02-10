#Para instalar paquetes
install.packages("bipartite")
# Llamar librerias
library(bipartite)

#asignar el directorio de trabajo
setwd("C:/Users/vicen/Documents/pcb_2025_2/Unidad_4/practica1_interacciones_planta_polinizador")

data(Safariland)
knitr::kable(Safariland)
plotweb(Safariland, col.high = "salmon", col.low = "violet") 
visweb(Safariland) 

# Algunas métricas de la red
# índice H2: Grado de especialización complementaria.
1 = sugieren una partición de nicho elevada y una alta especialización a nivel de comunidad.
0 = sugieren que el nivel de especialización es bajo.


# Grado de anidamiento de la red, representado con el índice NODF. 
# Este índice se interpreta como la asimetría en la especialización de la red. 
# La relación de los especialistas (especies con pocos enlaces) 
# con los generalistas (especies con muchos enlaces) en la red. 
0:   No anidamiento 
100: Alto anidamiento 

# Conectancia (C)  
# La conectancia es la proporción realizada entre los enlaces de las interacciones 
# entre plantas y polinizadores de la red. 
1: es conectancia perfecta. 

# Robustez (R).
El grado de robustez de la red (R) se mide como una capacidad de resiliencia frente 
a eventos de extinción de especies.

Superposición de nicho (SN), 
# métrica que corresponde a la similitud en los patrones de interacción 
# (i.e. uso de un mismo recurso) entre especies de un mismo grupo. 
0: indican una partición de nicho elevada. 
1: una superposición de nicho total.

#Ejercicio en parejas 
# Red complementaria
# Discutir los estadisticos

#Red complementaria
#Importar datos
red_complementaria_base <- read.csv("red_complementaria.csv", row.names=1)
red_complementaria_df <- as.data.frame(red_complementaria_base)
??as.data.frame

# Clase de objeto
class(red_complementaria_df)
??data.matrix
red_complementaria_matrix <- data.matrix(red_complementaria_df, rownames=TRUE)
red_complementaria_matrix

#visualizar la tabla
knitr::kable(red_complementaria_matrix)
# Visualizar la red
visweb(red_complementaria_matrix, type = "none", labsize=0.5) 
??visweb
# Hacer un plot de la red
plotweb(red_complementaria_matrix, col.high = "salmon", col.low = "violet") 
#Obtener informacion de algunos estadísticos que describen la red
networklevel(red_complementaria_matrix) 

#Red redundante
#Importar datos
red_redundante_base <- read.csv("red_redundante.csv", row.names=1)
red_redundante_df <- as.data.frame(red_redundante_base)

# Clase de objeto
class(red_redundante_df)
red_redundante_matrix <- data.matrix(red_redundante_df, rownames=TRUE)
red_redundante_matrix

#visualizar la tabla
knitr::kable(red_redundante_matrix)
# Visualizar la red
visweb(red_redundante_matrix, type = "none", labsize=0.5) 

# Hacer un plot de la red
plotweb(red_redundante_matrix, col.high = "salmon", col.low = "violet") 
#Obtener informacion de algunos estadísticos que describen la red
networklevel(red_redundante_matrix) 

#                              Complementaria                  Redundante
# H2 index:                         0.88                          0.53
# Anidamiento NODF:                 2.6                           55.8
# Conectancia:                      0.17                          0.45
# Robustez:                         0.4/0.57                      0.63/0.69
# Superposición de nicho:           0.05/0.09                     0.36/0.32
