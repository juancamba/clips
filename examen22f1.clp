(deftemplate ficha "ficha"
    (slot temp(type INTEGER))
    (slot puntos(type SYMBOL))
    (slot erupcion (type SYMBOL))
    (slot garganta(type SYMBOL))
    (slot vacunado(type SYMBOL))

)
(deftemplate resultado "resultado"
    (slot diagnostico(type SYMBOL))
    (slot tratamiento(type SYMBOL))
)
(deffacts fichas
    (ficha(temp 38)(puntos SI)(erupcion NdO)(garganta NO)(vacunado SI))
   
    
)
(defrule sarampion 
    
    ;(printout t "sarampion" crlf)
    ?f <- (ficha (puntos SI)(vacunado NO))
   =>
    (assert (resultado (diagnostico sarampion)))
)
(defrule alergia
    (ficha (puntos SI)(vacunado SI)(erupcion ?e&:(or (eq ?e SI)(eq ?e NO))))
    =>
    (assert (resultado (diagnostico alergia)))
)
(defrule diagnosticar-gripe
    (ficha (garganta SI)(temp ?t&:(>= ?t 38)))
    =>
    (assert (resultado (diagnostico gripe)))
)
(defrule tratamiento
    ?r <- (resultado (diagnostico ?d))
    =>
    (switch ?d
        (case sarampion then (bind ?tratamiento penicilina))
        (case gripe then (bind ?tratamiento "resposo en cama"))
        (case alergia then (bind ?tratamiento "anti estaminico"))
        (default (bind ?tratamiento "VISITE SU MEDICO"))
    )
    
    (modify ?r (tratamiento ?tratamiento))

)

(defrule imprimir "imprimir"
    ;(printout "imrpmir" crlf)
    
    
    ?e <- (resultado (diagnostico ?d) (tratamiento ?t))
    =>
    (printout t "diagnostico " ?d " tratamiento: " ?t crlf)
    
    
)
