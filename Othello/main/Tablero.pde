/** Clase que odela el tablero del juego*/
class Tablero {
  int dimension;
  int[][] mundo;
  int turno = 1;
  
  /**Constructor de la clase tablero
  *  @param d dimension que tendra el tablero
  */
  Tablero(int d) {
    dimension = d;
    mundo = new int[dimension][dimension];
    mundo[dimension/2-1][dimension/2-1] = -1;
    mundo[dimension/2][dimension/2] = -1;
    mundo[dimension/2][dimension/2-1] = 1;
    mundo[dimension/2-1][dimension/2] = 1;
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
} 
