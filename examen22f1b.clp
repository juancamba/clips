(deffacts fichas
    (importe-base)
)

(defrule imprimir
    ?i <- (importe-base)
    =>
    (printout t "imprimier" crlf)
    (retract ?i)

)