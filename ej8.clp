;Construimos una plantilla fecha, en la cual vamos a tener los slots dia que
;sólo podrá tomar valores comprendidos entre 1 y 31, el slot mes que sólo podrá
;tomar valores comprendidos entre 1 y 12 y el slot anno.
(deftemplate fecha
(slot dia (type INTEGER) (range 1 31))
(slot mes (type INTEGER) (range 1 12))
(slot anno)
)

;Construimos una regla comprobar_meses_30, en la cual vemos si es correcto un mes
;que tenga 30 o menos días, en la cual mostramos un mensaje de fecha correcta e insertamos
;un hecho de fecha-correcta, este hecho es para luego construir una regla para mostrar
;un mensaje de error si la fecha introducida no es correcta.
(defrule comprobar_meses_30
    (fecha (dia ?d) (mes ?m & 4 | 6 | 9 | 11) (anno ?a))
    (test (<= ?d 30))
    =>
    (printout t "La fecha " ?d "/" ?m "/" ?a " es una fecha correcta " crlf)
    (assert (fecha-correcta ?d ?m ?a))
)

;Construimos una regla comprobar_meses_31, en la cual vamos a comprobar que los meses
;sean 1, 3, 5, 7, 8, 10, 12 que son los que tienen 31 dias, y no se va a ejecutar en otra regla,
;ademas como en la regla anterior hemos puesto la condición de que sea menor o igual a 30,
;esta regla se va a disparar en cualquier dia que tenga como meses 1, 3, 5, 7, 8, 10, 12,
;a no ser que el día introducido no esté comprendido entre el rango.
;También se va a encargar de mostrarnos un mensaje de fecha correcta e insertar un hecho
;de fecha-correcta, este hecho es para luego construir una regla para mostrar un mensaje
;de error si la fecha introducida no es correcta.
(defrule comprobar_meses_31
    (fecha (dia ?d) (mes ?m 1 | 3| 5 | 7 | 8 | 10 | 12 ) (anno ?a))
    =>
    (printout t "La fecha " ?d "/" ?m "/" ?a " es una fecha correcta " crlf)
    (assert (fecha-correcta ?d ?m ?a))
)

;Construimos una regla comprobar_mes, en la cual vamos a comprobar el mes de febrero,
;y si el dia es menor o igual a 28. También se va a encargar de mostrarnos un mensaje de
;fecha correcta e insertar un hecho de fecha-correcta, este hecho es para luego construir una
;regla para mostrar un mensaje de error si la fecha introducida no es correcta.
(defrule comprobar_mes_28
    (fecha (dia ?d) (mes 2) (anno ?a))
    (test (<= ?d 28))
    =>
    (printout t "La fecha " ?d "/2" "/" ?a " es una fecha correcta " crlf)
    (assert (fecha-correcta ?d 2 ?a))
)
;Construimos una regla comprobar_bisiesto, en la cual vamos a comprobar si el año es bisiesto,
;ya que puede tomar febrero un máximo de 29 días. También se va a encargar de mostrarnos
;un mensaje de fecha correcta e insertar un hecho de fecha-correcta, este hecho es para luego
;construir una regla para mostrar un mensaje de error si la fecha introducida no es correcta.
(defrule comprobar_bisiesto
    (fecha (dia ?d) (mes 2) (anno ?a))
    (test ( = ?d 29))
    (and (test (= (mod ?a 4) 0))
    (test (not (= (mod ?a 100) 0))))
        (or (test (= (mod ?a 4) 0))
        (test (= (mod ?a 400) 0)))
=>
    (printout t "La fecha " ?d "/2" "/" ?a " es una fecha correcta " crlf)
    (assert (fecha-correcta ?d 2 ?a))
)

;Construimos una regla fecha_incorrecta, en la cual vamos a mostrar un mensaje de error
;si la fecha no es correcta, para comprobar si una fecha no es correcta, tenemos que comprobar
;que existe un hecho como fecha-correcta, en la cual si no existe dicho hecho significa que no es
;una fecha correcta y entonces muestra el mensaje de error.
(defrule fecha_incorrecta
    (fecha (dia ?d) (mes ?m) (anno ?a))
    (not (fecha-correcta ?d ?m ?a))
    =>
    (printout t "La fecha " ?d "/" ?m "/" ?a " es una fecha incorrecta " crlf)
)