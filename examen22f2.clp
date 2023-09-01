;Representar este conocimiento en clips
;los estudiantes son siempre jovenes
;los jovenes que estudian estan solteros
;los estudiantes que trabajan estan casados
;los estudiantes del seminarion, auque trabaje estan solteroslas personas independientes estan solteras
;soltero y casado son estados incompatibles
;maria estudia y jorge esta casado
;natalia estudia filosofia, es independiente per le gusta Daniel

(deftemplate estudiante
   (slot nombre)
   (slot estado)
   (slot estudia)
   (slot trabaja)
   (slot independiente)
)

(deftemplate relacion
   (slot persona1)
   (slot persona2)
   (slot gusta)
)

(deffacts conocimiento-inicial
   (estudiante (nombre Maria) (estado soltera) (estudia si) (trabaja no) (independiente no))
   (estudiante (nombre Jorge) (estado casado) (estudia no) (trabaja no) (independiente no))
   (estudiante (nombre Natalia) (estado soltera) (estudia si) (trabaja no) (independiente si))
   (relacion (persona1 Natalia) (persona2 Daniel) (gusta si))
)
;regla1: If a student studies, they are considered single.
(defrule regla1
   (estudiante (nombre ?nombre) (estado ?estado) (estudia si))
   =>
   (assert (estudiante (nombre ?nombre) (estado soltero)))
)
;regla2: If a student works, they are considered married.
(defrule regla2
   (estudiante (nombre ?nombre) (estado ?estado) (trabaja si))
   =>
   (assert (estudiante (nombre ?nombre) (estado casado)))
)
;regla3: If a student studies, works, and is independent, they are considered single.
(defrule regla3
   (estudiante (nombre ?nombre) (estado ?estado) (estudia si) (trabaja si) (independiente si))
   =>
   (assert (estudiante (nombre ?nombre) (estado soltero)))
)
;regla4: If a student is both single and married, retract the married state (as they are incompatible).
(defrule regla4
   (estudiante (nombre ?nombre) (estado soltero))
   (estudiante (nombre ?nombre) (estado casado))
   =>
   (retract (estudiante (nombre ?nombre) (estado casado)))
)

