library(rgdal)
library(DBI)
library(dplyr)
library(raster)
library(maptools)
library(rgeos)
options(scipen=999)

# Conexion y filtro por comuna

con                 <- dbConnect(RSQLite::SQLite(), "MVE.db") #Conexión con la base de datos
DB                  <- tbl(con, "VIVIENDAS") # conexión con la tabla de personas
Pto_varas_viviendas <- DB %>% filter(COMUNA==10109) %>% collect()

unique(Pto_varas_viviendas$P03A) #filtrar valores 98 y 99
Pto_varas_viviendas<-as.data.frame(Pto_varas_viviendas) # pasar a ambiente dataframe

Pto_varas_viviendas <- Pto_varas_viviendas[Pto_varas_viviendas$P03A != 98 || Pto_varas_viviendas$P03A != 99  ,]
Pto_varas_viviendas <- Pto_varas_viviendas[Pto_varas_viviendas$P03B != 98 || Pto_varas_viviendas$P03B != 99  ,]
Pto_varas_viviendas <- Pto_varas_viviendas[Pto_varas_viviendas$P03C != 98 || Pto_varas_viviendas$P03C != 99  ,]

#Indice de Materialidad

#P03A - Muro exterior:

#Aceptable: hormigon(1),albañileria(2) y tabique forrado por ambas caras(3)
MA <- c(1,2,3)

#Recuperable: Tabique sin forro interior(4),adobe-barro-quincha-pirca u otro material tradicional(5)
MR <- c(4,5)

#Irrecuperable:Materiales precarior(lata,carton,plastico,etc)(6)
MI <-c(6)

#P03B - Techo:

#Aceptable: Tejas o tejuelas(1), losa hormigón(2),planchas metálicas o fibrocemento(pizarreño)(3)
TA <- c(1,2,3)

#Recuperable:Fanolita o plancha de fieltro embreado(4), paja-coirón-totora-caña(5)
TR <- c(4,5)

#Irrecuperable: Materiales precarios (lata, cartón, plástico)(6) o vivienda sin techo (7)
TI <- c(6,7)

#P03C - Piso:

#Aceptable: Parquet-piso flotante-cerámico-madera-alfombra-flexit-cubrepiso u otro similar-sobre radier o vigas de madera(1)
PA<-c(1)

#Recuperable: Radier sin revestimiento(2),baldosa de cemento(3),capa de cemento sobre tierra(4)
PR<-c(2,3,4)

#Irrecuperable: Tierra(5)
PI<-c(5)

CATEGORIA <- NULL

for(j in 1:dim(Pto_varas_viviendas)[1]){
  A <- Pto_varas_viviendas[j,11:13]
  if((A[1] %in% MA) & (A[2] %in% TA) & (A[3] %in% PA)){
    CATEGORIA <- c( CATEGORIA , 'ACEPTABLE' )
  } else if((A[1] %in% MI) || (A[2] %in% TI) || (A[3] %in% PI)){
    CATEGORIA <- c(CATEGORIA,'IRRECUPERABLE') 
  } else {
    CATEGORIA <- c(CATEGORIA,'RECUPERABLE')
  }
}

### Agregación a nivel de zona/localidad

Pto_varas_viviendas[,14] <- CATEGORIA
colnames(Pto_varas_viviendas)[14]<- "MATERIALIDAD"

GEOCODIGO<-unique(Pto_varas_viviendas$ID_ZL_VIV)
PA <- NULL
PR <- NULL
PI <- NULL

for(i in 1:length(GEOCODIGO)){
  GC = GEOCODIGO[i]
  A <- subset(Pto_varas_viviendas,ID_ZL_VIV == GC)
  ACEP <- 0
  REC  <- 0
  IRR  <- 0
  for(j in 1:dim(A)[1]){
    if(A[j,14]=="ACEPTABLE"){ACEP<-ACEP+1}
    if(A[j,14]=="RECUPERABLE"){REC<-REC+1}
    if(A[j,14]=="IRRECUPERABLE"){IRR<-IRR+1}
  }
  PA<-c(PA,ACEP)
  PR<-c(PR,REC)
  PI<-c(PI,IRR)
}

MAT<-data.frame(GEOCODIGO,PA,PR,PI)






