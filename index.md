## PROYECTO DE ANÁLISIS DE DATOS MULTIVARIADO

El correo no solicitado supone actualmente la mayor parte de los mensajes electrónicos intercambiados en Internet, siendo utilizado para anunciar productos y servicios de dudosa calidad. 

Hay tecnologías desarrolladas en esta dirección: por ejemplo el remitente puede firmar sus mensajes mediante criptografía de clave pública.

Los filtros automáticos antispam analizan el contenido de los mensajes buscando, por ejemplo, palabras como george, meeting, y sex que son las más usuales en los mensajes no deseados. No se recomienda utilizar estas palabras en la correspondencia por correo electrónico: el mensaje podría ser calificado como no deseado por los sistemas automáticos anti correo masivo.

### Sobre los datos

Se trata de una muestra de datos sobre clasificaciones de mensajes por presencia de palabra en el mensaje con un resultado "Spam" o "No Spam":

![Imagen](https://github.com/proyectohageo/multivar/blob/master/spam1.png)

* Las primeras 48 variables contiene  la frecuencia de la palabra en el email, si la clase comienza con num, se trata del numero en el mensaje.
* Las variables 49 al 54 indican la frecuencia de los caracteres ‘;’, ‘(’, ‘[’, ‘!’, ‘\$’, and ‘\#’.
* Las variables 55 al 57 contienen el promedio de palabras, la longitud y el total de letras en mayusculas.
* La variable 58 indical el tipo de email como "spam" o "no spam"

*Nº* | *Palabra1* | *Palabra2* | ...| *Palabra48* | *Caracter1* | *Caracter2*|...|*Prom1*| *Prom2*|*Prom3*|*Tipo*
--- | --- | --- | --- | --- | ---| --- | --- | --- | --- | --- | --- 
1 | 0.21 | 0 | ... | 0.13 | 0.778 | 0 | ... | 3.756|61   | 278 |   spam


# Fase 0
## Cantidad de Email vs. Cantidad de Spam en la muestra de datos
![Grafico 1](https://github.com/proyectohageo/multivar/blob/master/graf1.png)

## Porcentaje promedio de caracteres o palabras
![Grafico 2](https://github.com/proyectohageo/multivar/blob/master/graf2.png)

## Porcentaje relativo por palabra de Email
![Grafico 3](https://github.com/proyectohageo/multivar/blob/master/graf3.png)

## Porcentaje relativo por palabra de Spam
![Grafico 4](https://github.com/proyectohageo/multivar/blob/master/graf4.png)

## Visualizacion de conglomerados atípicos
![Grafico 5](https://github.com/proyectohageo/multivar/blob/master/andrews.png)

# Fase 1:
### Buscando correlaciones entre las palabras tomando su valor absoluto
```markdown
M <- abs(cor(datosSpam[,-58]))
``` 
### cada palabra tiene correlacion de 1 consigo misma, entonces remover la diagonal
```markdown
diag(M) <- 0
```
### ¿cuáles de las palabras tienen mayor correlación?
```markdown
which(M > 0.8, arr.ind=T)
       row col
num415  34  32
direct  40  32
num857  32  34
direct  40  34
num857  32  40
num415  34  40
```
### ¿Cuál es el nombre de las variables correlacionadas?
```markdown
names(spam)[c(34, 32)]
[1] "num415" "num857"
```
![Grafico 6](https://github.com/proyectohageo/multivar/blob/master/plot_var1_var2.png)

* El objetivo del ACP es de reducir la redundancia y comprimir la información
### Podriamos rotar los graficos(Sobre esto más adelante)

```markdown
X <- 0.71 * datosSpam$num415 + 0.71 * datosSpam$num857
Y <- 0.71 * datosSpam$num415 - 0.71 * datosSpam$num857
plot(X, Y)
```

![Grafico 7](https://github.com/proyectohageo/multivar/blob/master/rotar1.png)

### Para obtener los componentes principales utilizamos - prcomp de las variables con mas correlación
```markdown
subSpam <- spam[, c(34, 32)]
prComp <- prcomp(subSpam)
plot(prComp$x[, 1], prComp$x[, 2])
![Grafico 8](https://github.com/proyectohageo/multivar/blob/master/rotar_princomp1.png)

prComp$rotation
```
### Probando PCA en datos marcados como SPAM
```markdown
typeColor <- ((spam$type=="spam") * 1 + 1)
typeColor
prComp <- prcomp(log10(spam[,-58]+1))
```
# la primera componente capta mas datos que el segundo componente
```markdown
plot(prComp$x[,1], prComp$x[,2], col=typeColor, xlab="PrinComp1", ylab="PrinComp2")
```
![Grafico 9](https://github.com/proyectohageo/multivar/blob/master/princomp1.png)

```markdown
Syntax highlighted code block

# Header 1
## Header 2
### Header 3

- Bulleted
- List

1. Numbered
2. List

**Bold** and _Italic_ and `Code` text

[Link](url) and ![Image](src)
```

For more details see [GitHub Flavored Markdown](https://guides.github.com/features/mastering-markdown/).

### Jekyll Themes

Your Pages site will use the layout and styles from the Jekyll theme you have selected in your [repository settings](https://github.com/proyectohageo/multivar/settings). The name of this theme is saved in the Jekyll `_config.yml` configuration file.

### Support or Contact

Having trouble with Pages? Check out our [documentation](https://help.github.com/categories/github-pages-basics/) or [contact support](https://github.com/contact) and we’ll help you sort it out.
