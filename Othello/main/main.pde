Tablero tablero;
private boolean n, s, e, w, sw, se, nw, ne;
private ArrayList<Pair> positions = new ArrayList<Pair>();
/**Metodo que inicializa el tablero */
void setup() {
  size(600, 600);
  background(77, 132, 75);
  tablero = new Tablero(8);
  showAvailable();
}

/** Metodo que dibuja el tablero*/
void draw() {
  tablero.display();
}

/** Metodo que maneja los clicks en la pantalla*/
void mouseClicked() {
  int posX = mouseX/(width/tablero.dimension);
  int posY = mouseY/(height/tablero.dimension);
  println("casilla"+"("+posX+","+posY+")");
  
  if (canPlay(posX, posY)) {
    tablero.mundo[posX][posY] = tablero.turno;
    paint(posX,posY);
    tablero.turno = tablero.turno*-1;
  } else {
    println("Movimiento invalido");
  }
  reset();
  showAvailable();
}

/** Metodo que verifica si el norte es un movimiento valido*/
boolean checkNorth(int x, int y) {
  for (int i = y + 1; i < tablero.dimension; i++) {
    if (tablero.mundo[x][i] == 0) {
      return false;
    }
    if (tablero.mundo[x][i] == tablero.turno) {
      if (tablero.mundo[x][i-1] == tablero.turno*-1) {
        //paintVertical(x, y, i);
       return true;
      }
    }
  }
  return false;
}

/** Metodo que verifica si el sur es un movimiento valido*/
boolean checkSouth(int x, int y) {
  if(y != 0 && tablero.mundo[x][y-1] == tablero.turno){
     return false;
  } 
  for (int i = y - 1; i > 0; i--) {
    if (tablero.mundo[x][i] == 0) {
      return false;
    }
    if (tablero.mundo[x][i] == tablero.turno) {
      if (tablero.mundo[x][i+1] == tablero.turno*-1) {
         //paintVertical(x, y, i);
         return true;
      }
    }
  }
  return false;
}

/** Metodo que verifica si el oeste es un movimiento valido*/
boolean checkWest(int x, int y) {
  if(x != 0 && tablero.mundo[x-1][y] == tablero.turno){
   return false;
  }  
  for (int i = x - 1; i > 0; i--) {
    if (tablero.mundo[i][y] == 0) {
      return false;
    }
    if (tablero.mundo[i][y] == tablero.turno) {
      if (tablero.mundo[i+1][y] == tablero.turno*-1) {
        //paintHorizontal(y, x, i);
       return true;
      }
    }
  }
  return false;
}

/** Metodo que verifica si el este es un movimiento valido*/
boolean checkEast(int x, int y) {
  if(x+1 != tablero.dimension && tablero.mundo[x+1][y] == tablero.turno){
   return false;
  }  
  for (int i = x + 1; i < tablero.dimension; i++) {
    if (tablero.mundo[i][y] == 0) {
      return false;
    }
    if (tablero.mundo[i][y] == tablero.turno) {
      if (tablero.mundo[i-1][y] == tablero.turno*-1) {
        //paintHorizontal(y, x, i);
       return true;
      }
    }
  }
  return false;
}

/** Metodo que verifica si el noroeste es un movimiento valido*/
boolean checkNorthWest(int x, int y) {
    for (int j = y - 1, i = x - 1; j > 0 && i > 0; j--, i--) {
            if (tablero.mundo[i][j] == 0) {
                return false;
            }
            if (tablero.mundo[i][j] == tablero.turno) {
                if (tablero.mundo[i+1][j+1] == tablero.turno*-1) {                
                   //paintNWSE(x, y, i, j);
                    return true;
                }
            }
    }
    return false;
}

/** Metodo que verifica si el sueroeste es un movimiento valido*/
boolean checkSouthWest(int x, int y) {
    for (int j = y + 1, i = x - 1; j < tablero.dimension && i > 0; j++, i--) {
            if (tablero.mundo[i][j] == 0) {
                return false;
            }
            if (tablero.mundo[i][j] == tablero.turno) {
                if (tablero.mundo[i+1][j-1] == tablero.turno*-1) {
                   //paintNESW(x, y, i, j);
                    return true;
                }
            }
    }
    return false;
}

/** Metodo que verifica si el noreste es un movimiento valido*/
boolean checkNorthEast(int x, int y) {
    for (int j = y - 1, i = x + 1; j > 0 && i < tablero.dimension; j--, i++) {
            if (tablero.mundo[i][j] == 0) {
                return false;
            }
            if (tablero.mundo[i][j] == tablero.turno) {
                if (tablero.mundo[i-1][j+1] == tablero.turno*-1) {
                   //paintNESW(x, y, i, j);
                    return true;
                }
            }
    }
    return false;
}

/** Metodo que verifica si el sureste es un movimiento valido*/
boolean checkSouthEast(int x, int y) {
    for (int j = y + 1, i = x + 1; j < tablero.dimension && i < tablero.dimension; j++, i++) {
            if (tablero.mundo[i][j] == 0) {
                return false;
            }
            if (tablero.mundo[i][j] == tablero.turno) {
                if (tablero.mundo[i-1][j-1] == tablero.turno*-1) {
                   //paintNWSE(x, y, i, j);
                    return true;
                }
            }
        
    }
    return false;
}

void paintNorth(int x, int a){
  for(int i = a; i <tablero.dimension; i++){
    tablero.mundo[x][i] = tablero.turno;
    if (tablero.turno==tablero.mundo[x][i+1])
        return;
  }
}

void paintSouth(int x, int a){
  for(int i = a; i >0; i--){
    tablero.mundo[x][i] = tablero.turno;
    if (tablero.turno==tablero.mundo[x][i-1])
        return;
  }
}

void paintEast(int a, int y){
  for(int i = a; i <tablero.dimension; i++){
    tablero.mundo[i][y] = tablero.turno;
    if (tablero.turno==tablero.mundo[i+1][y])
        return;
  }
}

void paintWest(int a, int y){
  for(int i = a; i >0; i--){
    tablero.mundo[i][y] = tablero.turno;
    if (tablero.turno==tablero.mundo[i-1][y])
        return;
  }
}

void paintNorthEast(int a, int b){
  for(int i = a, j = b; i<tablero.dimension && j>0; i++, j--){      
    tablero.mundo[i][j] = tablero.turno;
    if (tablero.turno==tablero.mundo[i+1][j-1])
        return;
  }
}

void paintNorthWest(int a, int b){
  for(int i = a, j = b; i>0 && j>0; i--, j--){      
    tablero.mundo[i][j] = tablero.turno;
    if (tablero.turno==tablero.mundo[i-1][j-1])
        return;
  }
}

void paintSouthEast(int a, int b){
  for(int i = a, j = b; i<tablero.dimension && j<tablero.dimension; i++, j++){      
    tablero.mundo[i][j] = tablero.turno;
    if (tablero.turno==tablero.mundo[i+1][j+1])
        return;
  }
}

void paintSouthWest(int a, int b){
  for(int i = a, j = b; i>0 && j<tablero.dimension; i--, j++){      
    tablero.mundo[i][j] = tablero.turno;
    if (tablero.turno==tablero.mundo[i-1][j+1])
        return;
  }
}


boolean canPlay(int posX , int posY) {
  
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

void reset (){
  n=s=e=w=sw=se=nw=ne=false;
  for (Pair p : positions) {
    if (tablero.mundo[p.first()][p.second()]!=-1 && tablero.mundo[p.first()][p.second()]!=1)
    tablero.mundo[p.first()][p.second()]=0;
  }
  positions.clear();
}

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

public void showAvailable(){
  ArrayList<Pair> l = getAvailable();
  println("Posiciones Disponibles:");
  for (Pair p : l) {
    print("("+ p.first()+","+p.second()+")");
    tablero.mundo[p.first()][p.second()]=3;
  }
}
