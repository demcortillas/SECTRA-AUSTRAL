# SECTRA-AUSTRAL

Este repositorio tiene el prop�sito de almacenar scripts �tiles para identificar vulnerabilidad
territorial en la comuna de Puerto Varas. Existen 4 scripts con el prop�sito de determinar Cantidad de
Personas, Escolaridad del o la jefe de hogar,  Cantidad de casas con materialidad aceptable, recuperable
e irrecuperable. 
>
>-Paquetes ocupados: rgdal, DBI, dplyr, raster, maptools, rgeos
>

>
> 1.Intro.R: 
>         Lee los datos espaciales, los filtra y los une mediante la funci�n bind().
>	  Posteriormente se conecta con la base de datos almacenada en formato .db.
>	  El prop�sito que tiene trabajar en dicho formato, es que R dispone de la
>	  librer�a DBI que lee dicho formato y no tiene la necesidad almacenar todos
>	  los datos en la memoria RAM. Por �ltimo se genera un script que almacena la
>	  la cantidad de personas por zona o localidad.
>

>
> se debe recalcar que siempre que se crea una variable agregada, se debe ordenar juntar
> con la columna de geoc�digos para el posterior cruce con informaci�n espacial.
>