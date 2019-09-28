Tablero tablero;
private boolean n, s, e, w, sw, se, nw, ne;
/**Metodo que inicializa el tablero */
void setup() {
  size(600, 600);
  background(77, 132, 75);
  tablero = new Tablero(8);
  tablero.showAvailable();
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
  
  if (tablero.canPlay(posX, posY)) {
    tablero.mundo[posX][posY] = tablero.turno;
    tablero.paint(posX,posY);
    tablero.turno = tablero.turno*-1;
    if(tablero.turno == -1){
      tablero.turnoMaquina();
      draw();
    }
  } else {
    println("Movimiento invalido");
  }
  tablero.reset();
  tablero.showAvailable();
}
