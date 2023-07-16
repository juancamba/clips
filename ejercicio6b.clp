; template para un alumno con su nombre, nota. 
;regla que muestre por pantalla los que sacaron >= 5, es decir lo que aprobaron y otro mensaje con los que no aprobaron
;ademas, los que aprobaron, vamos a lanzar un hecho con ellos
(deftemplate alumno
    (slot nombre(type STRING))
    (slot nota(type NUMBER) (range 0 10))
)
(deffacts insertar-alumno
    (alumno (nombre "Juan") (nota 7))
    (alumno (nombre "Grabril") (nota 5))
    (alumno (nombre "Esteban Quito") (nota 9))
    (alumno (nombre "Armando Esteban Quito") (nota 6))
    (alumno (nombre "Pedro") (nota 4))
)

(defrule aprobados
    ?r1<-(alumno (nombre ?nombre)(nota ?nota))
    (test(>= ?nota 5))
    =>
    (printout t ?nombre ": APROBADO: "?nota crlf)
    (retract ?r1)
    (assert(aprobado ?nombre ?nota))
    
)
(defrule suspenso
    
    ?r1<-(alumno (nombre ?nombre)(nota ?nota))
    (test (<= ?nota 5))
    =>
    (printout t ?nombre ": SUSPENSO: " ?nota crlf)
    (retract ?r1)
    
)