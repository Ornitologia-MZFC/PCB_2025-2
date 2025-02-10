#Load some libraries
library(geiger)
library(ape)
library(ggtree)
library(ggplot2)
library(nicheROVER)

#Explorar el nicho 

# Explore the data
data(fish)
# Check the data
fish

nsamples <- 10
#Generate the posterior distributions of mu (mean) and sigma (variance)
fish.par <- tapply(1:nrow(fish), fish$species,
                   function(ii) niw.post(nsamples = nsamples, X = fish[ii,2:4]))

# format data for plotting function
fish.data <- tapply(1:nrow(fish), fish$species, function(ii) X = fish[ii,2:4])
clrs <- c("black", "red", "blue", "orange") # colors for each species
niche.plot(niche.par = fish.par, niche.data = fish.data, pfrac = .1,
           iso.names = expression(delta^{15}*N, delta^{13}*C, delta^{34}*S),
           col = clrs, xlab = expression("Isotope Ratio (per mille)"))

######################
## Phylomorphospace ##
######################
# A phylomorphospace allows us to consider phylogeny, disparity and
# tempo simultaneously.

# Explore the database 
data(sunfish.data)
sunfish.data

## set colors for mapped discrete character
#Set colors according to feeding mode 
cols<-setNames(c("blue","orange"),
               levels(sunfish.data$feeding.mode))

# plot the phylogenetic tree
plotTree(sunfish.tree,ftype="i",fsize=0.5,color="darkgrey",
         offset=0.5)

# Add the tip colors to the tree
ecomorph_sunfish<-as.factor(getStates(sunfish.tree,"tips"))
tiplabels(pie=to.matrix(ecomorph_sunfish[sunfish.tree$tip.label],
                        levels(ecomorph_sunfish)),piecol=cols,cex=0.3)

# Plot the phylomorphospace with colors as the tree
phylomorphospace(sunfish.tree,sunfish.data[2:3],
                 colors=cols,label="horizontal", bty="l", node.by.map=TRUE,
                 node.size=c(1.5,1.5), pch=19, xlab="relative buccal length",
                 ylab="relative gape width")

title(main="Phylomorphospace of buccal morphology in Centrarchidae",
      font.main=1)


# Ejercicio explorar el nicho como en la parte 1 para la base sunfish.data, 
# para espcies piscivoras y no-piscivoras.
# Discutir los resultados junto con el phylomorphospace.




