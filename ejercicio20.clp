(deftemplate ruta "Ruta y tipo de envíos"
    (slot origen)
    (slot destino)
    (slot tipo)
    (slot importe (type INTEGER))
)
(deftemplate envio "Datos del envio"
    (slot origen)
    (slot destino)
    (slot tipo (type SYMBOL))
    (slot urgente? (type SYMBOL))
    (slot peso (type INTEGER))
    (slot importe (type INTEGER))
)
(deftemplate suplementos "suplemento que se paga por entrega rápida"
    (slot entrega-rapida (type INTEGER))
    (slot exceso-peso-minimo (type INTEGER))
    (slot importe-peso-minimo (type INTEGER))
    (slot exceso-peso-margen (type INTEGER))
    (slot importe-margen (type INTEGER))
)
(deffacts tarifas
    (ruta (origen Madrid) (destino Barcelona) (tipo C) (importe 4))
    (ruta (origen Madrid) (destino Barcelona) (tipo P) (importe 7))
    (ruta (origen Madrid) (destino Toledo ) (tipo C) (importe 2))
    (ruta (origen Madrid) (destino Toledo ) (tipo P) (importe 6))
    (ruta (origen Madrid) (destino Badajoz) (tipo C) (importe 3))
    (ruta (origen Madrid) (destino Badajoz) (tipo P) (importe 7))
    (ruta (origen Barcelona) (destino Cadiz) (tipo C) (importe 6))
    (ruta (origen Barcelona) (destino Cadiz) (tipo P) (importe 8))
    (ruta (origen Barcelona) (destino Gerona) (tipo C) (importe 2))
    (ruta (origen Barcelona) (destino Gerona) (tipo P) (importe 4))
    (ruta (origen Barcelona) (destino Badajoz) (tipo C) (importe 4))
    (ruta (origen Barcelona) (destino Badajoz) (tipo C) (importe 9))
    (suplementos (entrega-rapida 60) (exceso-peso-minimo 2000) (exceso-peso-margen 100) (importe-margen 6))
)

(defrule pide-datos "Pide los datos del envio"
    (declare (salience -1))
=>
    (printout t crlf "Datos del envío" crlf)
    (printout t crlf "Origen: " )
    (bind ?origen (read))
    (printout t crlf "Destino: ")
    (bind ?destino (read))
    (printout t crlf "Es una carta (C) o un paquete (P): ")
    (bind ?tipo (read))
    (printout t crlf "Es urgente? (S/N): ")
    (bind ?urgente (read))
    (assert (envio (origen ?origen) (destino ?destino) (tipo ?tipo) (urgente? ?urgente) (peso 0) (importe 0)))
)
(defrule calcula-importe "calcula el importe en función del origen, destino, urgencia y tipo"
    ?e <- (envio (origen ?origen) (destino ?destino) (tipo ?tipo) (urgente? ?urgente) (peso 0) (importe 0))
    (ruta (origen ?origen) (destino ?destino) (tipo ?tipo) (importe ?importe))
    (suplementos (entrega-rapida ?entrega-rapida))
    =>
    (if (eq ?urgente S) then (bind ?importe (+ ?importe ?entrega-rapida)))
    (modify ?e (importe ?importe))
)

(defrule suma-importe-exceso-peso "acumula el importe del peso extra"
    ?e <- (envio (tipo P) (peso 0) (importe ?importe&:(> ?importe 0)))
        (suplementos (exceso-peso-minimo ?peso-minimo) (importe-peso-minimo ?importe-peso-minimo)
        (exceso-peso-margen ?margen) (importe-margen ?importe-margen))
    =>
    (printout t crlf "Peso?: ")
    (bind ?peso (read))
        (if (> ?peso ?peso-minimo) then
            (bind ?importe (+ ?importe ?importe-peso-minimo))
            (bind ?exceso (div (- ?peso ?peso-minimo) ?margen))
            (if (> ?exceso 0) then 
                (bind ?importe (+ ?importe (* ?exceso ?importe-margen))))
        )
    (modify ?e (peso ?peso) (importe ?importe))
)

; Regla final que termina presentando el coste del envio.
(defrule presenta-importe "presenta el coste del envio"
    (declare (salience -10))
    ?e <- (envio (importe ?importe))
    =>
    (printout t crlf "El coste del envío es: " ?importe crlf)
)