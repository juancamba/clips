(deftemplate nodo-binario "estructura del nodo del arbol binario"
    (slot nodo-id (type INTEGER))
    (slot pregunta (type STRING))
    (slot nodo-yes (type INTEGER))
    (slot nodo-not (type INTEGER))
)

(deftemplate nodo-terminal "estructura del nodo terminal del arbol"
    (slot nodo-id (type INTEGER))
    (slot indicacion (type STRING))
)

(deffacts arbol-binario "contenidos de los nodos que componen en arbol"
    (nodo-binario (nodo-id 1) (pregunta "Starter turning") (nodo-yes 2) (nodo-not 3))
    (nodo-binario (nodo-id 2) (pregunta "Got any petrol") (nodo-yes 4) (nodo-not 5))
    (nodo-binario (nodo-id 3) (pregunta "Lights working") (nodo-yes 6) (nodo-not 7))
    (nodo-binario (nodo-id 6) (pregunta "Solenoid clik") (nodo-yes 8) (nodo-not 9))
    (nodo-binario (nodo-id 8) (pregunta "Terminals clean") (nodo-yes 10) (nodo-not 11))
    (nodo-binario (nodo-id 9) (pregunta "Solenoid fuse OK") (nodo-yes 12) (nodo-not 13))
    (nodo-terminal (nodo-id 4) (indicacion "Call de A.A."))
    (nodo-terminal (nodo-id 5) (indicacion "Buy same"))
    (nodo-terminal (nodo-id 7) (indicacion "Charge battery"))
    (nodo-terminal (nodo-id 10) (indicacion "Replace starter"))
    (nodo-terminal (nodo-id 11) (indicacion "Clean terminals"))
    (nodo-terminal (nodo-id 12) (indicacion "Replace solenoid"))
    (nodo-terminal (nodo-id 13) (indicacion "Replace fuse"))
    (nodo-activo 1)
)

(defrule pide-datos "Presenta la pregunta del nodo y navega por el arbol"
    ?n <- (nodo-activo ?nodo)
    (nodo-binario (nodo-id ?nodo) (pregunta ?pregunta) (nodo-yes ?ny) (nodo-not ?nn))
    =>
        (retract ?n)
        (printout t crlf ?pregunta " (Y/-)?: " crlf)
        (if (eq (read) Y) then (assert (nodo-activo ?ny)) else (assert (nodo-activo ?nn)) )
)

(defrule presenta-conclusiones "Presenta la indicacion correspondiente"
    ?n <- (nodo-activo ?nodo)
    (nodo-terminal (nodo-id ?nodo) (indicacion ?indicacion))
=>
    (retract ?n)
    (printout t crlf ?indicacion "!" crlf crlf)
)