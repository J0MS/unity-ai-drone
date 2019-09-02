using System.Collections;
using System.Collections.Generic;
using UnityEngine;

// Ejemplo de un comportamiento automático para el agente (basado en modelos)
public class ComportamientoEstados : MonoBehaviour {

	private Sensores sensor;
	private Actuadores actuador;

	private enum Percepcion {NoFrenteAPared=0, FrenteAPared=1, BateriaBaja=2, BateriaLlena=3}; // Lista predefinida de posibles percepciones con los sensores
	private enum Estado {Avanzar=0, Detenerse=1, GiraDerecha=2, Subir=3, IrABase=4}; // Lista de estados para la maquina de estados y tabla de transiciones
	private Estado estadoActual;
	private Percepcion percepcionActual;
	private Percepcion p1;


	void Start(){
		sensor = GetComponent<Sensores>();
		actuador = GetComponent<Actuadores>();
		estadoActual = Estado.Avanzar;
	}

	void FixedUpdate() {


		if(sensor.Bateria() <= 0) {
			// Si se queda sin batería se cae.
			actuador.Descender();
			return;
		}


		percepcionActual = PercibirMundo();
		estadoActual = TablaDeTransicion(estadoActual, percepcionActual);
		Debug.Log("-> "+ estadoActual + "  -  " + percepcionActual);
		AplicarEstado(estadoActual);
	}

	// A partir de este punto se representa un agente basado en modelos.
	// La idea es similar a crear una máquina de estados finita donde se hacen las siguientes consideraciones:
	// - El alfabeto es un conjunto predefinido de percepciones hechas con sensores del agente
	// - El conjunto de estados representa un conjunto de métodos con acciones del agente
	// - La función de transición es un método
	// - El estado inicial se inicializa en Start()
	// - El estado final es opcional (pero recomendable de indicar)

	// Tabla de transición que representa el conjunto de reglas
	// -----------------------------------------------
	// | Estado\Percepcion | paredCerca | !paredCerca |
	// |-------------------|------------|-------------|
	// | Avanzar           | Detenerse  | Avanzar     |
	// |-------------------|------------|-------------|
	// | Detenerse         | Detenerse  | Detenerse   |
	// ------------------------------------------------
	Estado TablaDeTransicion(Estado estado, Percepcion percepcion){
		actuador.Flotar();
		sensor.reset();
		switch(estado){
			case Estado.Avanzar:
				switch(percepcion){
					case Percepcion.FrenteAPared:
						Detenerse();
						estado = Estado.GiraDerecha;
						break;
					case Percepcion.NoFrenteAPared:
						estado = Estado.Avanzar;
						break;
					case Percepcion.BateriaLlena:
						estado = Estado.Avanzar;
						break;
					case Percepcion.BateriaBaja:
							estado = Estado.IrABase;
							break;
				}
				break;
			case Estado.Detenerse:
				switch(percepcion){
					case Percepcion.FrenteAPared:
						estado = Estado.Detenerse;
						break;
					case Percepcion.NoFrenteAPared:
						estado = Estado.Detenerse;
						break;
					case Percepcion.BateriaBaja:
							estado = Estado.Detenerse;
						break;
				}
				break;
			case Estado.GiraDerecha:
				switch (percepcion){
					case Percepcion.FrenteAPared:
					  //Detenerse();
						estado = Estado.GiraDerecha;
						break;
					case Percepcion.NoFrenteAPared:
						estado = Estado.Avanzar;
						break;
					case Percepcion.BateriaLlena:
						estado = Estado.Avanzar;
						break;
					case Percepcion.BateriaBaja:
						estado = Estado.Avanzar;
						break;
					}
			  break;
			case Estado.Subir:
				switch (percepcion){
					case Percepcion.FrenteAPared:
						estado = Estado.Subir;
						break;
					case Percepcion.NoFrenteAPared:
						//Detenerse();
						estado = Estado.Avanzar;
						break;
					case Percepcion.BateriaLlena:
						estado = Estado.Subir;
						break;
					case Percepcion.BateriaBaja:
						//Detenerse();
						estado = Estado.Avanzar;
						break;
					}
				break;
			case Estado.IrABase:
				//Detenerse();
				switch (percepcion){
					case Percepcion.FrenteAPared:
						estado = Estado.GiraDerecha;
						break;
					case Percepcion.NoFrenteAPared:
						estado = Estado.Avanzar;
						break;
					case Percepcion.BateriaLlena:
						estado = Estado.Subir;
						break;
					case Percepcion.BateriaBaja:
						estado = Estado.Avanzar;
						break;
					}

				break;

		}
		return estado;
	}

	// Representación de los ESTADOS como métodos

	void BateriaBaja() {
		actuador.irABase();
	}

	// El estado AVANZAR significa moverse hacia adelante siempre.
	void Avanzar(){
		//actuador.Flotar();
		actuador.Adelante();
	}
	// El estado DETENERSE representa mantenerse en el mismo punto
	void Detenerse(){
		//actuador.Flotar();
		actuador.Detener();
	}

	void Girar(){
		//actuador.Flotar();
		//actuador.fijarAltura();
		actuador.GirarDerecha();
	}

	void Subir(){
		//actuador.Flotar();
		actuador.Ascender();
	}

	// Usar sensores para determinar el tipo de percepción actual
	Percepcion PercibirMundo(){
		percepcionActual = Percepcion.NoFrenteAPared;


		if (sensor.Bateria()<=45){
			percepcionActual = Percepcion.BateriaBaja;
				if (sensor.CercaDePared()){
							Debug.Log("WWWWW");
						AplicarEstado (Estado.Subir);
					}
				else {
						Debug.Log("ZZZZZZ");
						AplicarEstado (Estado.Avanzar);
					}
		}
		else if (sensor.Bateria()>=100) {
			percepcionActual = Percepcion.BateriaLlena;
		}
		else if(!sensor.FrenteAPared()){
			percepcionActual = Percepcion.NoFrenteAPared;
		}
		else if(sensor.FrenteAPared()){
			percepcionActual = Percepcion.FrenteAPared;
		}

		return percepcionActual;


	}

	// Aplicar el estado actual, i.e, mandar a llamar al método del estado dado como parámetro
	void AplicarEstado(Estado estado){
		switch(estado){
			case Estado.Avanzar:
				Avanzar();
				break;
			case Estado.Detenerse:
				Detenerse();
				break;
			case Estado.GiraDerecha:
				Girar();
				break;
			case Estado.Subir:
				Subir();
				break;
			case Estado.IrABase:
				BateriaBaja();
				break;
			default:
				Detenerse();
				break;
		}
	}

	void GiraCompleto(){
		//for(int i = 0; i <14; i++){
			Girar();
		//}
	}
}
