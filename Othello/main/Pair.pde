/**
Clase quemodela una pareja de enteros
Auxiliar para guardar las posiciones del tablero.
**/
class Pair {
  
  private int x;
  private int y;
 
  Pair (int x, int y){
    this.x=x;
    this.y=y;
  }
  
  public void setFirst (int x){
    this.x=x;
  }
  
  public void setSecond (int y){
    this.x=y;
  }
  
  public int first() {
   return this.x; 
  }
  
  public int second() {
   return this.y; 
  }
  
}
