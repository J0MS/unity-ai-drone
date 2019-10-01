/** Clase que modela el tablero del juego*/
class Tablero {

  private boolean n, s, e, w, sw, se, nw, ne;
  private ArrayList<Pair> positions = new ArrayList<Pair>();
  /**
   * Cantidad de casillas en horizontal y vertical del tablero
   */
  int dimension;
  /**
   * El tamaño en pixeles de cada casilla cuadrada del tablero
   */
  int tamCasilla;
  /**
   * Representación lógica del tablero. El valor númerico representa:
   * 1 = casilla con ficha del primer jugador
   * -1 = casilla con ficha del segundo jugador
   */
  int[][] mundo;
  /**
   * Representa de quién es el turno bajo la siguiente convención:
   * 1 = turno del jugador 1
   * -1 = turno del jugador 2 (agente)
   */
  int turno;

  /**
   * Constructor base de un tablero. 
   * @param dimension Cantidad de casillas del tablero, comúnmente ocho.
   * @param tamCasilla Tamaño en pixeles de cada casilla
   */
  Tablero(int dimension) {
    this.dimension = dimension;
    turno = 1;
    mundo = new int[dimension][dimension];
    mundo[dimension/2-1][dimension/2-1] = -1;
    mundo[dimension/2][dimension/2] = -1;
    mundo[dimension/2][dimension/2-1] = 1;
    mundo[dimension/2-1][dimension/2] = 1;
  }

  /**
   * Constructor por default de un tablero con las siguientes propiedades:
   * Tablero de 8x8 casillas, cada casilla de un tamaño de 60 pixeles,
   */
  Tablero() {
    this(8);
  }

  /**Constructor copia de un tablero
   */
  Tablero(Tablero tab) {
    dimension = tab.dimension;
    turno = tab.turno;
    mundo = new int[dimension][dimension];
    for (int i = 0; i < dimension; i++)
      for (int j = 0; j < dimension; j++)
        mundo[i][j] = tab.mundo[i][j] != 0? tab.mundo[i][j] : 0;
  }



  /** Metodo que dibuja todo el tablero, se incluye la posicion inicial del juego*/
  void display() {
    /*************NO CAMBIAR****************/
    int desp = (width-300)/tablero.dimension;
    int despV = height/tablero.dimension;
    /***************************************/
    stroke(255);
    for (int i = 0; i < dimension; i++) {
      line(desp*(i + 1), 0, desp*(i + 1), height);
      line(0, despV*i, width-300, despV*i);
    }

    for (int i = 0; i < dimension; i++) {
      for (int j = 0; j < dimension; j++) {
        if (mundo[i][j] == 1) {
          fill(0);
          noStroke();
          ellipse((i*desp) + (desp/2), (j*despV) + (despV/2), desp*3/4, despV*3/4);
        } 
        if (mundo[i][j] == -1) {
          fill(255);
          noStroke();
          ellipse((i*desp) + (desp/2), (j*despV) + (despV/2), desp*3/4, despV*3/4);
        } 
        if (mundo[i][j] == 2) {
          fill(122);
          noStroke();
          ellipse((i*desp) + (desp/2), (j*despV) + (despV/2), desp*3/4, despV*3/4);
        }
        if (mundo[i][j] == 0) {
          fill(77, 132, 75);
          noStroke();
          ellipse((i*desp) + (desp/2), (j*despV) + (despV/2), desp*3/4, despV*3/4);
        }
        if (mundo[i][j] == 3) {
          fill(52, 235, 210);
          noStroke();
          ellipse((i*desp) + (desp/2), (j*despV) + (despV/2), desp*3/15, despV*3/15);
        }
      }
    }
  }

  /**
   * Coloca o establece una ficha en una casilla específica del tablero segun el turno del tablero.
   * @param posX Coordenada horizontal de la casilla para establecer la ficha
   * @param posX Coordenada vertical de la casilla para establecer la ficha
   */
  void setFicha(int posX, int posY) {
    mundo[posX][posY] = turno;
  }

  /**
   * Representa el cambio de turno. Normalmente representa la última acción del turno
   */
  void cambiarTurno() {
    turno *= -1;
  }

  /**
   * Cuenta la cantidad de fichas de un jugador
   * @return La cantidad de fichas de ambos jugadores en el tablero como vector, 
   * donde x = jugador1, y = jugador2
   */
  PVector cantidadFichas() {
    PVector contador = new PVector();
    for (int i = 0; i < dimension; i++)
      for (int j = 0; j < dimension; j++) {
        if (mundo[i][j] == 1)
          contador.x += 1;
        if (mundo[i][j] == -1)
          contador.y += 1;
      }
    return contador;
  }

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
    if (tablero.mundo[x][y+1] == turno*-1) {
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

/**
Cambia de color las fichas del Norte
        A
        |
        |
**/
  void paintNorth(int x, int a) {
    for (int i = a; i >0; i--) {
      mundo[x][i] = turno;
      if (turno==mundo[x][i-1])
        return;
    }
  }

/**
Cambia de color las fichas del Sur
        |
        |
        v
**/
  void paintSouth(int x, int a) {
    for (int i = a; i <dimension; i++) {
      mundo[x][i] = turno;
      if (turno==mundo[x][i+1])
        return;
    }
  }

/**
Cambia de color las fichas del Este
      ----->
**/
  void paintEast(int a, int y) {
    for (int i = a; i <dimension; i++) {
      mundo[i][y] = turno;
      if (turno==mundo[i+1][y])
        return;
    }
  }

/**
Cambia de color las fichas del Oeste
      <------
**/
  void paintWest(int a, int y) {
    for (int i = a; i >0; i--) {
      mundo[i][y] = turno;
      if (turno==mundo[i-1][y])
        return;
    }
  }

/**
Cambia de color las fichas del Noreste
               >
              /
             /
**/
  void paintNorthEast(int a, int b) {
    for (int i = a, j = b; i<dimension && j>0; i++, j--) {      
      mundo[i][j] = turno;
      if (turno==mundo[i+1][j-1])
        return;
    }
  }

/**
Cambia de color las fichas del Noroeste
           <
            \
             \
**/
  void paintNorthWest(int a, int b) {
    for (int i = a, j = b; i>0 && j>0; i--, j--) {      
      mundo[i][j] = turno;
      if (turno==mundo[i-1][j-1])
        return;
    }
  }

/**
Cambia de color las fichas del Sureste
            \
             \
              >
**/
  void paintSouthEast(int a, int b) {
    for (int i = a, j = b; i<dimension && j<dimension; i++, j++) {      
      mundo[i][j] = turno;
      if (turno==mundo[i+1][j+1])
        return;
    }
  }

/**
Cambia de color las fichas del Suroeste
            /
           /
          <
**/
  void paintSouthWest(int a, int b) {
    for (int i = a, j = b; i>0 && j<dimension; i--, j++) {      
      mundo[i][j] = turno;
      if (turno==mundo[i-1][j+1])
        return;
    }
  }

/**
Método que verifica si se puede tirar en cierta posición
**/
  boolean canPlay(int posX, int posY) {

    if (posX>7 || posY>7)
      return false;

    if (mundo[posX][posY] == 2 || mundo[posX][posY] == 0 || mundo[posX][posY] == 3) {

      n = checkNorth(posX, posY);
      s = checkSouth(posX, posY);
      e = checkEast(posX, posY);
      w = checkWest(posX, posY);
      sw = checkSouthWest(posX, posY);
      se = checkSouthEast(posX, posY);
      nw = checkNorthWest(posX, posY);
      ne = checkNorthEast(posX, posY);
      if (n || s || e || w || sw || se || nw || ne) {
        return true;
      }
    }

    return false;
  }

/**
Método que cambia de color todas las fichas que se puedan.
**/
  void paint(int posX, int posY) {
    if (n)
      paintNorth(posX, posY);

    if (s)
      paintSouth(posX, posY);

    if (e)
      paintEast(posX, posY);

    if (w)
      paintWest(posX, posY);

    if (ne)
      paintNorthEast(posX, posY);

    if (nw)
      paintNorthWest(posX, posY);

    if (se)
      paintSouthEast(posX, posY);

    if (sw)
      paintSouthWest(posX, posY);
  }

/**
Método que reestablece los valores de la lista de posiciones
y las variables de dirección.
**/
  void reset () {
    n=s=e=w=sw=se=nw=ne=false;
    for (Pair p : positions) {
      if (mundo[p.first()][p.second()]!=-1 && mundo[p.first()][p.second()]!=1)
        mundo[p.first()][p.second()]=0;
    }
    positions.clear();
  }

/**
Método que reestablece quita las fichas verdes.
**/
  void resetAll() {
    for (int i = 0; i < dimension; i++)
      for (int j = 0; j < dimension; j++)
        if (mundo[i][j] == 3)
          mundo[i][j] = 0;
  }

/**
Método que obitene una lista con las posiciones en donde se puede tirar.
**/
  public ArrayList<Pair> getAvailable () {
    for (int i = 0; i< dimension; i++ ) {
      for (int j = 0; j< dimension; j++) {
        if (canPlay(i, j)) {
          Pair p = new Pair(i, j); 
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
  public void showAvailable() {
    ArrayList<Pair> l = getAvailable();
    println("Posiciones Disponibles:");
    for (Pair p : l) {
      print("("+ p.first()+","+p.second()+")");
      mundo[p.first()][p.second()]=3;
    }
  }

  /**Metodo que imprime en consola el tablero actual**/
  void printTablero() {
    for (int i = 0; i < mundo.length; i++) {         //this equals to the row 
      for (int j = 0; j < mundo[i].length; j++) {  
        print(mundo[j][i] + " ");
      }
      println(); //change line on console as row comes to end
    }
    println("----------------------------");
  }
}
