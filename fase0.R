library(kernlab)
library(RColorBrewer)
library(caret)
library(kernlab)
CUSTOM_COLORS_PLOT <- colorRampPalette(brewer.pal(10, "Set3"))
#  Cargando el conjunto de datos
data(spam)
inTrain <- createDataPartition(y=spam$type, p=0.75, list=FALSE)
datosSpam <- spam[inTrain, ]
levels(datosSpam$type)
result <- table(datosSpam$type)
numEmail <- result[["nonspam"]]
numEmail
print(paste0("Porcentaje EMAIL: ", round((numEmail/nrow(datosSpam)) * 100, 2), "%"))
numSpam <- result[["spam"]]
numSpam
print(paste0("Porcentaje SPAM: ", round((numSpam/nrow(datosSpam)) * 100, 2), "%"))

#Cantidad de Email vs. Cantidad de Spam en la muestra de datos
resTable <- table(datosSpam$type)
par(mfrow = c(1, 2))
par(mar = c(5, 4, 4, 2) + 0.1)  # increase y-axis margin.
plot <- plot(datosSpam$type, col = CUSTOM_COLORS_PLOT(2), main = "Email vs. Spam", 
             ylim = c(0, 4000), ylab = "Numero de mensajes")

text(x = plot, y = resTable + 200, labels = resTable)
percentage <- round(resTable/sum(resTable) * 100)
labels <- paste(row.names(resTable), percentage)  # add percents to labels
labels <- paste(labels, "%", sep = "")  # ad % to labels
pie(resTable, labels = labels, col = CUSTOM_COLORS_PLOT(2), main = "Email vs. Spam")

# Porcentaje promedio de caracteres o palabras

datos.email <- sapply(datosSpam[which(datosSpam$type == "nonspam"), 1:54], function(x) ifelse(is.numeric(x), 
                                                                                          round(mean(x), 2), NA))
datos.spam <- sapply(datosSpam[which(datosSpam$type == "spam"), 1:54], function(x) ifelse(is.numeric(x), 
                                                                                        round(mean(x), 2), NA))

datos.email.ordenado <- datos.email[order(-datos.email)[1:10]]
datos.spam.ordenado <- datos.spam[order(-datos.spam)[1:10]]

par(mfrow = c(1, 2))
par(mar = c(8, 4, 4, 2) + 0.1)  # increase y-axis margin.
plot <- barplot(datos.email.ordenado, col = CUSTOM_COLORS_PLOT(10), main = "Email: Porcentaje promedio", 
                names.arg = "", ylab = "Porcentaje relativo (%)")
# text(x=plot,y=dataset.email.order-0.1, labels=dataset.email.order,
# cex=0.6)
library(grid)
library(gridBase) 
vps <- baseViewports()
pushViewport(vps$inner, vps$figure, vps$plot)
grid.text(names(datos.email.ordenado), x = unit(plot, "native"), y = unit(-1, 
                                                                         "lines"), just = "right", rot = 50)
popViewport(3)

plot <- barplot(datos.spam.ordenado, col = CUSTOM_COLORS_PLOT(10), main = "Spam: Porcentaje promedio", 
                names.arg = "", ylab = "Porcentaje relativo (%)")
# text(x=plot,y=dataset.spam.order-0.1, labels=dataset.spam.order,
# cex=0.6)
vps <- baseViewports()
pushViewport(vps$inner, vps$figure, vps$plot)
grid.text(names(datos.spam.ordenado), x = unit(plot, "native"), y = unit(-1, 
                                                                        "lines"), just = "right", rot = 50)
popViewport(3)

datosper<- datosSpam[, 1:54]
n <- dim(datosper)[1]
colMeans(datosper) # equivalente al vector de medias
# ----------------------------------
# Matriz de covarianzas S = X'HX/n
# ----------------------------------
cov(datosper) # equivale a matrix de covarianza
cov(datosper)*(n-1)/n
Y <- scale(datosper,scale=F)

# ----------------------------------
# Matriz de datos estandarizada Z = H*X*D^(-1/2)
# ---------------------------------
Z <- scale(datosper)
# ----------------------------------
# GRAFICOS MULTIVARIANTES
# ----------------------------------
# Diagrama de líneas
# ----------------------------------
par(mfrow=c(1,3))
matplot(datosper,type="l")
matplot(Y,type="l")
matplot(Z,type="l")


library(andrews)
andrews(Z, clr=3) #clr visualiza con colores
andrews(Z, clr=3, type=2)
andrews(Z, clr=3, type=3) # se ve mejor el atípico
andrews(Z, clr=3, type=4)









