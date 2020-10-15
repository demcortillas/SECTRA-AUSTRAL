library(rgdal)
library(DBI)
library(dplyr)
library(raster)
library(maptools)
library(rgeos)
options(scipen=999) # para que no haya notacion cientifica

#### --- Preparación datos espaciales

Zonas_urbanas <- readShapePoly(fn='R10/ZONA_C17.shp', IDvar=NULL,proj4string=crs("+init=epsg:4674"))
Localidades_rurales <- readShapePoly(fn='R10/LOCALIDAD_C17.shp', IDvar=NULL,proj4string=crs("+init=epsg:4674"))

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

con <- dbConnect(RSQLite::SQLite(), "MVE.db") #Conexión con la base de datos
DB <- tbl(con, "PERSONAS") # conexión con la tabla de personas

#### --- Filtrar por microdatos de comuna

Pto_varas <- DB %>% filter(COMUNA==10109) %>% collect() #desde aquí podemos tratarlo como dataframe típico

#### --- ¿Cuántas personas hay por zona o por localidad?

GEOCODIGO<-unique(Pto_varas$ID_ZL_PER)
CANT_PER<-NULL

for(loc in unique(Pto_varas$ID_ZL_PER)){
  A<-subset(Pto_varas,ID_ZL_PER == loc)
  CANT_PER<-c(CANT_PER,dim(A)[1])
}


CANT_PER<-data.frame(GEOCODIGO,CANT_PER)

#hist(data$CANT_PER)

### --- Cruzar la data mediante columna GEOCODIGO

#Pto_varas1 <- merge(x = Pto_varas_sp, y = data, by.x="GEOCODIGO",by.y="GEOCODIGO") ### JOIN
#writeOGR(obj=Pto_varas1, dsn="out", layer="Pto_varas_no-project", driver="ESRI Shapefile",overwrite_layer = TRUE)

### --- Reproject

#Pto_varas2<-spTransform(Pto_varas1,CRS("+init=epsg:32719")) #reproyectar
#writeOGR(obj=Pto_varas2, dsn="out", layer="Pto_varas_project", driver="ESRI Shapefile",overwrite_layer = TRUE)














