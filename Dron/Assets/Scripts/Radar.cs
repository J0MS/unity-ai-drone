using System.Collections;
using System.Collections.Generic;
using UnityEngine;

// Componente auxiliar que utiliza un Collider esférico a manera de radar
// para comprobar colisiones con otros elementos.
// Las comprobaciones y métodos son análogos al componente (script) de Sensores.
public class Radar : MonoBehaviour
{
    private bool BaseDeCarga;
    private bool cercaDePared;
    private bool cercaObjetivo;

    void OnTriggerEnter(Collider other){
        if(other.gameObject.CompareTag("BaseDeCarga")){
            BaseDeCarga = true;
        }
        if(other.gameObject.CompareTag("Pared")){
            cercaDePared = true;
        }
        if (other.gameObject.CompareTag("Persona"))
        {
            cercaObjetivo = true;
        }
    }

    void OnTriggerStay(Collider other){
        if(other.gameObject.CompareTag("BaseDeCarga")){
            BaseDeCarga = true;
        }
        if(other.gameObject.CompareTag("Pared")){
            cercaDePared = true;
        }
        if (other.gameObject.CompareTag("Persona"))
        {
            cercaObjetivo = true;
        }
    }

    void OnTriggerExit(Collider other){
        if(other.gameObject.CompareTag("BaseDeCarga")){
            BaseDeCarga = false;
        }
        if(other.gameObject.CompareTag("Pared")){
            cercaDePared = false;
        }
        if (other.gameObject.CompareTag("Persona"))
        {
            cercaObjetivo = false;
        }
    }

    public bool CercaDeBaseDeCarga(){
        return BaseDeCarga;
    }

    public bool CercaDePared(){
        return cercaDePared;
    }

    public bool CercaPersona()
    {
        return cercaObjetivo;
    }

    public void setCercaDeBasura(bool value){
        BaseDeCarga = value;
    }
}
