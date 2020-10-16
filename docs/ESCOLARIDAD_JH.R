# Conexion y filtro por comuna

con                 <- dbConnect(RSQLite::SQLite(), "MVE.db") #Conexión con la base de datos
DB                  <- tbl(con, "PERSONAS") # conexión con la tabla de personas
Pto_varas_personas <- DB %>% filter(COMUNA==10109) %>% collect()
Pto_varas_personas <- as.data.frame(Pto_varas_personas)

JH <- subset(Pto_varas_personas, P07 == 1)
JH <- JH[JH$ESCOLARIDAD != 99,]

EJH12<-NULL
GEOCODIGO <- unique(JH$ID_ZL_PER)
for(i in 1:length(GEOCODIGO)){
  GC <- GEOCODIGO[i]
  A  <- subset(JH,ID_ZL_PER == GC)
  q<-0
  p<-0
  for(j in 1:dim(A)[1]){
    p <- p + 1
    if(A$ESCOLARIDAD[j] < 12){
      q <- q + 1
    }
  }
  EJH12<-c(EJH12,(q/p)*100)
}

PEJH12<-data.frame(GEOCODIGO,EJH12)




