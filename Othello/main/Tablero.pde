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
    /*************NO CAMBIAR****************/
    int desp = (width-300)/tablero.dimension;
    int despV = height/tablero.dimension;
    /***************************************/
    stroke(255);
    for(int i = 0; i < dimension; i++) {
      line(desp*(i + 1), 0, desp*(i + 1), height);
      line(0, despV*i, width-300, despV*i);
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
          ellipse((i*desp) + (desp/2), (j*despV) + (despV/2), desp*3/15, despV*3/15);
        }
        
       }
     }
   }

   
/**
Muestra la puntuación del juego.
**/
void score(){
  int count=0;
  int count2=0;
  for(int i = 0; i < tablero.dimension; i++) {
    for(int j = 0; j < tablero.dimension; j++) {
      if(tablero.mundo[i][j] == 1)
        p1.numFichas++;
      if(tablero.mundo[i][j] == -1)
        p2.numFichas++;
      if(tablero.mundo[i][j] == 0)
        count++;
      if(tablero.mundo[i][j] == 3)
        count2++;
      }
    }
  if (count==0 && count2 ==0){
      PFont f;
      f = createFont("Serif.italic", 30);
      textFont(f);
      textAlign(CENTER);
      fill(#DCF9D8);
      text("Juego Terminado", width-150, 450);      
      noLoop();

    }
  }
    
} 
