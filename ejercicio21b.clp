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
    (slot importe(type INTEGER))

)
(deftemplate suplementos "suplementos"
    (slot preferente (type FLOAT))
    (slot importe-margen (type INTEGER))
)

(deffacts tarifas
    (trayecto (origen Madrid)(destino Cordoba)(tipo-transporte A) (importe 10))
    (trayecto (origen Madrid) (destino Cordoba) (tipo-transporte T) (importe 20))
    (trayecto (origen Madrid) (destino Sevilla) (tipo-transporte A) (importe 100))
    (trayecto (origen Madrid) (destino Sevilla) (tipo-transporte T) (importe 200))
    
    (suplementos (preferente 0.3))
    ; desglose de edades

    (billete (origen Madrid)(destino Sevilla)(tipo-transporte A)(preferente? N)(importe 0))
)

(defrule importeBase "calcular importe base"
    ;(declare (salience -1) )
    ?e <- (billete (origen ?origen)(destino ?destino)(tipo-transporte ?tipo)(importe ?i))
    (trayecto (origen ?origen) (destino ?destino) (tipo-transporte ?tipo) (importe ?importe))
   ;?i <- (billete (importe ?importe))
=>
    
    (modify ?e (importe ?importe))
    
     (printout t "El precio del billete" ?origen" - "?destino " es: " ?importe crlf)
    
    
    
)
