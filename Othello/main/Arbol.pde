class Nodo{
  ArrayList<Nodo> hijos;
  Tablero tablero;
  ArrayList<Pair> posiciones;
  boolean root; //Esto solo nos va a ayudar para que cuando regresemos el tablero con mejor valor devolvamos al hijo.
  
  Nodo(Tablero tablero,  ArrayList<Pair> positions, boolean root ){
    this.tablero = tablero;
    this.posiciones = (ArrayList<Pair>)positions.clone();
    hijos = new ArrayList<Nodo>(positions.size());
    this.root = root;
    
  }
  
  void setHijos(){
    for(int i = 0; i < posiciones.size(); i++){
      Tablero copia = this.tablero.copia(posiciones.get(i));
      Nodo hijo = new Nodo(copia, copia.positions, false);
      this.hijos.add(hijo);
    }
  }
  
}
