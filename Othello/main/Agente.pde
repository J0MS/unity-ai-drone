/**Clase que modela un agente jugador para Othello*/
public class Agente{
  
 public Nodos<Tablero> arbolDecision;
 Heuristica heuristica;
 
 /**COnstructor del agente a partir de un tablero de juego
 *@param tablero a partir del cual actuara el agente
 */
 public Agente(Tablero raiz){
   arbolDecision = new Nodos(new Tablero(raiz));
   heuristica = new Heuristica();
 }
 
 /**Calcula el arbol de busqueda
 *@param nodo correspondiente al tablero padre del arbol
 *@param profundidad maxima que tendra el arbol
 */
 public void calculaArbol(int turno, Nodos<Tablero> padre , int profundidad){
     ArrayList<Pair> jugadas;
    if(profundidad > 0){
      Tablero tablero = padre.getDatos(); // tomamos el tablero padre
      jugadas = tablero.getAvailable(); // calculamos las posibles jugadas con el turno actual
      if(!jugadas.isEmpty()){ //verificamos que el jugador en turno pueda tirar
        for(Pair z : jugadas){
          Tablero aux = new Tablero(tablero); // Hacemos una copia del tablero padre
          aux.canPlay(z.first(), z.second()); //verificamos posibles lugares para tirar
          aux.mundo[z.first()][z.second()] = turno; // tiramos 
          aux.paint(z.first() , z.second()); // hacemos los cambios de colores
          aux.resetAll(); //eliminamos las opciones no utilizadas
          padre.addHijo(aux); // lo agregamos al arbol
        }
        
         //Para cada uno de los hijos calculamos su arbol 
        for(Nodos<Tablero> hijo : padre.getHijos()){
          hijo.getDatos().turno *= -1; //cambiamos el turno en los hijos
          calculaArbol(turno, hijo , profundidad -1); 
        } 
      }
    }    
  }
  
  //Función que devuelve el valor más grande dentro del arbol.
  public float max_valor(Nodos<Tablero> nodo){
    if(nodo.esHoja()){
      nodo.valor = heuristica.utilidad(nodo.getDatos());
      return nodo.getValor();
    }else{
      float val = -50000;
      List<Nodos<Tablero>> hijos = nodo.getHijos();
      for(Nodos n : hijos){
        val = Math.max(val, min_valor(n));
      }
      nodo.valor = val;
      return val;
    }
  }
  
  //Función que devuelve el valor más pequeño dentro del arbol.
  public float min_valor(Nodos<Tablero> nodo){
    if(nodo.esHoja()){
      nodo.valor = heuristica.utilidad(nodo.getDatos());
      return nodo.getValor();
    }else{
      float val = 50000;
      List<Nodos<Tablero>> hijos = nodo.getHijos();
      for(Nodos n : hijos){
        val = Math.min(val,max_valor(n));
      }
      nodo.valor = val;
      return val;
    }
  }
  
  /**
  Función MiniMax.
  */
  public Pair miniMax(Nodos<Tablero> nodoInicial){
    float vinicial = max_valor(nodoInicial);
    Pair co;
    int alt=0;
    int anc=0;
    Tablero ac=null;
    List<Nodos<Tablero>> hijos = nodoInicial.getHijos();
    for(Nodos<Tablero> n : hijos){
      if(n.getValor()==vinicial){
        ac = n.getDatos();
      }
    }
    if(ac!=null){
      int[][] mundo1 = nodoInicial.getDatos().mundo;
      int[][] mundo2 = ac.mundo;
      for(int i=0;i<nodoInicial.getDatos().dimension;i++){
        for(int j=0;j<nodoInicial.getDatos().dimension;j++){
          if((mundo1[i][j] == 0 || mundo1[i][j] == 3) && mundo2[i][j]==-1){
            alt=i;
            anc=j;
          }
        }
      }
    }
    co = new Pair(alt, anc);
    return co;
  }//Aquí termina minimax
  
}
