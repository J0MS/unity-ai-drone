Tablero tablero;

Pair tiro;
int depth=0;
int fichas1, fichas2;


/**
 * Inicializaciones
 */
void setup() {
  size(900, 600);
  background(77, 132, 75);
  surface.setTitle("Othello");
  tablero = new Tablero();
  tablero.showAvailable();
}

void draw() {
  surface.setCursor(0);
  if (depth>0) {
    showDetails();

    // Verifica si el jugador tiene jugadas disponibles, si no, cambia el turno.
    if (tablero.getAvailable().isEmpty() && tablero.turno==1) {
      println("Jugador no puede tirar, pasa turno al Agente");
      tablero.reset();
      tablero.cambiarTurno();
      tira();
    }
    // Verifica si el agente tiene jugadas disponibles, si no, cambia el turno.
    if (tablero.getAvailable().isEmpty() && tablero.turno==-1) {
      println("Agente no puede tirar, pasa turno al jugador");
      tablero.reset();
      tablero.cambiarTurno();
      tablero.showAvailable();
    }
    // Turno del agente.
    if (tablero.turno==-1) {
      tira();
    }
    //--------------------------------------------------------------------------------------
    // Aquí se considera el caso cuando ninguno de los dos puede tirar, se acaba el juego.
    if (tablero.getAvailable().isEmpty()) {
      if (tablero.turno == -1) {
        tablero.reset();
        tablero.cambiarTurno();
        if (tablero.getAvailable().isEmpty()) {
          println("Ni el jugador ni el agente pueden tirar. Juego terminado 1");
          PFont f;
          f = createFont("Serif.italic", 30);
          textFont(f);
          textAlign(CENTER);
          fill(#DCF9D8);
          text("Juego Terminado", width-150, 450);
        }
      } else {
        tablero.reset();
        tablero.cambiarTurno();
        if (tablero.getAvailable().isEmpty()) {
          println("Ni el jugador ni el agente pueden tirar. Juego terminado 1");
          PFont f;
          f = createFont("Serif.italic", 30);
          textFont(f);
          textAlign(CENTER);
          fill(#DCF9D8);
          text("Juego Terminado", width-150, 450);
        }
      }
    }//------------------------------------------------------------------------------------------
    tablero.display();
  } else {
    displayMenu();
  }
}

/** Metodo que maneja los clicks en la pantalla*/
void mouseClicked() {
  if (tablero.turno == 1) {
    int posX = mouseX/((width-300)/tablero.dimension);
    int posY = mouseY/(height/tablero.dimension);
    println("Tiro en casilla"+"("+posX+","+posY+")");
    if (tablero.canPlay(posX, posY)) {
      tablero.setFicha(posX, posY);
      tablero.paint(posX, posY);
      tablero.reset();
      tablero.cambiarTurno();
    } else {
      println("Movimiento invalido");
    }
  }
  tablero.reset();
  tablero.printTablero();
  tablero.showAvailable();
}

/**Metodo para que tire el agente*/
public void tira() {
  Agente ag1 = new Agente(tablero);
  ag1.calculaArbol(tablero.turno, ag1.arbolDecision, depth);
  Pair p = ag1.miniMax(ag1.arbolDecision);
  println("el agente tiro en " + p);
  tablero.canPlay(p.first(), p.second());
  tablero.setFicha(p.first(), p.second());
  tablero.paint(p.first(), p.second());
  tablero.reset();
  tablero.cambiarTurno();
  tablero.printTablero();
  tablero.showAvailable();
}



/**
 Muestra la puntuación del juego.
 **/
void score() {
  int count=0;
  int count2=0;
  for (int i = 0; i < tablero.dimension; i++) {
    for (int j = 0; j < tablero.dimension; j++) {
      if (tablero.mundo[i][j] == 1)
        fichas1++;
      if (tablero.mundo[i][j] == -1)
        fichas2++;
      if (tablero.mundo[i][j] == 0)
        count++;
      if (tablero.mundo[i][j] == 3)
        count2++;
    }
  }
  if (count==0 && count2 ==0) {
    PFont f;
    f = createFont("Serif.italic", 30);
    textFont(f);
    textAlign(CENTER);
    fill(#DCF9D8);
    text("Juego Terminado", width-150, 450);      
    stop();
  }
}

/**Muestra los detalles del juego**/
void showDetails() {
  background(77, 132, 75);
  score();
  PFont f;
  f = createFont("Serif.italic", 50);
  textFont(f);
  textAlign(CENTER);
  fill(77, 132, 75);
  rect(width-290, 110, 280, 50);
  fill(#00B3FF);
  text("Marcador", width-150, 100);
  fill(0);
  text(fichas1, width-200, 150);
  fill(255);
  text(fichas2, width-100, 150);
  fill(#DCF9D8);
  text("Turno", width-150, 300);
  if (tablero.turno==1)
    fill(0);
  else
    fill(255);
  ellipse(width-150, 350, 40, 40);
  fichas1=fichas2=0;
}

/*Menú Principal*/
void displayMenu() {
  if (mouseX < width-300) {
    tablero= null;
    tablero = new Tablero();
  }
  PFont f;
  fill(0);
  f = createFont("Serif.italic", 80);
  textFont(f);
  textAlign(CENTER);
  text("Othello", width/3, height/2);
  f = createFont("Serif.italic", 20);
  textFont(f);
  color fondo = color(0);
  fill(fondo);
  float widthButton=width-220;
  rect(width-300, 0, width, height);                                                     
  fill(110);                                                                  
  rect(widthButton, height/3, 150, height/20);
  fill(255);
  text("Principiante", widthButton+80, (height/3)+(height/30));
  fill(110);
  rect(widthButton, height/3*1.5, 150, height/20);
  fill(255);
  text("Intermedio", widthButton+80, (height/3*1.5)+(height/30));
  fill(110);
  rect(widthButton, height/3*2, 150, height/20);
  fill(255);
  text("Experto", widthButton+80, (height/3*2)+(height/30));

  if (mouseX >= widthButton && mouseX<=widthButton+150 &&
    mouseY >= height/3 && mouseY<= (height/3)+(height/20)) {
    surface.setCursor(13);
    fill(52, 173, 217);                                                            
    rect(widthButton, height/3, 150, height/20);
    fill(0);
    text("Principiante", widthButton+80, (height/3)+(height/30));
  }
  if (mouseX >= widthButton && mouseX<=widthButton+150 &&
    mouseY >= height/3*1.5 && mouseY<= (height/3*1.5)+(height/20)) {
    surface.setCursor(13);
    fill(52, 173, 217);                                                                   
    rect(widthButton, height/3*1.5, 150, height/20);
    fill(0);
    text("Intermedio", widthButton+80, (height/3*1.5)+(height/30));
  }
  if (mouseX >= widthButton && mouseX<=widthButton+150 &&
    mouseY >= height/3*2 && mouseY<= (height/3*2)+(height/20)) {
    surface.setCursor(13);
    fill(52, 173, 217);                                                                   
    rect(widthButton, height/3*2, 150, height/20);
    fill(0);
    text("Experto", widthButton+80, (height/3*2)+(height/30));
  }

  if (mousePressed && mouseX >= widthButton && mouseX<=widthButton+150 &&
    mouseY >= height/3 && mouseY<= (height/3)+(height/20)) {
    depth=1;
  }
  if (mousePressed && mouseX >= widthButton && mouseX<=widthButton+150 &&
    mouseY >= height/3*1.5 && mouseY<= (height/3*1.5)+(height/20)) {
    depth=3;
  }
  if (mousePressed && mouseX >= widthButton && mouseX<=widthButton+150 &&
    mouseY >= height/3*2 && mouseY<= (height/3*2)+(height/20)) {
    depth=5;
  }
  fill(255);
  f = createFont("Serif.italic", 35);
  textFont(f);
  text("Selecciona Nivel", width-150, 100);
}  
