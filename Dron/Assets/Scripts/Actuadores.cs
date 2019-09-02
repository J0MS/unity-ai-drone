using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Actuadores : MonoBehaviour
{
    private Rigidbody rb; // Componente para simular acciones físicas realistas
    private Bateria bateria; // Componente adicional (script) que representa la batería
    private Sensores sensor; // Componente adicional (script) para obtener información de los sensores
    private GameObject baseCarga;


    private float upForce; // Indica la fuerza de elevación del dron
    private float movementForwardSpeed = 250.0f; // Escalar para indicar fuerza de movimiento frontal
    private float wantedYRotation; // Auxiliar para el cálculo de rotación
    private float currentYRotation; // Auxiliar para el cálculo de rotación
    private float rotateAmountByKeys = 2.5f; // Auxiliar para el cálculo de rotación
    private float rotationYVelocity; // Escalar (calculado) para indicar velocidad de rotación
    private float sideMovementAmount = 250.0f; // Escalar para indicar velocidad de movimiento lateral

    public Transform target1;
    public Transform target2;

    // Asignaciones de componentes
    void Start(){
        rb = GetComponent<Rigidbody>();
        sensor = GetComponent<Sensores>();
        bateria = GameObject.Find("Bateria").gameObject.GetComponent<Bateria>();
        baseCarga = GameObject.Find("Base");
    }

    // ========================================
    // A partir de aqui, todos los métodos definidos son públicos, la intención
    // es que serán usados por otro componente (Controlador)

    public void Ascender(){
        upForce = 300;
        rb.AddRelativeForce(Vector3.up * upForce);
    }

    public void Descender(){
        upForce = 10;
        rb.AddRelativeForce(Vector3.up * upForce);
    }

    public void Flotar(){
        upForce = 98.1f;
        rb.AddRelativeForce(Vector3.up * upForce);
    }

    public void Adelante(){
        rb.AddRelativeForce(Vector3.forward * movementForwardSpeed);
    }

    public void Atras(){
        rb.AddRelativeForce(Vector3.back * movementForwardSpeed);
    }

    public void GirarDerecha(){
        wantedYRotation += rotateAmountByKeys;
        currentYRotation = Mathf.SmoothDamp(currentYRotation, wantedYRotation, ref rotationYVelocity, 0.25f);
        rb.rotation = Quaternion.Euler(new Vector3(rb.rotation.x, currentYRotation, rb.rotation.z));
    }

    public void GirarIzquierda(){
        wantedYRotation -= rotateAmountByKeys;
        currentYRotation = Mathf.SmoothDamp(currentYRotation, wantedYRotation, ref rotationYVelocity, 0.25f);
        rb.rotation = Quaternion.Euler(new Vector3(rb.rotation.x, currentYRotation, rb.rotation.z));
    }

    public void Derecha(){
        rb.AddRelativeForce(Vector3.right * sideMovementAmount);
    }

    public void Izquierda(){
        rb.AddRelativeForce(Vector3.left * sideMovementAmount);
    }

    public void Detener(){
        rb.velocity = Vector3.zero;
        rb.angularVelocity = Vector3.zero;
    }

    public void Limpiar(GameObject basura){
        basura.SetActive(false);
        sensor.SetTocandoBasura(false);
        sensor.SetCercaDeBasura(false);
    }

    public void irABase () {
        //transform.LookAt(target1.transform);
        //transform.position = Vector3.MoveTowards(transform.position, target1.position, 0.1f*Time.deltaTime);
        //transform.position = Vector3.MoveTowards(transform.position, baseCarga.transform.position, 7.0f*Time.deltaTime);
        rb.rotation = Quaternion.identity;
        Quaternion OriginalRot = transform.rotation;
        transform.LookAt(target1);
        Quaternion NewRot = transform.rotation;
        transform.rotation = OriginalRot;
        transform.rotation = Quaternion.Lerp(transform.rotation, NewRot, 0.1f);
        rb.velocity = new Vector3(0.1f, 0.1f, 0.1f);

 //transform.LookAt(target1.transform);
 transform.position = Vector3.MoveTowards(transform.position, target1.position, 0.1f);


    }
   public void buscarBase () {

   }

    public void CargarBateria(){
        bateria.Cargar();
    }

    public void girar90 () {
      currentYRotation = Mathf.SmoothDamp(currentYRotation, currentYRotation + 90, ref rotationYVelocity, 0.25f);
      rb.rotation = rb.rotation = Quaternion.Euler(new Vector3(rb.rotation.x, currentYRotation, rb.rotation.z));
      //transform.Rotate(0,90,0);
    }

}
