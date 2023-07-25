;A B C
;D E F
;G H I
; Aqui define solo dos direcciones al-norte-de y al-oeste-de. Las otras dos se hacen por inferencia: relaciones inversas
(deffacts ciudades
    (ubicada A al-oeste-de B)
    (ubicada B al-oeste-de C)
    (ubicada D al-oeste-de E)
    (ubicada E al-oeste-de F)
    (ubicada G al-oeste-de H)
    (ubicada H al-oeste-de I)
    (ubicada A al-norte-de D)
    (ubicada D al-norte-de G)
    (ubicada B al-norte-de E)
    (ubicada E al-norte-de H)
    (ubicada C al-norte-de F)
    (ubicada F al-norte-de I)
    (situacion B F)
)

; Reglas para inferir relaciones inversas (punto A)
(defrule al-sur-de
    (ubicada ?a al-norte-de ?b)
=>
    (assert (ubicada ?a al-sur-de ?a))
)
(defrule al-este-de
    (ubicada al-oeste-de ?a ?b)
=>
    (assert (ubicada ?b al-este-de ?a))
)

; Reglas para inferir relaciones transitivas
(defrule transitiva
    (ubicada ?a ?rel ?b)
    (ubicada ?b ?rel ?c)
=>
    (assert (ubicada ?a ?rel ?c))
    (printout t "Transitiva ?a "?a " ?rel "?rel " ?b "?b " - ?b "?b " ?rel "?rel " ?c "?c crlf)
)

; Reglas para inferir relaciones combinadas
(defrule noreste
    (ubicada ?a al-norte-de ?b)
    (ubicada ?b al-este-de ?c)
    =>
(assert (ubicada ?a al-noreste-de ?c))
)
(defrule noroeste
    (ubicada ?a al-norte-de ?b)
    (ubicada ?b al-oeste-de ?c)
    =>
    (assert (ubicada ?a al-noroeste-de ?c))
)
(defrule sureste
    (ubicada ?a al-sur-de ?b)
    (ubicada ?b al-este-de ?c)
    =>
    (assert (ubicada ?a al-sureste-de ?c))
)
(defrule suroeste
    (ubicada ?a al-sur-de ?b)
    (ubicada ?b al-oeste-de ?c)
    =>
    (assert (ubicada ?a al-suroeste-de ?c))
)

(defrule relacion-entre-ciudades
    (declare (salience -10))
    (situacion ?a ?b)
    (ubicada ?a ?rel ?b)
    =>
    (printout t ?a " está " ?rel " " ?b crlf)
)