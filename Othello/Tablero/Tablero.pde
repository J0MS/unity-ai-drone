class Tablero{
 int ancho;
 int alto;
 int[][] mundo;
 
 Tablero(int dimension){
   ancho = dimension;
   alto = dimension;
   mundo = new int[dimension][dimension];
   llenaTablero();
   mundo[dimension/2-1][dimension/2-1] = 1;
   mundo[dimension/2-1][dimension/2] = -1;
   mundo[dimension/2 ][dimension/2] = 1;
   mundo[dimension/2][dimension/2-1] = -1;
 }
 
 Tablero(int an, int al){
   ancho = an;
   alto = al;
   mundo = new int[an][al];
 }
 
 void llenaTablero(){
   for(int i = 0; i<ancho ; i++){
     for(int j = 0; j<alto; j++){
       this.mundo[i][j] = 0;//Indica que no hay ninguna ficha en esa posicion       
     }
   }
 }
 
 //Dibuja el tablero sin fichas
 void display(){
   int distX = width/this.ancho;
   int distY = height/this.ancho;
   color tab = color(204, 229, 255);
   color lin = color(255, 51, 153);
   fill(tab);
   rect(0,0, this.ancho*distX, this.alto*distY);
   stroke(lin);
   for(int i = 1; i< this.ancho; i++){
     line(i*distX,0,i*distX,this.alto*distY);
   }
   for(int i = 1; i< this.alto; i++){
     line(0,i*distY,this.ancho*distX,i*distY);
   }
   //Dibujar fichas
   for(int i = 0; i<ancho ; i++){
     for(int j = 0; j<alto; j++){
       int colorin = this.mundo[i][j];
       if(colorin == 1){
         fill(0);
         noStroke();
         ellipse(i*distX + distX/2, j*distY + distY/2, distX*3/4, 3*distY/4);
       }else{
         if(colorin == -1){
            fill(255);
            noStroke();
           ellipse(i*distX + distX/2, j*distY + distY/2, distX*3/4, 3*distY/4); 
         }
       }
     }
   }
 }
 
   //Nos dice si una casilla es esquina
   boolean esEsquina(int x, int y){
     if(x ==0){
        if(y ==0){
           return true; 
        }
        if(y == this.alto-1){
           return true; 
        }
     }
     if(y==0 && x == this.ancho-1){
       return true;
     }
     if(y==this.alto-1 && x == this.ancho-1){
       return true;
     }
     return false;
   }

   boolean esBorde(int x, int y){
     if(x ==0 || x == this.ancho-1 || y == 0 || y == this.alto-1){
       return true;
     }
     return false;
   }
 
}

\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
/** Clase que odela el tablero del juego*/
class Tablero {
  int dimension;
  int[][] mundo;
  int turno = 1;
  Movimientos m = new Movimientos();
  
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
    m.posibles();
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
        }
        
       }
     }
   }
} 




