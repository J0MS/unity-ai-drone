El programa esta escrito en python 3.6
Para el correcto funcionamiento es necesario instalar las bibliotecas de pandas, numpy

EL programa hace recomendaciones de productos de software vendidos a traves de Amazon.com.

EL dataset se obtuvo de https://nijianmo.github.io/amazon/index.html, utilizando el subset "small" 5-core de Software, el cual contiene 12,085 calificaciones de usarios, además de que cada usuario ha calificado al menos 5 productos.

La interfaz principal del programa es el archivo "sistemaRecomendacion.py" por lo que para ejecutarlo debemos posicionarnos en una terminal dentro de la carpeta que contiene los archivos y escribir la orden: python3 sistemaRecomendacion.py.

La interfaz del programa pide en primer lugar un id correspondiente a un usuario dentro de la base de datos. Estos id se pueden obtener del archivo "usuarios.txt", basta con copiar y pegar alguno de ellos.

Al ingresar el id de un usario se debe presionar el boton "recomendar", lo cual desplegara en el primer scroll text los productos que el usuario ha comprado y calificado. En el segundo scroll text se encuentran las recomendaciones que el sistema da para dicho usuario, a partir de los datos anteriores.
