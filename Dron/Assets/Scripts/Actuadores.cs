using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Actuadores : MonoBehaviour
{
    private Rigidbody rb; // Componente para simular acciones físicas realistas
    private Bateria bateria; // Componente adicional (script) que representa la batería
    private Sensores sensor; // Componente adicional (script) para obtener información de los sensores
    private GameObject baseC;
    private Vector3 initialPosition;
    private float alturaInicial;

    private float upForce; // Indica la fuerza de elevación del dron
    private float movementForwardSpeed = 250.0f;//250.0f; // Escalar para indicar fuerza de movimiento frontal
    private float wantedYRotation; // Auxiliar para el cálculo de rotación
    private float currentYRotation; // Auxiliar para el cálculo de rotación
    private float rotateAmountByKeys = 2.5f; // Auxiliar para el cálculo de rotación
    private float rotationYVelocity; // Escalar (calculado) para indicar velocidad de rotación
    private float sideMovementAmount = 250.0f; // Escalar para indicar velocidad de movimiento lateral

    // Asignaciones de componentes
    void Start(){
        rb = GetComponent<Rigidbody>();
        sensor = GetComponent<Sensores>();
        bateria = GameObject.Find("Bateria").gameObject.GetComponent<Bateria>();
        baseC = GameObject.FindGameObjectWithTag("BaseDeCarga");

        initialPosition = rb.transform.position;
        alturaInicial = transform.position.y;
    }

    // ========================================
    // A partir de aqui, todos los métodos definidos son públicos, la intención
    // es que serán usados por otro componente (Controlador)

    public void Estabilizar(){
      if (alturaInicial < transform.position.y || transform.position.y<1.5f){
        Vector3 velocity = Vector3.zero;
        Debug.Log("Estabilizar altura a " + alturaInicial);
        //Ascender();
        Vector3 nA = new Vector3(transform.position.x, alturaInicial, transform.position.z);
        transform.position = Vector3.SmoothDamp(transform.position, nA, ref velocity, 0.3f);
        //rb.velocity = new Vector3(0.5f,0.5f,0.5f);
      }
    }

    public void Ascender(){
        upForce = 190;
        rb.AddRelativeForce(Vector3.up * upForce);
    }

    public void Despegar(){
        //if (alturaInicial > transform.position.y)
          Vector3 velocity = Vector3.zero;
          Debug.Log("Altura Inicial: " + alturaInicial);
          //Ascender();
          Vector3 nA = new Vector3(transform.position.x, alturaInicial, transform.position.z);
          transform.position = Vector3.SmoothDamp(transform.position, nA, ref velocity, 4.0f * Time.deltaTime);
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
/**
    public void Limpiar(GameObject basura){
        basura.SetActive(false);
        sensor.SetTocandoBasura(false);
        sensor.SetCercaDeBasura(false);
    }*/

    public void acercarABase(){
        Vector3 target = initialPosition;
        target = baseC.transform.position;

        float fixedSpeed = 3 * Time.deltaTime;
        rb.transform.position = Vector3.MoveTowards(rb.transform.position, target, 0.1f);
        //transform.rotation = Quaternion.identity;

    }
    public void CargarBateria(){
        bateria.Cargar();
    }


    public void IrHaciaPersona()
    {
        transform.rotation = Quaternion.identity;
        Transform target = GameObject.FindGameObjectWithTag("Persona").transform;
        Vector3 seguimiento = target.position;
        //seguimiento.x = seguimiento.x - 2.0f;
        seguimiento.y = seguimiento.y + 1.0f;
        //seguimiento.z = seguimiento.z - 2.0f;
        transform.position = Vector3.MoveTowards(transform.position, seguimiento, 4.0f * Time.deltaTime);
    }

    public void Buscando() {
         transform.rotation = Quaternion.identity;
        //float y = transform.position.y;
        float x = Random.Range(-4f, 4f);
        //float y = Random.Range(-2f, 2f);
        float z = Random.Range(-4f, 4f);
        rb.AddForce(new Vector3(x, 0, z) * 100f);

    }
}
