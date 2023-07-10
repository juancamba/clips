;Escriba las reglas y hechos necesarios para hallar el mínimo elemento de un hecho multivaluado de enteros, del tipo
;(datos 1 5 7 9).
(deftemplate lista
    (multislot datos (type INTEGER))
    (slot min (type INTEGER))
)
(deffacts los_datos
    (lista  
        (datos 1 5 7 9)
        (min 1000)
    )
)
(defrule minimo
    ?f<- (lista (datos $?resto1 ?x $?resto2) (min ?min &:(> ?min ?x)))
=>
    (modify ?f (min ?x))
)

;(load "D:\\Juan\\UNED\\2022 - 2023\\Ingenieria y gestion conocimiento\\clips_codigo\\clips\\ejercicio3.3.clp")
