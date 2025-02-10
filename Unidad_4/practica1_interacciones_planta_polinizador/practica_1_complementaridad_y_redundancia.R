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
