(deftemplate fecha
    (slot dia (type INTEGER) (range 1 31))
    (slot mes (type INTEGER) (range 1 12))
    (slot anno)
)

(defrule comprobar_meses_30
(   fecha (dia ?d) (mes ?m & 4 | 6 | 9 | 11) (anno ?a))
    (test (<= ?d 30))
=>
    (printout t "La fecha " ?d "/" ?m "/" ?a " es una fecha correcta " crlf)
    (assert (fecha-correcta ?d ?m ?a))
)
(defrule comprobar_meses_31
(   fecha (dia ?d) (mes ?m & 1 | 3 | 5 | 7 | 8 | 10 | 12) (anno ?a))
    (test (<= ?d 31))
=>
    (printout t "La fecha " ?d "/" ?m "/" ?a " es una fecha correcta " crlf)
    (assert (fecha-correcta ?d ?m ?a))
)
(defrule comprobar_mes_28
    (fecha (dia ?d) (mes 2) (anno ?a))
    (test (<= ?d 28))
    =>
    (printout t "La fecha " ?d "/2" "/" ?a " es una fecha correcta " crlf)
    (assert (fecha-correcta ?d 2 ?a))
)

(defrule comprobar_bisiesto
    (fecha (dia ?d) (mes 2) (anno ?a))
    (test ( = ?d 29)) (and (test (= (mod ?a 4) 0)) 
    (test (not (= (mod ?a 100) 0))))(or (test (= (mod ?a 4) 0)) (test (= (mod ?a 400) 0)))
=>
    (printout t "La fecha " ?d "/2" "/" ?a " es una fecha correcta " crlf)
    (assert (fecha-correcta ?d 2 ?a))
)

(defrule fecha_incorrecta
(fecha (dia ?d) (mes ?m) (anno ?a))
(not (fecha-correcta ?d ?m ?a))
=>
(printout t "La fecha " ?d "/" ?m "/" ?a " es una fecha incorrecta " crlf)
)

(deffacts fechas
(fecha (dia 1) (mes 1) (anno 2019))
(fecha (dia 31) (mes 12) (anno 2019))
(fecha (dia 29) (mes 2) (anno 2020))


)