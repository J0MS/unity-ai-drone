Tablero tablero;
/**Metodo que inicializa el tablero */
void setup() {
  size(600, 600);
  background(77, 132, 75);
  tablero = new Tablero(8);
}

/** Metodo que dibuja el tablero*/
void draw() {
  tablero.display();
}

/** Metodo que maneja los clicks en la pantalla*/
void mouseClicked() {
  int posX = mouseX/(width/tablero.dimension);
  int posY = mouseY/(height/tablero.dimension);
  //Si se quiere tirar en una casilla ocupada
  if (tablero.mundo[posX][posY] != 2 && tablero.mundo[posX][posY] != 0) {
    println("Casilla ocupada");
    return;
  }
  //se debe realizar todos los metodos para poder pintarlos 
  boolean n = checkNorth(posX, posY);
  boolean s = checkSouth(posX, posY);
  boolean e = checkEast(posX, posY);
  boolean w = checkWest(posX, posY);
  boolean sw = checkSouthWest(posX, posY);
  boolean se = checkSouthEast(posX, posY);
  boolean nw = checkNorthWest(posX, posY);
  boolean ne = checkNorthEast(posX, posY);
  
  if (n || s || e || w || sw || se || nw || ne) {
    tablero.mundo[posX][posY] = tablero.turno;
    tablero.turno = tablero.turno*-1;
  } else {
    println("Movimiento invalido");
  }
}

/** Metodo que verifica si el norte es un movimiento valido*/
boolean checkNorth(int x, int y) {
  for (int i = y + 1; i < tablero.dimension; i++) {
    if (tablero.mundo[x][i] == 0) {
      return false;
    }
    if (tablero.mundo[x][i] == tablero.turno) {
      if (tablero.mundo[x][i-1] == tablero.turno*-1) {
        paintVertical(x, y, i);
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
         paintVertical(x, y, i);

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
        paintHorizontal(y, x, i);
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
        paintHorizontal(y, x, i);
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
                   paintNWSE(x, y, i, j);
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
                   paintNESW(x, y, i, j);
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
                   paintNESW(x, y, i, j);
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
                   paintNWSE(x, y, i, j);
                    return true;
                }
            }
        
    }
    return false;
}

/**Metodo que cambia el color de las fichas que cambian de color (que se flippean)*/
void paintVertical(int x, int a, int b){
  for(int i = min(a, b); i <= max(a, b); i++){
    tablero.mundo[x][i] = tablero.turno;
  }
}

/**Metodo que cambia el color de las fichas que cambian de color (que se flippean)*/
void paintHorizontal(int y, int a, int b){
  for(int i = min(a, b); i <= max(a, b); i++){
    tablero.mundo[i][y] = tablero.turno;
  }
}

/**Metodo que cambia el color de las fichas que cambian de color (que se flippean)*/
void paintNWSE(int a, int b, int x, int y){ //pinta noroeste y sureste
  for (int i = min(a, x), j = min(b, y); i < max(a, x) && j < max(b, y); j++, i++) {
    tablero.mundo[i][j] = tablero.turno;
  }
}

/**Metodo que cambia el color de las fichas que cambian de color (que se flippean)*/
void paintNESW(int a, int b, int x, int y){//Pinta noreste y suroeste
  for (int i = max(a, x), j = min(b, y); i > min(a, x) && j < max(b, y); j++, i--) {
    tablero.mundo[i][j] = tablero.turno;
  }
}
