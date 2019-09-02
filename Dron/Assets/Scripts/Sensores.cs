using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Sensores : MonoBehaviour
{
    private GameObject BaseDeCarga; // Auxiliar para guardar referencia al objeto
    private Radar radar; // Componente auxiliar (script) para utilizar radar esférico
    private Rayo rayo; // Componente auxiliar (script) para utilizar rayo lineal
    private Bateria bateria; // Componente adicional (script) que representa la batería
    private Actuadores actuador; // Componente adicional (script) para obtener información de los ac

    private bool tocandoPared; // Bandera auxiliar para mantener el estado en caso de tocar pared
    private bool cercaPared; // Bandera auxiliar para mantener el estado en caso de estar cerca de una pared
    private bool tocandoBaseDeCarga; // Bandera auxiliar para mantener el estado en caso de tocar basura
    private bool cercaBasura; // Bandera auxiliar para mantener el estado en caso de estar cerca de una basura

    // Asignaciones de componentes
    void Start(){
        radar = GameObject.Find("Radar").gameObject.GetComponent<Radar>();
        rayo = GameObject.Find("Rayo").gameObject.GetComponent<Rayo>();
        bateria = GameObject.Find("Bateria").gameObject.GetComponent<Bateria>();
        actuador = GetComponent<Actuadores>();
    }

    // ========================================
    // Los siguientes métodos permiten la detección de eventos de colisión
    // que junto con etiquetas de los objetos permiten identificar los elementos
    // La mayoría de los métodos es para asignar banderas/variables de estado.

    void OnCollisionEnter(Collision other){
        if(other.gameObject.CompareTag("Pared")){
            tocandoPared = true;
        }
    }

    void OnCollisionStay(Collision other){
        if(other.gameObject.CompareTag("Pared")){
            tocandoPared = true;
        }
        if(other.gameObject.CompareTag("BaseDeCarga")){
            actuador.CargarBateria();
        }
    }

    void OnCollisionExit(Collision other){
        if(other.gameObject.CompareTag("Pared")){
            tocandoPared = false;
        }
    }

    void OnTriggerEnter(Collider other){
        if(other.gameObject.CompareTag("BaseDeCarga")){
            tocandoBaseDeCarga = true;
            BaseDeCarga = other.gameObject;
        }
    }

    void OnTriggerStay(Collider other){
        if(other.gameObject.CompareTag("BaseDeCarga")){
            tocandoBaseDeCarga = true;
            BaseDeCarga = other.gameObject;
        }
    }

    void OnTriggerExit(Collider other){
        if(other.gameObject.CompareTag("BaseDeCarga")){
            tocandoBaseDeCarga = false;
        }
    }

    // ========================================
    // Los siguientes métodos definidos son públicos, la intención
    // es que serán usados por otro componente (Controlador)

    public bool TocandoPared(){
        return tocandoPared;
    }

    public bool CercaDePared(){
        return radar.CercaDePared();
    }

    public bool FrenteAPared(){
        return rayo.FrenteAPared();
    }

    public bool DerechaPared(){
        return rayo.DerechaPared();
    }

    public bool TocandoBaseDeCarga(){
        return tocandoBaseDeCarga;
    }

    public bool CercaDeBaseDeCarga(){
        return radar.CercaDeBaseDeCarga();
    }

    public float Bateria(){
        return bateria.NivelDeBateria();
    }

    public bool BateriaBaja(){
        return bateria.BateriaBaja();
    }

    public bool BateriaLlena(){
        return bateria.BateriaLlena();
    }

    public void reset(){
        rayo.reset();
    }

    // Algunos otros métodos auxiliares que pueden ser de apoyo

    public GameObject GetBaseDeCarga(){
        return BaseDeCarga;
    }

    public Vector3 Ubicacion(){
        return transform.position;
    }

    public void SetTocandoBaseDeCarga(bool value){
        tocandoBaseDeCarga = value;
    }

    public void SetCercaDeBasura(bool value){
        radar.setCercaDeBasura(value);
    }
}
