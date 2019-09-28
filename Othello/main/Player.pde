class Player {
  
  private Tablero tablero;
  private boolean n, s, e, w, sw, se, nw, ne;
  ArrayList<Pair> positions = new ArrayList<Pair>();
  int numFichas;
  
  public Player (Tablero tablero) {
    this.tablero = tablero;
  }
  
  public void setNumFichas (int fichas) {
    this.numFichas = fichas;
  }

  
/** Metodo que verifica si el norte es un movimiento valido*/
boolean checkNorth(int x, int y) {
  if (y==0)
    return false;
  if (tablero.mundo[x][y-1] == tablero.turno*-1) {
    for (int i = y-1; i>0; i--) {
      if (tablero.mundo[x][i-1] == 0)
        return false;
      if (tablero.mundo[x][i-1] == tablero.turno)
        return true;
     }
  }
  return false;
}

/** Metodo que verifica si el sur es un movimiento valido*/
boolean checkSouth(int x, int y) {
  if (y==7)
    return false;
  if (tablero.mundo[x][y+1] == tablero.turno*-1) {
    for (int i = y+1; i < tablero.dimension-1; i++) {
      if (tablero.mundo[x][i+1] == 0)
        return false;
      if (tablero.mundo[x][i+1] == tablero.turno)
        return true;
      }
  }
  return false;
}

/** Metodo que verifica si el oeste es un movimiento valido*/
boolean checkWest(int x, int y) {
  if (x==0)
    return false;
  if (tablero.mundo[x-1][y] == tablero.turno*-1) {
    for (int j = x-1; j>0; j--) {
      if (tablero.mundo[j-1][y] == 0)
        return false;
      if (tablero.mundo[j-1][y] == tablero.turno)
        return true;
     }
  }
  return false;
}

/** Metodo que verifica si el este es un movimiento valido*/
boolean checkEast(int x, int y) {
  if (x==7)
    return false;
  if (tablero.mundo[x+1][y] == tablero.turno*-1) {
    for (int j = x+1; j<tablero.dimension-1; j++) {
      if (tablero.mundo[j+1][y] == 0)
        return false;
      if (tablero.mundo[j+1][y] == tablero.turno)
        return true;
     }
  }
  return false;
}

/** Metodo que verifica si el noroeste es un movimiento valido*/
boolean checkNorthWest(int x, int y) {
  if (x==0 || y==0)
    return false;
  if (tablero.mundo[x-1][y-1] == tablero.turno*-1) {
    for (int i = x-1, j = y-1; i>0 && j>0; i--, j--) {
      if (tablero.mundo[i-1][j-1] == 0)
        return false;
      if (tablero.mundo[i-1][j-1] == tablero.turno)
        return true;
     }
  }
  return false;
}

/** Metodo que verifica si el sueroeste es un movimiento valido*/
boolean checkSouthWest(int x, int y) {
  if (x==0 || y==7)
    return false;
  if (tablero.mundo[x-1][y+1] == tablero.turno*-1) {
    for (int i = x-1, j = y+1; i>0 && j<tablero.dimension-1; i--, j++) {
      if (tablero.mundo[i-1][j+1] == 0)
        return false;
      if (tablero.mundo[i-1][j+1] == tablero.turno)
        return true;
     }
  }
  return false;
}

/** Metodo que verifica si el noreste es un movimiento valido*/
boolean checkNorthEast(int x, int y) {
  if (x==7 || y==0)
    return false;
  if (tablero.mundo[x+1][y-1] == tablero.turno*-1) {
    for (int i = x+1, j = y-1; i<tablero.dimension-1 && j>0; i++, j--) {
      if (tablero.mundo[i+1][j-1] == 0)
        return false;
      if (tablero.mundo[i+1][j-1] == tablero.turno)
        return true;
     }
  }
  return false;
}

/** Metodo que verifica si el sureste es un movimiento valido*/
boolean checkSouthEast(int x, int y) {
  if (x==7 || y==7)
    return false;
  if (tablero.mundo[x+1][y+1] == tablero.turno*-1) {
    for (int i = x+1, j = y+1; i<tablero.dimension-1 && j<tablero.dimension-1; i++, j++) {
      if (tablero.mundo[i+1][j+1] == 0)
        return false;
      if (tablero.mundo[i+1][j+1] == tablero.turno)
        return true;
     }
  }
  return false;
}

/**
Cambia de color las fichas del Norte
        A
        |
        |
**/
void paintNorth(int x, int a){
  for(int i = a-1; i >0; i--){
    tablero.mundo[x][i] = tablero.turno;    
    if (tablero.turno==tablero.mundo[x][i-1])
        return;
  }
}

/**
Cambia de color las fichas del Sur
        |
        |
        v
**/
void paintSouth(int x, int a){
  for(int i = a+1; i <tablero.dimension; i++){
    tablero.mundo[x][i] = tablero.turno;
    
    if (tablero.turno==tablero.mundo[x][i+1])
        return;
  }
}

/**
Cambia de color las fichas del Este
      ----->
**/
void paintEast(int a, int y){
  for(int i = a+1; i <tablero.dimension; i++){
    tablero.mundo[i][y] = tablero.turno;
    
    if (tablero.turno==tablero.mundo[i+1][y])
        return;
  }
}

/**
Cambia de color las fichas del Oeste
      <------
**/
void paintWest(int a, int y){
  for(int i = a-1; i >0; i--){
    tablero.mundo[i][y] = tablero.turno;
    
    if (tablero.turno==tablero.mundo[i-1][y])
        return;
  }
}

/**
Cambia de color las fichas del Noreste
               >
              /
             /
**/
void paintNorthEast(int a, int b){
  for(int i = a+1, j = b-1; i<tablero.dimension && j>0; i++, j--){      
    tablero.mundo[i][j] = tablero.turno;
    
    if (tablero.turno==tablero.mundo[i+1][j-1])
        return;
  }
}

/**
Cambia de color las fichas del Noroeste
           <
            \
             \
**/
void paintNorthWest(int a, int b){
  for(int i = a-1, j = b-1; i>0 && j>0; i--, j--){      
    tablero.mundo[i][j] = tablero.turno;
    
    if (tablero.turno==tablero.mundo[i-1][j-1])
        return;
  }
}

/**
Cambia de color las fichas del Sureste
            \
             \
              >
**/
void paintSouthEast(int a, int b){
  for(int i = a+1, j = b+1; i<tablero.dimension && j<tablero.dimension; i++, j++){      
    tablero.mundo[i][j] = tablero.turno;
    
    if (tablero.turno==tablero.mundo[i+1][j+1])
        return;
  }
}

/**
Cambia de color las fichas del Suroeste
            /
           /
          <
**/
void paintSouthWest(int a, int b){
  for(int i = a-1, j = b+1; i>0 && j<tablero.dimension; i--, j++){      
    tablero.mundo[i][j] = tablero.turno;
    
    if (tablero.turno==tablero.mundo[i-1][j+1])
        return;
  }
}

/**
Método que verifica si se puede tirar en cierta posición
**/
boolean canPlay(int posX , int posY) {
  
  if (posX>7 || posY>7)
    return false;
  if(tablero.mundo[posX][posY] == 2 || tablero.mundo[posX][posY] == 0 || tablero.mundo[posX][posY] == 3){
  
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

/**
Método que cambia de color todas las fichas que se puedan.
**/
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
}

/**
Método que reestablece los valores de la lista de posiciones
y las variables de dirección.
**/
void reset (){
  n=s=e=w=sw=se=nw=ne=false;
  for (Pair p : positions) {
    //Aquí se eliminan los puntos verdes que indican las posiciones disponibles
    if (tablero.mundo[p.first()][p.second()]!=-1 && tablero.mundo[p.first()][p.second()]!=1)
    tablero.mundo[p.first()][p.second()]=0;
  }
  positions.clear();
}

/**
Método que obitene una lista con las posiciones en donde se puede tirar.
**/
public ArrayList<Pair> getAvailable (){
 for(int i = 0; i< tablero.dimension; i++ ){
   for(int j = 0; j< tablero.dimension; j++){
     if (canPlay(i,j)){
       Pair p = new Pair(i,j); 
       positions.add(p);
     }
   }
 }
 return positions;  
}

/**
Método que muestra en el tablero las posiciones en donde se puede tirar.
(Puntos verdes)
**/
public void showAvailable(){
  ArrayList<Pair> l = getAvailable();
  print("Posiciones Disponibles:");
  for (Pair p : l) {
    print("("+ p.first()+","+p.second()+")");
    tablero.mundo[p.first()][p.second()]=3;
    }
   println();
  }

/**
Método que verifica si el jugador no tiene ninguna posibilidad de jugar.
**/
public boolean noChoice() {
  return this.positions.isEmpty();
 }
 
 /**
 Método que hace el tiro del jugador. 
 **/
public void play() {
  this.reset();
  this.showAvailable();
  //Si no hay posibilidad de jugar, cambia el turno.
  if (this.noChoice()) {
    this.tablero.turno*=-1;
  }
  if (mousePressed){
  /********************NO CAMBIAR*******************/
  int posX = mouseX/((width-300)/tablero.dimension);
  int posY = mouseY/(height/tablero.dimension);
  /*************************************************/
  
    if (this.canPlay(posX, posY)) {
    this.tablero.mundo[posX][posY] = this.tablero.turno;
    this.paint(posX,posY);
    this.tablero.turno *=-1;
    this.reset();
   }
  else {
    this.reset();
    this.showAvailable();
   }
  }
 }
 
 
public void CPU (){
}

}
  
