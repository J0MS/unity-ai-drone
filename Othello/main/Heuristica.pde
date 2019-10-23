/**Clase que modela la heurística implementada en el juego*/
public class Heuristica{
  
  /**Metodo que dadas las fichas de cada jugador en el tablero obtiene una razon 
  *entre ellas. Si el valores positivo, favorecen al jugador 2 (agente) 
  *@param tablero desde el cual se obtendrán los datos
  *@return razon entre las fichas de los jugadores
  */
  public float paridad(Tablero tab){
    float val = 0;
    float fichas1 = tab.cantidadFichas().x;
    float fichas2 = tab.cantidadFichas().y;
    if((fichas2+fichas1)>0){
      val = 100 * (fichas2 - fichas1) / (fichas2 + fichas1);
    }
    return val;
  }
  
  /**Metodo que obtiene el número de fichas que tiene cada jugador en las esquinas
  *del tablero y obtiene una razon entre ellas. Si el valor es positivo, favorecen al
  *jugador 2 (agente).
  *@param tablero de juego
  *@return razon entre el numero de fichas que tiene cada jugador en las esquinas del tablero
  */
  public float esquinas(Tablero tab){
   int fichas2 = 0;
   int fichas1 = 0;
   //Verificamos las cuatro esquinas, y contamos las fichas con las que cuenta
   //cada jugador en esas posiciones.
   
   //Esquina superior izquierda.
   if(tab.mundo[0][0] == 1){
     fichas1++;
   }
   if(tab.mundo[0][0] == 2){
     fichas2++;
   }
   
   //Esquina inferior izquierda.
   if(tab.mundo[tab.dimension - 1][0] == 1){
     fichas1++;
   }
   if(tab.mundo[tab.dimension - 1][0] == 2){
     fichas2++;
   }
   
   //Esquina superior derecha.
   if(tab.mundo[0][tab.dimension - 1] == 1){
     fichas1++;
   }
   if(tab.mundo[0][tab.dimension - 1] == 2){
     fichas2++;
   }
   
   //Esquina inferior derecha.
   if(tab.mundo[tab.dimension - 1][tab.dimension - 1] == 1){
     fichas1++;
   }
   if(tab.mundo[tab.dimension - 1][tab.dimension - 1] == 2){
     fichas2++;
   }
   if((fichas2 + fichas1)>0)
     return 100 * (fichas2 - fichas1) / (fichas2 + fichas1);
   else
     return 0;
  }
  
  
  //Finalmente la función de utilidad para el tablero tab. Si es positivo favorece al jugador 2 (agente)
  public float utilidad(Tablero tab){
    return paridad(tab) + esquinas(tab);
  }

}
