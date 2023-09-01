(deffacts datos-iniciales
    (padre-de "Mario" "Juan")
    (padre-de "Juan" "Pedro")
    (padre-de "Juan" "Laura")
    (madre-de "Ana" "Pedro")
    (hombre "Juan")
    (mujer "Ana")
    (hombre "Pedro")
    (hombre "Luis")
    (hombre "Miguel")
    (mujer "María")
    (mujer "Laura")
    (hombre "Carlos")
    (hombre "Mario")
)

(defrule hermano
    (or (and (padre-de ?p ?x) (padre-de ?p ?y) (not (eq ?x ?y)))
        (and (madre-de ?m ?x) (madre-de ?m ?z) (not (eq ?x ?z)))
    )
    (hombre ?x)
    (hombre ?y)
    =>
    (assert (Hermano ?x ?y))
)

(defrule abuelo
    (or (and (padre-de ?p ?x) (padre-de ?g ?p) (not (eq ?x ?g)))
        (and (madre-de ?m ?x) (madre-de ?g ?m) (not (eq ?x ?g)))
    )
    (hombre ?g)
    =>
    (assert (Abuelo ?g ?x))
)

(defrule tio
    (or (and (padre-de ?p ?x) (hermano ?p ?t) (not (eq ?x ?t)))
        (and (madre-de ?m ?x) (hermano ?m ?t) (not (eq ?x ?t)))
    )
    (hombre ?t)
    =>
    (assert (Tío ?t ?x))
)

(defrule primo
    (or (and (padre-de ?p1 ?x) (hermano ?p1 ?p2) (padre-de ?p2 ?y) (not (eq ?x ?y)))
        (and (madre-de ?m1 ?x) (hermano ?m1 ?m2) (madre-de ?m2 ?z) (not (eq ?x ?z)))
    )
    (hombre ?p1)
    (hombre ?p2)
    (hombre ?m1)
    (hombre ?m2)
    =>
    (assert (Primo ?p1 ?x))
    (assert (Primo ?m1 ?x))
)
