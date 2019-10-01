/**Clase que modela los pares ordenados x,y que corresponden a una coordenada del tablero de juego*/
class Pair {
  
  private int x; //primer valor del par ordenado
  private int y; //segundo valor del par ordenado
 
 /**Constructor de un par odenado
 *@param x primer valor
 *@param y segundo valor
 */
  Pair (int x, int y){
    this.x=x;
    this.y=y;
  }
  
  /**Establece el primer valor del par ordenado
  *@param x primer valor del par (x,y)
  */
  public void setFirst (int x){
    this.x=x;
  }
  
  /**Establece el segundo valor del par ordenado
  *@param y segundo valor del par ordenado (x,y)
  */
  public void setSecond (int y){
    this.x=y;
  }
  
  /**Obtiene el valor del componente x
  */
  public int first() {
   return this.x; 
  }
  
  /**Obtiene el valor del componente y
  */
  public int second() {
   return this.y; 
  }
 
  /**Metodo para imprimir en consola los valores de cada par ordenado
  */
  @Override
   public String toString(){
     return "renglon: "+(y)+", "+"columna: "+x;
   }
  
}
