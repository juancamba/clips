(deffacts los_datos
    (datos 1 5 7 9)
    
    (suma 0)

)
(defrule regla-suma
    ?f1<-(datos ?x $?resto)
    ?f2<-(suma ?s)
    =>
    (retract ?f2)
    (assert (suma (+ ?x ?s)))
    (retract ?f1)
    (assert (datos ?resto)))


;(load "D:\\Juan\\UNED\\2022 - 2023\\Ingenieria y gestion conocimiento\\clips_codigo\\clips\\ejercicio3.1.clp")
