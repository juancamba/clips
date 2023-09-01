
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
    (slot dia? (type SYMBOL))

)
(deftemplate suplementos "suplementos"
    (slot preferente (type FLOAT))
    (slot importe-margen (type INTEGER))
    (slot dia-azul (type FLOAT))
    (slot dia-rojo (type FLOAT))
    
)

(deffacts tarifas
    (trayecto (origen Madrid)(destino Cordoba)(tipo-transporte A) (importe 10))
    (trayecto (origen Madrid) (destino Cordoba) (tipo-transporte T) (importe 20))
    (trayecto (origen Madrid) (destino Sevilla) (tipo-transporte A) (importe 100))
    (trayecto (origen Madrid) (destino Sevilla) (tipo-transporte T) (importe 200))
    
    (suplementos (preferente 0.3)(dia-azul -0.1) (dia-rojo 0.1))
    ; desglose de edades

    (billete (origen Madrid)(destino Sevilla)(tipo-transporte A)(preferente? N)(importe 0)(dia? dia-rojo ))
    (importe-base)
)

(defrule importeBase "calcular importe base"
    ?i <- (importe-base)
    ;(declare (salience -1) )
    ?e <- (billete (origen ?origen)(destino ?destino)(tipo-transporte ?tipo)(preferente? ?preferente)(dia? ?dia) )
    (trayecto (origen ?origen) (destino ?destino) (tipo-transporte ?tipo)(importe ?importe))
    (suplementos (preferente ?preferenteImporte)(dia-rojo ?dia-rojo) (dia-azul ?dia-azul))
   
=>
    
    (bind ?importeTotal (* ?importe (+ 1 ?preferenteImporte)))
   
    ;(if (eq ?dia dia-azul) then (modify ?e (importe (* ?importe (+ 1 ?dia-azul)))))
    ;(if (eq ?dia dia-rojo) then (modify ?e (importe (* ?importe (+ 1 ?dia-rojo)))))
    (if (eq ?dia dia-azul) then (bind ?importeTotal (* ?importeTotal (+ 1 ?dia-azul))))
    (if (eq ?dia dia-rojo) then (bind ?importeTotal (* ?importeTotal (+ 1 ?dia-rojo))))

     (modify ?e (importe ?importeTotal))
   ; (modify ?e (importe (* ?importe (+ 1 ?dia))))
    (printout t "El precio del billete bruto" ?origen" - "?destino " es: " ?importe crlf)
    
    (printout t "preferente"?preferenteImporte crlf)
    (retract ?i)
    (assert(imprimir))
    
)

(defrule imprimir
    ?i <- (imprimir)
    ?e <- (billete (origen ?origen)(destino ?destino)(importe ?importe) )
    =>
    (printout t "El precio del billete" ?origen" - "?destino " es: " ?importe crlf)
    (retract ?i)
)
