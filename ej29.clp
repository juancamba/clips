(deffacts datos-a-permutar
    (vector rojo azul verde)

)

(defrule permutacion-inicial
    (vector $?datos)
    =>
    (assert (permutacion $?datos))


)

;;; Para generar permutaciones de una lista sera suficiente cambiar de
;;; posici\'on, de todas las maneras posibles, dos elementos consecutivos en
;;; dicha lista. Este mismo proceso se puede aplicar a las permutaciones
;;; resultantes y as\'i, sucesivamente, hasta obtener todas las permutaciones
;;; posibles.
(defrule permuta
    (permutacion $?ini ?x ?y $?fin)
    (not (permutacion $?ini ?y ?x $?fin))
    =>
(assert (permutacion $?ini ?y ?x $?fin)))



;;; Finalmente escribir una regla que presente en pantalla las permutaciones
;;; obtenidas.
(defrule imprime-permutaciones
(permutacion $?datos)
=>
(printout t "Una permutacion es: "$?datos crlf))