/** Clase que odela el tablero del juego*/


class Tablero {
  int dimension;
  int[][] mundo;
  int turno, posibleX, posibleY;
  private ArrayList<Pair> positions = new ArrayList<Pair>();
  
  /**Constructor de la clase tablero
  *  @param d dimension que tendra el tablero
  */
  Tablero(int d) {
    turno =1;
    dimension = d;
    mundo = new int[dimension][dimension];
    mundo[dimension/2-1][dimension/2-1] = -1;
    mundo[dimension/2][dimension/2] = -1;
    mundo[dimension/2][dimension/2-1] = 1;
    mundo[dimension/2-1][dimension/2] = 1;
  }
  Tablero(int dimension, int[][] mundo, int turno, Pair posibles){
    this.dimension = dimension;
    this.mundo = new int[dimension][dimension];
    this.turno = turno; 
    this.posibleX = posibles.getX();
    this.posibleY = posibles.getY();
    
    //copiamos los tiros del original.
    for(int i = 0; i < dimension; i++){
      for(int j = 0; j < dimension; j++){
        this.mundo[i][j] = mundo[i][j] == 2? 0: mundo[i][j];
      }
    }
    //damos el nuevo tiro
    this.mundo[posibleX][posibleY] = 2; //= tablero.turno;
  }
  
  Tablero copia(Pair position){
    Tablero copia = new Tablero(dimension, mundo, turno, position);
    copia.positions = copia.getAvailable();
    return copia;
  }
  
  void turnoMaquina(){
    Nodo nodo = new Nodo(tablero, positions, true);
    minimax(nodo, 4, true);
    println(turno + " ------------>>> obtenemos x "+ greatValue.posibleX + " y "+ greatValue.posibleY);
    canPlay(greatValue.posibleX, greatValue.posibleY);
    mundo[greatValue.posibleX][greatValue.posibleY] = tablero.turno;
    paint(greatValue.posibleX, greatValue.posibleY);
    turno = tablero.turno*-1;
    tablero.reset();
    tablero.showAvailable();
    
  }
  
   /** Metodo que imprime en consola el tablero actual**/
  void printTablero(){
    for (int i = 0; i < mundo.length; i++) {         //this equals to the row 
           for (int j = 0; j < mundo[i].length; j++) {  
              print(mundo[j][i] + " ");
           }
           println(); //change line on console as row comes to end 
        }
        println("----------------------------");
    }
    
    /**
   * Cuenta la cantidad de fichas de un jugador
   * @return La cantidad de fichas de ambos jugadores en el tablero como vector, 
   * donde x = jugador1, y = jugador2
   */
  int valorheuristico() {
    int x = 0; //valor del usuario
    int y = 0; //valor demaquina
    for (int i = 0; i < dimension; i++)
      for (int j = 0; j < dimension; j++){
        if(mundo[i][j] == 1)
          x += 1;
        if(mundo[i][j] == 2)
          y += 1;
      }
    
    return y-x;
  }
  
  /** Metodo que dibuja todo el tablero, se incluye la posicion inicial del juego*/
  void display() {
    int desp = width/tablero.dimension;
    int despV = height/tablero.dimension;
    stroke(255);
    for(int i = 0; i < dimension + 1; i++) {
      line(desp*(i + 1), 0, desp*(i + 1), height);
      line(0, despV*i, width, despV*i);
    }
    for(int i = 0; i < dimension; i++) {
      for(int j = 0; j < dimension; j++) {
        if(mundo[i][j] == 1) {
          fill(0);
          noStroke();
          ellipse((i*desp) + (desp/2), (j*despV) + (despV/2), desp*3/4, despV*3/4);
        } if(mundo[i][j] == -1) {
          fill(255);
          noStroke();
          ellipse((i*desp) + (desp/2), (j*despV) + (despV/2), desp*3/4, despV*3/4);        
        } if(mundo[i][j] == 2) {
          fill(122);
          noStroke();
          ellipse((i*desp) + (desp/2), (j*despV) + (despV/2), desp*3/4, despV*3/4);        
        }if(mundo[i][j] == 0) {
          fill(77, 132, 75);
          noStroke();
          ellipse((i*desp) + (desp/2), (j*despV) + (despV/2), desp*3/4, despV*3/4);        
        }if(mundo[i][j] == 3) {
          fill(52, 235, 210);
          noStroke();
          ellipse((i*desp) + (desp/2), (j*despV) + (despV/2), desp*3/10, despV*3/10);
        }
        
       }
     }
   }
   
   ///////////////////////////////////////////     EMPIEZA METODOS DEVALIDACION Y FLIPEO ///////////////////////////////
   
   
/** Metodo que verifica si el norte es un movimiento valido*/
boolean checkNorth(int x, int y) {
  if (y==0)
    return false;
  if (mundo[x][y-1] == turno*-1) {
    for (int i = y-1; i>0; i--) {
      if (mundo[x][i-1] == 0)
        return false;
      if (mundo[x][i-1] == turno)
        return true;
     }
  }
  return false;
}

/** Metodo que verifica si el sur es un movimiento valido*/
boolean checkSouth(int x, int y) {
  if (y==7)
    return false;
  if (mundo[x][y+1] == turno*-1) {
    for (int i = y+1; i < dimension-1; i++) {
      if (mundo[x][i+1] == 0)
        return false;
      if (mundo[x][i+1] == turno)
        return true;
      }
  }
  return false;
}

/** Metodo que verifica si el oeste es un movimiento valido*/
boolean checkWest(int x, int y) {
  if (x==0)
    return false;
  if (mundo[x-1][y] == turno*-1) {
    for (int j = x-1; j>0; j--) {
      if (mundo[j-1][y] == 0)
        return false;
      if (mundo[j-1][y] == turno)
        return true;
     }
  }
  return false;
}

/** Metodo que verifica si el este es un movimiento valido*/
boolean checkEast(int x, int y) {
  if (x==7)
    return false;
  if (mundo[x+1][y] == turno*-1) {
    for (int j = x+1; j<dimension-1; j++) {
      if (mundo[j+1][y] == 0)
        return false;
      if (mundo[j+1][y] == turno)
        return true;
     }
  }
  return false;
}

/** Metodo que verifica si el noroeste es un movimiento valido*/
boolean checkNorthWest(int x, int y) {
  if (x==0 || y==0)
    return false;
  if (mundo[x-1][y-1] == turno*-1) {
    for (int i = x-1, j = y-1; i>0 && j>0; i--, j--) {
      if (mundo[i-1][j-1] == 0)
        return false;
      if (mundo[i-1][j-1] == turno)
        return true;
     }
  }
  return false;
}

/** Metodo que verifica si el sueroeste es un movimiento valido*/
boolean checkSouthWest(int x, int y) {
  if (x==0 || y==7)
    return false;
  if (mundo[x-1][y+1] == turno*-1) {
    for (int i = x-1, j = y+1; i>0 && j<dimension-1; i--, j++) {
      if (mundo[i-1][j+1] == 0)
        return false;
      if (mundo[i-1][j+1] == turno)
        return true;
     }
  }
  return false;
}

/** Metodo que verifica si el noreste es un movimiento valido*/
boolean checkNorthEast(int x, int y) {
  if (x==7 || y==0)
    return false;
  if (mundo[x+1][y-1] == turno*-1) {
    for (int i = x+1, j = y-1; i<dimension-1 && j>0; i++, j--) {
      if (mundo[i+1][j-1] == 0)
        return false;
      if (mundo[i+1][j-1] == turno)
        return true;
     }
  }
  return false;
}

/** Metodo que verifica si el sureste es un movimiento valido*/
boolean checkSouthEast(int x, int y) {
  if (x==7 || y==7)
    return false;
  if (mundo[x+1][y+1] == turno*-1) {
    for (int i = x+1, j = y+1; i<dimension-1 && j<dimension-1; i++, j++) {
      if (mundo[i+1][j+1] == 0)
        return false;
      if (mundo[i+1][j+1] == turno)
        return true;
     }
  }
  return false;
}

void paintNorth(int x, int a){
  for(int i = a; i >0; i--){
    mundo[x][i] = turno;
    if (turno==mundo[x][i-1])
        return;
  }
}

void paintSouth(int x, int a){
  for(int i = a; i <dimension; i++){
    mundo[x][i] = turno;
    if (turno==mundo[x][i+1])
        return;
  }
}

void paintEast(int a, int y){
  for(int i = a; i <dimension; i++){
    mundo[i][y] = turno;
    if (turno==mundo[i+1][y])
        return;
  }
}

void paintWest(int a, int y){
  for(int i = a; i >0; i--){
    mundo[i][y] = turno;
    if (turno==mundo[i-1][y])
        return;
  }
}

void paintNorthEast(int a, int b){
  for(int i = a, j = b; i<dimension && j>0; i++, j--){      
    mundo[i][j] = turno;
    if (turno==mundo[i+1][j-1])
        return;
  }
}

void paintNorthWest(int a, int b){
  for(int i = a, j = b; i>0 && j>0; i--, j--){      
    mundo[i][j] = turno;
    if (turno==mundo[i-1][j-1])
        return;
  }
}

void paintSouthEast(int a, int b){
  for(int i = a, j = b; i<dimension && j<dimension; i++, j++){      
    mundo[i][j] = turno;
    if (turno==mundo[i+1][j+1])
        return;
  }
}

void paintSouthWest(int a, int b){
  for(int i = a, j = b; i>0 && j<dimension; i--, j++){      
    mundo[i][j] = turno;
    if (turno==mundo[i-1][j+1])
        return;
  }
}


boolean canPlay(int posX , int posY) {
  
  if(mundo[posX][posY] == 2 || mundo[posX][posY] == 0 || mundo[posX][posY] == 3){
  
  n = checkNorth(posX, posY);
  s = checkSouth(posX, posY);
  e = checkEast(posX, posY);
  w = checkWest(posX, posY);
  sw = checkSouthWest(posX, posY);
  se = checkSouthEast(posX, posY);
  nw = checkNorthWest(posX, posY);
  ne = checkNorthEast(posX, posY);
   if (n || s || e || w || sw || se || nw || ne){
    return true;
   }
}
  
  return false;
}

void paint(int posX, int posY){
   if (n)
     paintNorth(posX,posY);
     
   if (s)
     paintSouth(posX,posY);
     
   if (e)
     paintEast(posX,posY);
     
   if (w)
     paintWest(posX,posY);
     
   if (ne)
     paintNorthEast(posX,posY);
   
   if (nw)
     paintNorthWest(posX,posY);
   
   if (se)
     paintSouthEast(posX,posY);
   
   if (sw)
     paintSouthWest(posX,posY);
   
   tablero.printTablero();
}

void reset (){
  n=s=e=w=sw=se=nw=ne=false;
  for (Pair p : positions) {
    if (mundo[p.getX()][p.getY()]!=-1 && mundo[p.getX()][p.getY()]!=1)
    mundo[p.getX()][p.getY()]=0;
  }
  positions.clear();
}

public ArrayList<Pair> getAvailable (){
 for(int i = 0; i< dimension; i++ ){
   for(int j = 0; j< dimension; j++){
     if (canPlay(i,j)){
       Pair p = new Pair(i,j); 
       positions.add(p);
     }
   }
 }
 return positions;  
}

public void showAvailable(){
  ArrayList<Pair> l = getAvailable();
  println("Posiciones Disponibles:");
  for (Pair p : l) {
    print("("+ p.getX()+","+p.getY()+")");
    mundo[p.getX()][p.getY()]=3;
  }
  print("\n");
}

Tablero greatValue = null;
int minimax(Nodo nodo, int profundidad, boolean maximizingPlayer){
  nodo.setHijos();
    if(profundidad == 0 || nodo.hijos.size() == 0){
      return nodo.tablero.valorheuristico();
    }
    int value;
    if(maximizingPlayer){
      value = -1000;
      for(Nodo t : nodo.hijos){
        int tValue = minimax(t, profundidad-1, false);
        if(!nodo.root)
          greatValue = tValue > value? t.tablero : nodo.tablero;
        return value = max(value, tValue);
      }
      return value; 
    }else{
      value = +1000;
      for(Nodo t : nodo.hijos){
        int tValue = minimax(t, profundidad-1, false);
        if(!nodo.root)
          greatValue = tValue < value? t.tablero : nodo.tablero;
        return value = min(value, tValue);
      } 
    }
    return value;
  }
} 
