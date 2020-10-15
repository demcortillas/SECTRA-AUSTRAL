MAT
PEJH12
CANT_PER

merge1<-merge(x=MAT,y=PEJH12,x.by="GEOCODIGO",y.by="GEOCODIGO")
merge2<-merge(x=merge1,y=CANT_PER,x.by="GEOCODIGO",y.by="GEOCODIGO")

### --- Cruzar la data mediante columna GEOCODIGO

FINAL_SHP <- merge(x = Pto_varas_sp, y = merge2, by.x="GEOCODIGO",by.y="GEOCODIGO") ### JOIN
writeOGR(obj=FINAL_SHP, dsn="out", layer="FINAL", driver="ESRI Shapefile",overwrite_layer = TRUE)

