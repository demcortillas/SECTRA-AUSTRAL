# SECTRA-AUSTRAL

Este repositorio tiene el prop�sito de almacenar scripts �tiles para identificar vulnerabilidad
territorial en la comuna de Puerto Varas. Existen 4 scripts con el prop�sito de determinar Cantidad de
Personas, Escolaridad del o la jefe de hogar,  Cantidad de casas con materialidad *aceptable*, *recuperable*
e *irrecuperable*. 

>Paquetes ocupados `rgdal`, `DBI`, `dplyr`, `raster`, `maptools`, `rgeos`



## Intro.R

>Lee los datos espaciales, los filtra y los une mediante la funci�n bind().
>Posteriormente se conecta con la base de datos almacenada en formato `.db`.
>El prop�sito que tiene trabajar en dicho formato, es que R dispone de la
>librer�a DBI que lee dicho formato y no tiene la necesidad almacenar todos
>los datos en la memoria RAM. Por �ltimo se genera un script que almacena la
>la cantidad de personas por zona o localidad.

*se debe recalcar que siempre que se crea una variable agregada, se debe ordenar juntar
con la columna de geoc�digos para el posterior cruce con informaci�n espacial.*

## ESCOLARIDAD_JH

>En este script se hace conexi�n con la base de datos, pero con la tabla de
>**PERSONAS** en vez de **VIVIENDAS** u **HOGARES**. El script permite calcular
> la escolaridad del jefe de hogar si hacer un conteo de cu�les son menores a
> 12 a�os. Esto se agrega en forma porcentual a nivel de zona.

## Materialidad_vivienda

> Se conecta a la table de **VIVIENDAS** y el script consiste en calcular la 
> cantidad de viviendas aceptable, recuperables e irrecuperables por cada zona.

## Indicadores

> En esta hoja se cruzan las tablas mediante el geoc�digo luego se exportan
> los resultados mediante la funci�n `writeOGR()`.