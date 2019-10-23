using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Move : MonoBehaviour
{
    /* public float speed;
     private Rigidbody rb;

     void Start()
     {
         rb = GetComponent<Rigidbody>();
     }

     void Update()
     {
         float moveHorizontal = Input.GetAxis("Horizontal");
         float moveVertical = Input.GetAxis("Vertical");

         Vector3 movement = new Vector3(moveHorizontal, 0.0f, moveVertical);

         rb.AddForce(movement * speed);
     }

     void OnTriggerEnter(Collider other)
     {
         if (other.gameObject.CompareTag("Pared"))
             Debug.Log("Algo");
                 //other.gameObject.SetActive(false);
     }

     void OnCollisionEnter(Collision other)
     {
         if (other.gameObject.CompareTag("Pared"))
             Debug.Log("Tocando pared");
     }*/

    public float velocidad;
    private Rigidbody rb;

    void start() {

    }

    void update() {
        if (Input.GetKey(KeyCode.UpArrow) || Input.GetAxis("Vertical") == 1) {
            this.transform.Translate(Vector3.forward * Time.deltaTime * velocidad);
        }
        if (Input.GetKeyDown(KeyCode.DownArrow) || Input.GetAxis("Vertical") == -1) {
            transform.Translate(0, 0, Time.deltaTime * velocidad * -1);
        }
        if (Input.GetKeyDown(KeyCode.RightArrow) || Input.GetAxis("Horizontal") == 1) {
            //actuador.GirarDerecha();
        }
        if (Input.GetKeyDown(KeyCode.LeftArrow) || Input.GetAxis("Horizontal") == -1) {
            //actuador.GirarIzquierda();
        }
    }


}
