(deftemplate vehiculo
    (slot matricula )
    (slot color))


(defrule encontrar-vehiculo-de-color
   
    (vehiculo (matricula ?matricula) (color ?color))
    => (println "El vehiculo con matricula " ?matricula " es de color " ?color crlf)
)

(deffacts coches
    (vehiculo (matricula 1234) (color rojo))
    (vehiculo (matricula 5678) (color azul))
    (vehiculo (matricula 9012) (color verde))
    (vehiculo (matricula 3456) (color rojo))
)
(assert (vehiculo (matricula 1234) (color rojo)))