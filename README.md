# SECTRA-AUSTRAL

Este repositorio tiene el propósito de almacenar scripts útiles para identificar vulnerabilidad
territorial en la comuna de Puerto Varas. Existen 4 scripts con el propósito de determinar Cantidad de
Personas, Escolaridad del o la jefe de hogar,  Cantidad de casas con materialidad aceptable, recuperable
e irrecuperable. 

>Paquetes ocupados rgdal, DBI, dplyr, raster, maptools, rgeos



## Intro.R: 

>Lee los datos espaciales, los filtra y los une mediante la función bind().
>Posteriormente se conecta con la base de datos almacenada en formato .db.
>El propósito que tiene trabajar en dicho formato, es que R dispone de la
>librería DBI que lee dicho formato y no tiene la necesidad almacenar todos
>los datos en la memoria RAM. Por último se genera un script que almacena la
>la cantidad de personas por zona o localidad.

*se debe recalcar que siempre que se crea una variable agregada, se debe ordenar juntar
con la columna de geocódigos para el posterior cruce con información espacial.*
