/**Clase que modela un árbol n-ario cuyos objetos almacenados (T) son tableros de juego*/

import java.util.ArrayList;
import java.util.List;

public class Nodos<T> {
    List<Nodos<T>> hijos = new ArrayList<Nodos<T>>();
    Nodos<T> padre = null;
    T datos = null;
    //variable auxiliar para el algoritmo minimax
    float valor=0;

    /**Constructor de un nodo a partir de un tablero de juego
    *@param tablero de juego a almacenar
    */
    public Nodos(T datos) {
        this.datos = datos;
    }

    /**COnstructor de un nodo a partir de un tablero, y un nodo padre
    *@param tablero de juego a almacenar
    *@param padre del nodo
    */
    public Nodos(T datos, Nodos<T> padre) {
        this.datos = datos;
        this.padre = padre;
    }

    /**Metodo que obtiene todos los hijos de un nodo
    *@return lista de hijos del nodo
    */
    public List<Nodos<T>> getHijos() {
        return hijos;
    }

    /**Metodo que establece el padre de un nodo
    *@param nodo que sera el padre
    */
    public void setPadre(Nodos<T> padre) {
        padre.addHijo(this);
        this.padre = padre;
    }

    /**Metodo que agrega un tablero como un hijo
    *@param tablero que será encapsulado en un nodo hijo para agregarlo
    */
    public void addHijo(T datos) {
        Nodos<T> hijo = new Nodos<T>(datos);
        hijo.setPadre(this);
    }

    /**Metodo que agrega un nodo como hijo
    *@param nodo hijo a agregar
    */
    public void addHijo(Nodos<T> hijo) {
        this.hijos.add(hijo);
        hijo.padre = this;
    }

    /**Obtiene el tablero encapsulado dentro de un nodo
    *@return tablero encapsulado en el nodo
    */
    public T getDatos() {
        return this.datos;
    }

    /**Establece un tablero en un nodo
    *@param tablero a agregar
    */
    public void setDatos(T datos) {
        this.datos = datos;
    }

    /**Metodo para saber si un nodo es raiz
    *@return True si el nodo es raiz, false en caso contrario
    */
    public boolean esRaiz() {
        return (this.padre == null);
    }

    /**Metodo para saber si un nodo es hoja
    *@return True si el nodo es hoja, false en caso contrario
    */
    public boolean esHoja() {
        if(this.hijos.size() == 0) 
            return true;
        else 
            return false;
    }

    /**Metodo para eliminar el padre de un nodo*/
    public void removePadre() {
        this.padre = null;
    }
 
    /**Metodo que devuelve el valor necesario para el algoritmo minimax
    *@return valor del nodo para el algoritmo minimax
    */
    public float getValor(){
      return valor;
    }
}
