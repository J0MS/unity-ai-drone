Tablero tablero;

Pair tiro;
int depth=3;

/**
 * Método para establecet tamaño de ventana al incluir variables
 */
void settings() {
  tablero =  new Tablero();
  size(tablero.dimension * tablero.tamCasilla, tablero.dimension * tablero.tamCasilla);
}

/**
 * Inicializaciones
 */
void setup() {
  tablero.showAvailable();
}

void draw() {
  float fichas1 = tablero.cantidadFichas().x;
  float fichas2 = tablero.cantidadFichas().y;
  
  // Se verifica si el juego ha terminado
  if (fichas1 + fichas2 == tablero.dimension * tablero.dimension) {
    stop();
  } else {
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
  }
  //--------------------------------------------------------------------------------------
  // Aquí se considera el caso cuando ninguno de los dos puede tirar, se acaba el juego.
  if (tablero.getAvailable().isEmpty()) {
    if (tablero.turno == -1) {
      tablero.cambiarTurno();
      tablero.reset();
      if (tablero.getAvailable().isEmpty()) {
        println("Ni el jugador ni el agente pueden tirar. Juego terminado 1");
        resultado(fichas1, fichas2);
        stop();
      }
    } else {
      tablero.cambiarTurno();
      tablero.reset();
      if (tablero.getAvailable().isEmpty()) {
        println("Ni el jugador ni el agente pueden tirar. Juego terminado 1");
        resultado(fichas1, fichas2);
        stop();
      }
    }
  }//------------------------------------------------------------------------------------------
  tablero.display();
}

/** Metodo que maneja los clicks en la pantalla*/
void mouseClicked() {
    if (tablero.turno == 1) {
      int posX = mouseX/(width/tablero.dimension);
      int posY = mouseY/(height/tablero.dimension);
      println("Tiro en casilla"+"("+posX+","+posY+")");
      if (tablero.canPlay(posX, posY)) {
        tablero.setFicha(posX, posY);
        tablero.paint(posX, posY);
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
  tablero.cambiarTurno();
  tablero.reset();
  tablero.printTablero();
  tablero.showAvailable();
}

/**Mostramos los resultados del jeugo*/
private void resultado(float fichas1, float fichas2) {
  if (fichas1 < fichas2) {
    println("Gana agente.\nMarcador: " + int(fichas1) + " - " + int(fichas2));
    return;
  }
  if (fichas1 > fichas2) {
    println("Gana el jugador.\nMarcador: " + int(fichas1) + " - " + int(fichas2)); 
    return;
  }
  println("Juego empatado.\nMarcador: " + int(fichas1) + " - " + int(fichas2));
}
