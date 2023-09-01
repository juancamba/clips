(deftemplate llamadaCliente
    (slot destino)
    (slot duracion)
    (slot dia)
    (slot hora)

)

(deftemplate tarifa
    (slot minimo(type FLOAT))
    (slot destino(type SYMBOL))
    (slot empresa)
    (slot franquicia(type INTEGER))
    (slot horaInicioDia (type INTEGER))
    (slot minutoDia (type FLOAT))
    (slot horaInicioNoche(type INTEGER))
    (slot minutoNoche(type FLOAT))
    (slot minutoFinde(type FLOAT))
)
(deffacts tarifas
    (tarifa (minimo 0.1)(destino L)(empresa ATT)(franquicia 2)(horaInicioDia 8)(minutoDia 0.02)
    (horaInicioNoche 18)(minutoNoche 0.01)(minutoFinde 0.01))
    (tarifa (minimo 0.25)(destino I)(empresa ATT)(franquicia 1)(horaInicioDia 8)(minutoDia 0.3)
    (horaInicioNoche 22)(minutoNoche 0.2)(minutoFinde 0.2))

    (tarifa (minimo 0.4)(destino L)(empresa BTT)(franquicia 0)(horaInicioDia 8)(minutoDia 0.03)
    (horaInicioNoche 20)(minutoNoche 0.01)(minutoFinde 0.01))
    (tarifa (minimo 0.1)(destino I)(empresa BTT)(franquicia 0)(horaInicioDia 8)(minutoDia 0.3)
    (horaInicioNoche 20)(minutoNoche 0.1)(minutoFinde 0.1))
)
(deffacts llamadas
    (llamadaCliente(destino L)(duracion 3)(dia 1)(hora 14))
)

(defrule calculoATT
    ?e<-(tarifa (minimo ?min)(destino ?destino)(empresa ?empresa)(franquicia ?franquicia)(horaInicioDia ?horaInicioDia)(minutoDia ?minutoDia)
    (horaInicioNoche ?horaInicioNoche)(minutoNoche ?minutoNoche)(minutoFinde ?minutoFinde ))
    (llamadaCliente(destino ?destino)(duracion ?duracion)(dia ?dia)(hora ?hora))
    =>


    (bind ?importe ?min)
    (if(> ?duracion ?franquicia) then
        ;duracion = duracion - franquicia
        (bind ?duracion (- ?duracion ?franquicia))
        (if (and(>= ?dia 1)(<= ?dia 5)(>= ?hora ?horaInicioDia)(<= ?hora ?horaInicioNoche)) then  
            (bind ?importe(+ ?importe (* ?duracion ?minutoDia))))
        (if (and(>= ?dia 1)(<= ?dia 5)(>= ?hora ?horaInicioNoche)(<= ?hora ?horaInicioDia)) then  
            (bind ?importe(+ ?importe (* ?duracion ?minutoDia))))    
        (if (and(>= ?dia 6)(<= ?dia 7)) then 
            (bind ?importe (* ?duracion ?minutoFinde)))   
    )
        (printout t "duracion: "?duracion ",destino: " ?destino ",empresa: "?empresa ",importe: "?importe crlf)


)