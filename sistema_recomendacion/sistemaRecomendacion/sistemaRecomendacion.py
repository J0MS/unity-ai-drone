from tkinter import *
from tkinter import scrolledtext
from algoritmoRecomendacion import *
import webbrowser
import tkHyperlinkManager
from functools import partial
import numpy as np

#Cargamos el dataset y creamos la tabla con los datos, ademas inicializamos la matriz de correlacion entre prodcutos
itemRatings = crear_tabla_de_datos()
corrMatrix = crear_matriz_correlacion(itemRatings)

#creamos los elementos que tendra nuestra interfaz
window = Tk()
window.geometry('1024x400') #tamano de la ventana
window.title("Sistema de recomendacion de productos de software en Amazon")

head = Label(window, text="Ingresa el ID de un usuario (se encuentran en usuarios.txt): ")
head.place(x=300, y=0)
#cuadro de texto donde se ingresa el id del usuario
user = Entry(window, width=30)
user.place(x=380, y=30)

#Metodo que define el comportmaniento del boton "Recomendar"
def clicked():
    userRatings.delete(1.0,END)
    userRecomends.delete(1.0,END)
    #obtenemos los articulos que ha puntuado el usuario
    aux = get_user_ratings(user.get(), itemRatings)
    valuesUserRatings = pd.DataFrame({'Producto':"https://www.amazon.com/dp/" + aux.index, 'Calificacion':aux.values})
    alto, ancho = valuesUserRatings.shape
    #insertamos los datos en el respectivo scroll text
    userRatings.insert(INSERT, "               Producto                      Calificacion otorgada\n\n")
    for i in range(0, alto):
        item = valuesUserRatings['Producto'][i]
        rating = valuesUserRatings['Calificacion'][i]
        userRatings.insert(INSERT, item,
            hyperlink1.add(partial(webbrowser.open, item)))
        userRatings.insert(INSERT, "                   " + str(rating) + "\n\n")

    #obtenemos las recomendaciones para el usuario
    aux2 = obtener_recomendaciones(user.get(), itemRatings, corrMatrix)
    valuesUserRecomends = pd.DataFrame({'Producto':"https://www.amazon.com/dp/"+aux2.index, 'Similitud':aux2.values})
    alto2, ancho2 = valuesUserRecomends.shape
    #insertamos los datos en el respectivo scroll text
    userRecomends.insert(INSERT, "               Producto                         Nivel de similitud\n\n")
    for i in range(0, alto2):
        item = valuesUserRecomends['Producto'][i]
        rating = valuesUserRecomends['Similitud'][i]
        userRecomends.insert(INSERT, item,
                           hyperlink2.add(partial(webbrowser.open, item)))
        userRecomends.insert(INSERT, "            " + str(rating) + "\n\n")

        
btn = Button(window, text="Recomendar", command=clicked)
btn.place(x=450, y= 60)

labelUserRatings = Label(window, text="El usuario ha comprado los siguientes productos y los ha calificado: ")
labelUserRatings.place(x=300, y=100)

#scroll text donde de mostraran los items que ha puntuado el usuario
values = scrolledtext.ScrolledText(window,width=80,height=5)
values.place(x=200, y=120)

userRatings = Text(values, width=75, height=5)
userRatings.pack()
#nos permite convertir texto en hipervinculos
hyperlink1 = tkHyperlinkManager.HyperlinkManager(userRatings)


labelUserRecomends = Label(window, text="Los productos recomendados para el usuario son: ")
labelUserRecomends.place(x=340, y=230)

#scroll text donde se mostraran los items recomendados para el usuario
valuesRecomends = scrolledtext.ScrolledText(window,width=80,height=5)
valuesRecomends.place(x=200, y=260)

userRecomends = Text(valuesRecomends, width=75, height=5)
userRecomends.pack()
hyperlink2 = tkHyperlinkManager.HyperlinkManager(userRecomends)

#mantenemos dibujada la ventana
window.mainloop()
