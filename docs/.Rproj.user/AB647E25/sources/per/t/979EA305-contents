library(rgdal)
library(DBI)
library(dplyr)
library(raster) #contiene función union
library(sf)

#### --- Preparación datos espaciales

Zonas_urbanas <- readShapePoly(fn='R10/ZONA_C17.shp', IDvar=NULL)
Localidades_rurales <- readShapePoly(fn='R10/LOCALIDAD_C17.shp', IDvar=NULL)

names(Zonas_urbanas) # revisamos el atributo o columna de cada una de las capas
names(Localidades_rurales)

#### --- Filtrar por comuna -> Pto varas: 10109 <- fuente: manual del usuario censista

PtoV_urb <- subset(Zonas_urbanas,COMUNA == 10109)
PtoV_rur <- subset(Localidades_rurales,COMUNA == 10109)

PtoV_rur<-spChFIDs(PtoV_rur, paste("PtoV_rur", row.names(PtoV_rur), sep=".")) # les entrega una ID
PtoV_urb<-spChFIDs(PtoV_urb, paste("PtoV_urb", row.names(PtoV_urb), sep="."))

#### Juntar los dos .shp

Pto_varas_sp <- bind(PtoV_urb, PtoV_rur) # funcion del paquete raster que los une y hace coincidir por columna. Si no tiene valor en la columna pone NA
View(Pto_varas_sp@data)

#### --- Microdatos

con <- dbConnect(RSQLite::SQLite(), "D:/PROJECTS/db/CENSO2017/microdatos/MVE.db") #Conexión con la base de datos
DB <- tbl(con, "PERSONAS") # conexión con la tabla de personas

#### --- Filtrar por microdatos de comuna

Pto_varas <- DB %>% filter(COMUNA==10109) %>% collect() #desde aquí podemos tratarlo como dataframe típico

### ¿cuántas personas hay por zona o por localidad?

GEOCODIGO<-unique(Pto_varas$ID_ZONA_LOC)
CANT_PER<-NULL

for(localidad in unique(Pto_varas$ID_ZONA_LOC)){
  A<-subset(Pto_varas,ID_ZONA_LOC == localidad)
  CANT_PER<-c(CANT_PER,dim(A)[1])
}

data<-data.frame(GEOCODIGO=as.character(GEOCODIGO),CANT_PER)

hist(data$GEOCODIGO)



### --- cruzar la data mediante columna GEOCODIGO

Pto_varas<-merge(x=Pto_varas_sp,y=data,by.x="GEOCODIGO",by.y="GEOCODIGO")

### exportarlo

writeOGR(obj=Pto_varas, dsn="out", layer="Pto_varas", driver="ESRI Shapefile")









