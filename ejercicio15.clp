;Implementar en el lenguaje CLIPS el conjunto de los operadores del mundo de los bloques. La solución debe, mediante
;reglas de inferencia, identificar la trayectoria de los estados alcanzados, partiendo de un estado inicial, y los operadores aplicados,
;que reflejen los movimientos efectuados por el robot hasta alcanzar el estado meta (u objetivo).
; NO ESTÁ MUY CLARO COMO LOS IMPLEMENTA:
; AQUI HAY OTRO EJEPMLO: https://github.com/TheLokin/El-Mundo-de-los-Bloques


; coger solo puede coger los bloques que están sobre la mesa, si está apilado no se puede coger y si tiene por encima algo tampoco
; dejar el bloque debe estar en la pinza, y es dejar sobre la mesa, no es dejar sobre la pila
; desapilar, pinza vacia, bloque1 sobre bloque 2 
; apilar, bloque en la pinza, nada encima del bloque 2



(deftemplate apilado
    (slot encima (type SYMBOL))
    (slot debajo (type SYMBOL))
)
(deftemplate objetivo
    (slot encima (type SYMBOL))
    (slot debajo (type SYMBOL))
)
(deffacts bloques
; Estado de partida
; nada encima de B encima de A encima de mesa
; nada encima de C encima de D encima de mesa
(apilado (encima B) (debajo A))
(apilado (encima nada) (debajo B))
(apilado (encima C) (debajo D))
(apilado (encima nada) (debajo C))
(apilado (encima D) (debajo mesa))
(apilado (encima A) (debajo mesa))
; Estado final u objetivo
(objetivo (encima A) (debajo D))
)
; reglas
(defrule Objetivo-logrado
    (declare (salience 110))
        ?obj <- (objetivo (encima ?a) (debajo ?b))
        ?x <- (apilado (encima nada) (debajo ?a))
        ?y <- (apilado (encima nada) (debajo ?b))
        ?z <- (apilado (encima ?a) (debajo ?c))
    =>
    (modify ?z (debajo ?b))
    (retract ?obj ?y)
    (printout t crlf "Objetivo conseguido" crlf)
)


(defrule Objetivo-arriba-la-mesa
    ?obj <- (objetivo (encima ?a) (debajo ?b))
    ?x <- (apilado (encima ?algo&:(neq ?algo nada)) (debajo ?a))
    =>
    (assert (objetivo (encima ?algo) (debajo mesa)))
    (printout t "Objetivo: encima " ?algo " debajo: mesa" crlf)
)

(defrule Objetivo-abajo-a-la-mesa
    ?obj <- (objetivo (encima ?a) (debajo ?b))
    ?x <- (apilado (encima ?algo&:(neq ?algo nada)) (debajo ?b))
=>
    (assert (objetivo (encima ?algo) (debajo mesa)))
    (printout t "Objetivo: encima " ?algo " debajo: mesa" crlf)
)

(defrule Objetivo-cumplido
    (declare (salience 100))
    ?obj <- (objetivo (encima ?a) (debajo mesa))
    (apilado (encima ?a) (debajo mesa))
    =>
    (retract ?obj)
)
(defrule mover-a-la-mesa
    ?obj <- (objetivo (encima ?a) (debajo mesa))
    (apilado (encima nada) (debajo ?a))
    ?y <- (apilado (encima ?a) (debajo ?b))
=>
    (retract ?obj)
    (modify ?y (debajo mesa))
    (assert (apilado (encima nada) (debajo ?b)))
    (printout t "muevo " ?a " a la mesa" crlf)
)