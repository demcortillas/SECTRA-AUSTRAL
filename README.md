# SECTRA-AUSTRAL

Este repositorio tiene el propósito de almacenar scripts útiles para identificar vulnerabilidad
territorial en la comuna de Puerto Varas. Existen 4 scripts con el propósito de determinar Cantidad de
Personas, Escolaridad del o la jefe de hogar,  Cantidad de casas con materialidad *aceptable*, *recuperable*
e *irrecuperable*. 

>Paquetes ocupados `rgdal`, `DBI`, `dplyr`, `raster`, `maptools`, `rgeos`



## Intro.R

>Lee los datos espaciales, los filtra y los une mediante la función bind().
>Posteriormente se conecta con la base de datos almacenada en formato `.db`.
>El propósito que tiene trabajar en dicho formato, es que R dispone de la
>librería DBI que lee dicho formato y no tiene la necesidad almacenar todos
>los datos en la memoria RAM. Por último se genera un script que almacena la
>la cantidad de personas por zona o localidad.

*se debe recalcar que siempre que se crea una variable agregada, se debe ordenar juntar
con la columna de geocódigos para el posterior cruce con información espacial.*

## ESCOLARIDAD_JH

>En este script se hace conexión con la base de datos, pero con la tabla de
>**PERSONAS** en vez de **VIVIENDAS** u **HOGARES**. El script permite calcular
> la escolaridad del jefe de hogar si hacer un conteo de cuáles son menores a
> 12 años. Esto se agrega en forma porcentual a nivel de zona.

## Materialidad_vivienda

> Se conecta a la table de **VIVIENDAS** y el script consiste en calcular la 
> cantidad de viviendas aceptable, recuperables e irrecuperables por cada zona.

## Indicadores

> En esta hoja se cruzan las tablas mediante el geocódigo luego se exportan
> los resultados mediante la función `writeOGR()`.