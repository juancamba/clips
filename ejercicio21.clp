(deftemplate trayecto "trayecto"
    (slot origen)
    (slot destino)
    (slot tipo-transporte)
    (slot importe (type INTEGER))
)

(deftemplate billete "billete"
    (slot origen)
    (slot destino)
    (slot tipo-transporte(type SYMBOL))
    (slot preferente? (type SYMBOL))
    (slot edad-viajero(type SYMBOL))
    (slot tipo-dia(type SYMBOL))
    (slot asiduo? (type SYMBOL))
    (slot tarifa-edad(type SYMBOL))
    (slot importe(type INTEGER))

)
(deftemplate suplementos "suplementos"
    (slot preferente (type FLOAT))
    (slot dia-azul (type FLOAT))
    (slot dia-rojo (type FLOAT))
    (slot viajero-asiduo (type FLOAT))
    (slot tarifa-joven (type FLOAT))
    (slot tarifa-dorada (type FLOAT))
    (slot exceso-peso-margen (type INTEGER))
    (slot importe-margen (type INTEGER))
)

(deffacts tarifas
    (trayecto (origen Madrid)(destino Cordoba)(tipo-transporte A) (importe 70))
    (trayecto (origen Madrid) (destino Cordoba) (tipo-transporte T) (importe 60))
    (trayecto (origen Madrid) (destino Sevilla) (tipo-transporte A) (importe 80))
    (trayecto (origen Madrid) (destino Sevilla) (tipo-transporte T) (importe 70))
    (trayecto (origen Barcelona) (destino Madrid) (tipo-transporte T) (importe 80))
    (suplementos (preferente 0.3) (dia-azul -0.1) (dia-rojo 0.1) (viajero-asiduo -0.1) (tarifa-joven -0.1) (tarifa-dorada -0.5 ))
    ; desglose de edades
    (edad-joven 22)
    (edad-mayor 65)
    

)

(defrule pide-datos "Pide los datos del envio"
    ;(declare (salience -1) )
    (edad-joven ?joven)
    (edad-mayor ?mayor)
    
    =>
    (printout t crlf "Datos del billete" crlf)
    (printout t crlf "Origen: " )
    (bind ?origen (read))
    (printout t crlf "Destino: ")
    (bind ?destino (read))
    (printout t crlf "Tipo de tren, AVE (A) o Talgo (T): ")
    (bind ?tipo-transporte (read))
    (printout t crlf "Viaja en preferente (S/N): ")
    (bind ?preferente? (read))
    (printout t crlf "La fecha del viaje es dia Normal (N), Azul (A) o Rojo (R): ")
    (bind ?tipo-dia (read))
    (printout t crlf "Es viajero asiduo (S/N): ")
    (bind ?asiduo? (read))
    (printout t crlf "Edad del viajero (años): ")
    (bind ?edad (read))
    (if (< ?edad ?joven) then
        (assert (billete (origen ?origen) (destino ?destino) (tipo-transporte ?tipo-transporte) (preferente? ?preferente?)
        (tipo-dia ?tipo-dia) (asiduo? ?asiduo?) (tarifa-edad J) (importe 0)))
    else
    (if (> ?edad ?mayor) then
        (assert (billete (origen ?origen) (destino ?destino) (tipo-transporte ?tipo-transporte) (preferente?
     ?preferente?) (tipo-dia ?tipo-dia) (asiduo? ?asiduo?) (tarifa-edad D) (importe 0)))
    else
        (assert (billete (origen ?origen) (destino ?destino) (tipo-transporte ?tipo-transporte) (preferente?
        ?preferente?) (tipo-dia ?tipo-dia) (asiduo? ?asiduo?) (tarifa-edad N) (importe 0)))
    )
    )
    ;(retract ?i)
    (assert(trayecto-tipo))
)
(defrule calcula-importe-trayecto-tipo-tren "calcula el importe en función del origen, destino y tipo de transporte"
    (printout t crlf "Trayecto tipo")
    ?i <- (trayecto-tipo)
    ?e <- (billete (origen ?origen) (destino ?destino) (tipo-transporte ?tipo) )
    (trayecto (origen ?origen) (destino ?destino) (tipo-transporte ?tipo) (importe ?importe))
    =>
    (modify ?e (importe ?importe))
    (retract ?i)
    (assert (clase))
   ;(assert (calcula-total))
)
(defrule suma-clase "acumula el importe de clase preferente, si lo es"
    ?i <- (clase)
    ?e <- (billete (preferente? S)(importe ?importe))
    (suplementos(preferente ?preferente))
    =>
    (modify ?e (importe (* ?importe (+ 1 ?preferente))))
    (retract ?i)
    (assert (calcula-total))
)

(defrule presenta-importe "presenta el precio final del billete"
    ?i <- (calcula-total)
    (billete (importe ?importe))
    =>
    (printout t crlf "El precio del billete es: " ?importe crlf)
    (retract ?i)
)