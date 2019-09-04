using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class MovimientoPersona : MonoBehaviour
{ 

    public float movementSpeed = 2.0f;

    void Start()
    {
    }

    // Update is called once per frame
    void Update()
    {
        if (Input.GetKey(KeyCode.UpArrow) || Input.GetAxis("Vertical") == 1) {
            this.transform.Translate(0, 0, Time.deltaTime * movementSpeed);
        }
        if (Input.GetKey(KeyCode.DownArrow) || Input.GetAxis("Vertical") == -1) {
            transform.Translate(0, 0, Time.deltaTime * movementSpeed * -1);
        }
        if (Input.GetKey(KeyCode.RightArrow) || Input.GetAxis("Horizontal") == 1) {
            transform.Translate(Time.deltaTime * movementSpeed, 0, 0);
        }
        if (Input.GetKey(KeyCode.LeftArrow) || Input.GetAxis("Horizontal") == -1) {
            transform.Translate(Time.deltaTime * movementSpeed * -1, 0, 0);
        }

    }
}
