;• [0, 5): Suspenso
;• [5, 7): Aprobado
;• [7, 9): Notable
;• [9, 9.8): Sobresaliente
;• [9.8, 10]: Matrícula de honor.

(deftemplate nota
    (slot nombre (type STRING))
    (slot nota1 (type NUMBER) (range 0 10))
    (slot nota2 (type NUMBER) (range 0 10))
    (slot faltas (type INTEGER) (range 0 100) (default 0))
    (slot nota-nominal (type SYMBOL))
)
(deffacts Introducir_notas_numericas "InserciÛn de notas en la plantilla nota"
    (nota (nombre "Eduardo Javier Rodriguez Lopera")
    (nota1 8)
    (nota2 9)
    (faltas 15))
    (nota (nombre "Mercedes Granados Rodriguez")
    (nota1 9.5)
    (nota2 10)
    (faltas 2))
    (nota (nombre "Inmaculada Rodriguez Lopera")
    (nota1 10)
    (nota2 9.75))
)
(defrule nota_suspenso
    ?f1<-(nota (nombre ?nomb) (nota1 ?n1) (nota2 ?n2) (faltas ?falta) (nota-nominal nil))
    (test (>= (- (/ (+ ?n1 ?n2) 2) (* ?falta 0.1)) 0))
    (test (< (- (/ (+ ?n1 ?n2) 2) (* ?falta 0.1)) 5))
    =>
    (retract ?f1)
    (assert (nota (nombre ?nomb) (nota1 ?n1) (nota2 ?n2) (faltas ?falta) (nota-nominal Suspenso)))
)
(defrule nota_aprobado
    ?f1<-(nota (nombre ?nomb) (nota1 ?n1) (nota2 ?n2) (faltas ?falta) (nota-nominal nil))
    (test (>= (- (/ (+ ?n1 ?n2) 2) (* ?falta 0.1)) 5))
    (test (< (- (/ (+ ?n1 ?n2) 2) (* ?falta 0.1)) 7))
    =>
    (retract ?f1)
    (assert (nota (nombre ?nomb) (nota1 ?n1) (nota2 ?n2) (faltas ?falta) (nota-nominal aprobado)))
)
(defrule nota_notable
    ?f1<-(nota (nombre ?nomb) (nota1 ?n1) (nota2 ?n2) (faltas ?falta) (nota-nominal nil))
    (test (>= (- (/ (+ ?n1 ?n2) 2) (* ?falta 0.1)) 7))
    (test (< (- (/ (+ ?n1 ?n2) 2) (* ?falta 0.1)) 9))
    =>
    (retract ?f1)
    (assert (nota (nombre ?nomb) (nota1 ?n1) (nota2 ?n2) (faltas ?falta) (nota-nominal notable)))
)
(defrule nota_sobresaliente
    ?f1<-(nota (nombre ?nomb) (nota1 ?n1) (nota2 ?n2) (faltas ?falta) (nota-nominal nil))
    (test (>= (- (/ (+ ?n1 ?n2) 2) (* ?falta 0.1)) 9))
    (test (< (- (/ (+ ?n1 ?n2) 2) (* ?falta 0.1)) 9.8))
    =>
    (retract ?f1)
    (assert (nota (nombre ?nomb) (nota1 ?n1) (nota2 ?n2) (faltas ?falta) (nota-nominal Sobresaliente)))
)
(defrule nota_matricula
    ?f1<-(nota (nombre ?nomb) (nota1 ?n1) (nota2 ?n2) (faltas ?falta) (nota-nominal nil))
    (test (>= (- (/ (+ ?n1 ?n2) 2) (* ?falta 0.1)) 9.8))
    (test (<= (- (/ (+ ?n1 ?n2) 2) (* ?falta 0.1)) 10))
    =>
    (retract ?f1)
    (assert (nota (nombre ?nomb) (nota1 ?n1) (nota2 ?n2) (faltas ?falta) (nota-nominal Sobresaliente)))
)


