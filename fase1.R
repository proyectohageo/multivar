# 2. Palabras correlacionadas
library(caret)
library(kernlab)
data(spam)

inTrain <- createDataPartition(y=spam$type, p=0.75, list=FALSE)
datosSpam <- spam[inTrain, ]
testing <- spam[-inTrain, ]

# Buscando correlaciones entre las palabras tomando su valor absoluto
M <- abs(cor(datosSpam[,-58]))

# cada palabra tiene correlacion de 1 consigo misma, entonces remover la diagonal
diag(M) <- 0

# cuales de las palabras tienen mayor correlacion
which(M > 0.8, arr.ind=T)

# cual es el nombre de las variables correlacionadas
names(spam)[c(34, 32)]

# hacer el plot de las variables
plot(spam[, 34], spam[, 32])

# El objetivo del ACP es de reducir la redundancia y comprimir la información
# Podriamos rotar los graficos
X <- 0.71 * datosSpam$num415 + 0.71 * datosSpam$num857
Y <- 0.71 * datosSpam$num415 - 0.71 * datosSpam$num857
plot(X, Y)

# Para obtener los componentes principales utilizamos - prcomp
subSpam <- spam[, c(34, 32)]
prComp <- prcomp(subSpam)
plot(prComp$x[, 1], prComp$x[, 2])

prComp$rotation

# Probando PCA en datos marcados como SPAM
typeColor <- ((spam$type=="spam") * 1 + 1)
typeColor
prComp <- prcomp(log10(spam[,-58]+1))
# first component capture more information on data than the second one
plot(prComp$x[,1], prComp$x[,2], col=typeColor, xlab="PrinComp1", ylab="PrinComp2")

# PCA con caret con metodo 'pca' y el numero de componentes
preProc <- preProcess(log10(spam[, -58]+1), method="pca", pcaComp=2)
# Se utiliza una transformacion de datos con la funcion log10, y adicionandole 1 a esto. 
# Esto hace que la los datos sean un poco mas Gaussianos. 
# Esto ayuda porque algunas variables estan muy desviadas , mientras que otras estan muy bien.
# A veces es necesario hacer esto para que el PCA sea sensible

spamPC <- predict(preProc, log10(spam[, -58]+1))
plot(spamPC[, 1], spamPC[, 2], col=typeColor)

