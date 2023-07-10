(deffacts los_datos
    (datos 13 9 7 9)
    
    

)
(defrule ordena
    ?f1<-(datos $?antes ?x ?y $?resto)
    (test (> ?x ?y))
=>
   ( printout t "antes: " $?antes ",x: " ?x ",y: "?y ",resto: "$?resto  crlf)
    (retract ?f1)
    (assert (datos ?antes ?y ?x ?resto)))


;(load "D:\\Juan\\UNED\\2022 - 2023\\Ingenieria y gestion conocimiento\\clips_codigo\\clips\\ejercicio3.2.clp")
