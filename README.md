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

## ESCOLARIDAD_JH.R

>En este script se hace conexi�n con la base de datos, pero con la tabla de
>**PERSONAS** en vez de **VIVIENDAS** u **HOGARES**. El script permite calcular
> la escolaridad del jefe de hogar si hacer un conteo de cu�les son menores a
> 12 a�os. Esto se agrega en forma porcentual a nivel de zona.

## Materialidad_vivienda.R

> Se conecta a la table de **VIVIENDAS** y el script consiste en calcular la 
> cantidad de viviendas aceptable, recuperables e irrecuperables por cada zona.

## Indicadores.R

> En esta hoja se cruzan las tablas mediante el geoc�digo luego se exportan
> los resultados mediante la funci�n `writeOGR()`.

###### Nota

Los scripts deben ejecutarse en orden `Intro.R`,`ESCOLARIDAD_JH.R`,`Indicadores.R` y finalmente la base de datos que
se debe ejecutar debe descargarse de [aqu�](https://drive.google.com/file/d/1ROtWwX4J4fWwnfj7QFe9iStDdAf9jF4p/view?usp=sharing).
Para mayor detalle de informaci�n del censo [click aqu�](https://github.com/demcortillas/CENSO2017).