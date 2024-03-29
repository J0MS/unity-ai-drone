﻿using System.Collections;
using System.Collections.Generic;
using UnityEngine;

// Ejemplo de un comportamiento automático para el agente (basado en modelos)
public class ComportamientoEstados : MonoBehaviour {

	private Sensores sensor;
	private Actuadores actuador;

	private enum Percepcion {NoFrenteAPared=0, FrenteAPared=1, DerechaPared=2, FrenteDerechaPared=4, BateriaBaja=5,
						CercaDeBaseDeCarga=6, BateriaLlena=7, PersonaCerca=8, BateriaConCarga=9}; // Lista predefinida de posibles percepciones con los sensores
	private enum Estado {Avanzar=0, Detenerse=1, GiraDerecha=2,AvanzarPerimetro=3, GiraDerechaPerimetro=4, Cargando=5, Buscando=6, Siguiendo=7 }; // Lista de estados para la maquina de estados y tabla de transiciones
	private Estado estadoActual;
	private Percepcion percepcionActual;
	private bool sensorEnBateriaBaja = false, bateriaLlena = false;


	void Start(){
		sensor = GetComponent<Sensores>();
		actuador = GetComponent<Actuadores>();
		//estadoActual = Estado.AvanzarPerimetro;
        estadoActual = Estado.Buscando;
    }

	void FixedUpdate() {
		if(sensor.Bateria() <= 0) {
			// Si se queda sin batería se cae.
			actuador.Descender();
			return;
		}
		actuador.Flotar();
		actuador.Estabilizar();
		Debug.Log("sensorEnBateriaBaja "+ sensorEnBateriaBaja + " bateriaLlena " + bateriaLlena);
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
		sensor.reset();
		switch(estado){
			case Estado.Avanzar:
				switch(percepcion){
					case Percepcion.FrenteAPared:
						estado = Estado.Detenerse;
						break;
					case Percepcion.NoFrenteAPared:
						estado = Estado.Avanzar;
						break;
					//Este es el caso donde se detecta la bateria baja y empieza a buscar en el perimetro.
						//se levanta una bandera para no interrumpir la percepcion mientras recorre el perimetro.
					case Percepcion.BateriaBaja:
						estado = Estado.AvanzarPerimetro;
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
				}
				break;
			case Estado.AvanzarPerimetro:
				switch(percepcion){
          case Percepcion.BateriaBaja:
            estado = Estado.Cargando;
            break;
					case Percepcion.FrenteAPared:
						estado = Estado.GiraDerechaPerimetro;
						break;
					case Percepcion.FrenteDerechaPared:
						estado = Estado.GiraDerechaPerimetro;
						break;
					case Percepcion.NoFrenteAPared:
						estado = Estado.AvanzarPerimetro;
						break;
					case Percepcion.CercaDeBaseDeCarga:
						estado = Estado.Cargando;
						break;
                   /* case Percepcion.PersonaCerca:
                        estado = Estado.Siguiendo;
                        break;*/
				}
				break;
			case Estado.GiraDerechaPerimetro:
				switch(percepcion){
					case Percepcion.FrenteAPared:
						Detenerse();
							estado = Estado.GiraDerechaPerimetro;
						break;
					case Percepcion.FrenteDerechaPared:
						Detenerse();
						estado = Estado.GiraDerechaPerimetro;
						break;

					case Percepcion.NoFrenteAPared:
						estado = Estado.GiraDerechaPerimetro;
						break;
					case Percepcion.DerechaPared:
						GiraCompleto();
						estado = Estado.AvanzarPerimetro;
						break;
				}
				break;
			case Estado.Cargando:
				switch(percepcion){
					case Percepcion.BateriaLlena:
                        estado = Estado.Buscando;
                        //estado = Estado.Avanzar;
						break;
					default:
						Detenerse();
						estado = Estado.Cargando;
                        break;
				}
				break;
            case Estado.Buscando:
                switch (percepcion)
                {
                    case Percepcion.BateriaBaja:
                        estado = Estado.AvanzarPerimetro;
                        break;
                    case Percepcion.BateriaConCarga:
                        estado = Estado.Buscando;
                        break;
                    case Percepcion.PersonaCerca:
                        estado = Estado.Siguiendo;
                        break;
                }
                break;
            case Estado.Siguiendo:
                switch (percepcion)
                {
                    case Percepcion.BateriaBaja:
                        estado = Estado.AvanzarPerimetro;
                        break;
                    case Percepcion.PersonaCerca:
                        estado = Estado.Siguiendo;
                        break;
                }
                break;
        }
		return estado;
	}

	// Representación de los ESTADOS como métodos

	// El estado AVANZAR significa moverse hacia adelante siempre.
	void Avanzar(){
		actuador.Adelante();
	}
	// El estado DETENERSE representa mantenerse en el mismo punto
	void Detenerse(){
		actuador.Detener();
	}

	void GirarDerecha(){
		actuador.GirarDerecha();
	}

	void Cargando(){
		actuador.acercarABase();

	}
    void IrHaciaPersona()
    {
        actuador.IrHaciaPersona();
    }

    void Buscando() {
        actuador.Buscando();
        //GirarDerecha();
        //Detenerse();
        //Avanzar();
    }
    // Usar sensores para determinar el tipo de percepción actual
    Percepcion PercibirMundo(){/*
		Percepcion percepcionActual = Percepcion.NoFrenteAPared;
		if(sensor.FrenteAPared())
			percepcionActual = Percepcion.FrenteAPared;
		else
			percepcionActual = Percepcion.NoFrenteAPared;
		return percepcionActual;*/
		Percepcion percepcionActual = Percepcion.NoFrenteAPared;

        if (sensor.BateriaBaja() && !sensorEnBateriaBaja) {
            sensorEnBateriaBaja = true;
            percepcionActual = Percepcion.BateriaBaja;
            return percepcionActual;
        }
        if (sensor.CercaPersona()) {
            percepcionActual = Percepcion.PersonaCerca;
            return percepcionActual;
        }
		if(sensor.BateriaLlena() && !bateriaLlena){
			bateriaLlena = true;
			actuador.Despegar();
			bateriaLlena = false;
			sensorEnBateriaBaja = false;
			return Percepcion.BateriaLlena;
		}

		if(sensor.CercaDeBaseDeCarga() && sensorEnBateriaBaja && !bateriaLlena){
			percepcionActual = Percepcion.CercaDeBaseDeCarga;
			return percepcionActual;

		}

		if(sensor.FrenteAPared()){
			Debug.Log("------->  frente pared");
			percepcionActual = Percepcion.FrenteAPared;
			if(sensor.DerechaPared())
				percepcionActual = Percepcion.FrenteDerechaPared;
			return percepcionActual;
		}
		if(sensor.DerechaPared()){
			Debug.Log("------->  derecha pared");
			percepcionActual = Percepcion.DerechaPared;
			if(sensor.FrenteAPared()){
				Debug.Log("------->  derecha pared --- frente");
				percepcionActual = Percepcion.FrenteDerechaPared;
			}
			return percepcionActual;
		}
            //Debug.Log("LA PERCEPCION NO TOCO NADA");
		return percepcionActual;


	}

	// Aplicar el estado actual, i.e, mandar a llamar al método del estado dado como parámetro
	void AplicarEstado(Estado estado){
		switch(estado){
			case Estado.Avanzar:
				Avanzar();
				break;
			case Estado.AvanzarPerimetro:
				Avanzar();
				break;
			case Estado.Detenerse:
				Detenerse();
				break;
			case Estado.GiraDerechaPerimetro:
				GirarDerecha();
				break;
			case Estado.GiraDerecha:
				GirarDerecha();
				break;
            case Estado.Buscando:
                Buscando();
                //Detenerse();
                break;
            case Estado.Siguiendo:
                IrHaciaPersona();
                break;
            case Estado.Cargando:
				Cargando();
				break;
			default:
				Detenerse();
				break;
		}
	}

	void GiraCompleto(){
        for (int i = 0; i <14; i++){
			GirarDerecha();
		}
	}
}
