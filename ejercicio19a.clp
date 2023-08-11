(deftemplate persona "Tipo de entidad persona"
    (slot posicion (type INTEGER)); campo para la ordenación de los registros segun diferentes criterios
    (slot nombre)
    (multislot apellidos)
)
(deffacts personas
(persona (posicion 2)  (nombre Pedro) (apellidos "Ponce Sala"))
(persona (posicion 1)  (nombre Francisco) (apellidos "bbadsf afs"))
(persona (posicion 3)  (nombre Francisco) (apellidos "cccc ccc"))
)


(defrule ordenar-por-apellido
    ?p1 <- (persona (posicion ?pos1) (nombre ?n1) (apellidos $?a1))
    ?p2 <- (persona (posicion ?pos2&:(> ?pos2 ?pos1)) (nombre ?n2) (apellidos $?a2))
    (test (> (str-compare (nth$ 1 ?a1) (nth$ 1 ?a2)) 0))
    =>
    (modify ?p1 (posicion ?pos2))
    (modify ?p2 (posicion ?pos1))
)