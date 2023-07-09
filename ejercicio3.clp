;Queremos un programa basado en reglas Clips (3 ptos) que pida al usuario introducir
;uno o varios colores y el programa debe mostrar en pantalla el nombre de todos aquellos
;países en cuya banderan aparezcan tales colores (supuestamente almacenados como hechos).
;La bandera podría contener otros colores además de los pedidos

; (load "D:\\Juan\\UNED\\2022 - 2023\\Ingenieria y gestion conocimiento\\clips_codigo\\ejercicios_resueltos\\ej3.clp")
; D:\Juan\UNED\2022 - 2023\Ingenieria y gestion conocimiento\clips_codigo\ejercicios_resueltos\ej3.clp

(deftemplate pais
    (slot nombre)
    (multislot bandera)
)

(deffacts paises
    (pais (nombre "España")(bandera rojo amarillo rojo))
    (pais (nombre "Francia")(bandera azul blanco rojo))
    (pais (nombre "Italia")(bandera verde blanco rojo))
   
    (pais (nombre "Argentina")(bandera celeste banco celeste))
)

(defrule pide-banderas
    (not (entrada $?))
    =>
    (printout t "Introduce colores de bandera: ")
    (bind $?colores (explode$(readline)))
    (assert (entrada $?colores))

)
(defrule debug
    (entrada $? ?color $?)
    (pais (nombre ?nombre) (bandera $?col-band))
    =>
    (printout t "La bandera de " ?nombre " con colores" ?col-band ". El color ingresado: " ?color crlf)
)
(defrule existe-banderas
    ?p<-(entrada $? ?color $?)
    (pais (nombre ?nombre) (bandera $?col-band))
    (test (member$ $?color $?col-band))
    =>
    (printout t "[COINCIDENCIA]La bandera de " ?nombre " tiene el color: " ?color crlf)
    (retract ?p)

)

