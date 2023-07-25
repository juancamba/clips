;Se plantea un sistema experto para la ayuda a la composición de programas musicales en emisoras de radio. El programa
;de radio tiene una duración determinada que se pretende cubrir con canciones cuya duración se acerque lo más posible a la duración
;prevista para el programa. Las canciones además de una duración tienen un identificador y una intensidad (de 1 a 5).

(deftemplate cancion
    (slot id(type INTEGER))
    (slot intensidad(type INTEGER)(range 1 5))
    (slot duracion(type INTEGER))
    

)

(deftemplate programa
    (slot nombre (type STRING))
    (slot duracion (type INTEGER))
    (multislot canciones (type INTEGER))
    (slot duracion_completa (type INTEGER) (default 0))
)
(deffacts programa-y-canciones
    (programa (nombre "matinal") (duracion 60))
    (cancion (id 1) (intensidad 3) (duracion 7))
    (cancion (id 2) (intensidad 1) (duracion 3))
    (cancion (id 2) (intensidad 1) (duracion 3))
    (cancion (id 3) (intensidad 2) (duracion 2))
    (cancion (id 4) (intensidad 5) (duracion 6))
    (cancion (id 5) (intensidad 2) (duracion 5))
    (cancion (id 6) (intensidad 1) (duracion 4))
)

(defrule programar
    ?p <- (programa (duracion ?dur_prog) (canciones $?canciones ?ultima_cancion) (duracion_completa ?dur_compl))
    (cancion (id ?id_cancion) (intensidad ?int_cancion) (duracion ?dur_cancion))
    (cancion (id ?ultima_cancion) (intensidad ?int_ultima_cancion))
    (test (neq ?id_cancion ?ultima_cancion))
    (test (not (member$ ?id_cancion $?canciones)))
    (test (<= (+ ?dur_compl ?dur_cancion) ?dur_prog))
    (test (<= (abs (- ?int_cancion ?int_ultima_cancion)) 1 ))
    =>
    (modify ?p (canciones $?canciones ?ultima_cancion ?id_cancion) (duracion_completa (+ ?dur_compl ?dur_cancion)))
)

(defrule primera_cancion_max_intensidad
    ?p <- (programa (duracion ?dur_prog) (duracion_completa 0))
    (cancion (id ?id_cancion) (intensidad ?int_cancion) (duracion ?dur_cancion))
    (not (cancion (intensidad ?int&:(> ?int ?int_cancion))))
    =>
    (modify ?p (canciones ?id_cancion) (duracion_completa ?dur_cancion))
)

(defrule ultima_cancion
    ?p <- (programa (duracion ?dur_prog) (canciones $?canciones) (duracion_completa ?dur_compl&:(< ?dur_compl ?dur_prog)))
    (cancion (id ?id_cancion) (duracion ?dur_cancion))
    (test (not (member$ ?id_cancion $?canciones)))
    (not (cancion (duracion ?dur&:(< ?dur (- ?dur_prog ?dur_compl)))))
    (not (cancion (id ?id&:(not (member$ ?id $?canciones))) (duracion ?dur&:(< ?dur ?dur_cancion))))
=>
    (modify ?p (canciones $?canciones ?id_cancion) (duracion_completa (+ ?dur_compl ?dur_cancion)))
)