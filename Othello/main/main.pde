Tablero tablero;
Player p1;
Player p2;

/**Metodo que inicializa el tablero */
void setup() {
  size(900, 600);
  background(77, 132, 75);
  tablero = new Tablero(8);
  p1 = new Player(tablero);
  p2 = new Player(tablero);
  p1.showAvailable();
}

/** Metodo que dibuja el blero*/
void draw() {
  tablero.display();
  showDetails();
  switch (tablero.turno) {
    case 1:
        p1.play();
      break;
    case -1:
        p2.play();
      break;
  }
}

/**Muestra los detalles del juego**/
void showDetails() {
  p1.numFichas=0;
  p2.numFichas=0;
  tablero.score();
  PFont f;
  f = createFont("Serif.italic", 50);
  textFont(f);
  textAlign(CENTER);
  fill(77, 132, 75);
  rect(width-290, 110,280,50);
  fill(#00B3FF);
  text("Marcador", width-150, 100);
  fill(0);
  text(p1.numFichas, width-200, 150);
  fill(255);
  text(p2.numFichas, width-100, 150);
  fill(#DCF9D8);
  text("Turno", width-150, 300);
  if (tablero.turno==1)
    fill(0);
  else
    fill(255);
    ellipse(width-150,350,40,40);
}
