; template con   nombre, tarjeta (visa oro| mastercard| visa) y saldo
; programa para determinar si es apto para un credito. Para ello debera tener un saldo > 100 o la visa oro
(deftemplate cliente
    (slot nombre (type STRING))
    (slot tarjeta (allowed-values visa visa_oro mastercard))
    (slot saldo (type NUMBER))
)
(deffacts clientes
    (cliente (nombre "juan camba")(tarjeta visa) (saldo 6000))
    (cliente (nombre "pepito")(tarjeta mastercard) (saldo 150))
    (cliente (nombre "pedro")(tarjeta visa) (saldo -1000))
    (cliente (nombre "mariano")(tarjeta mastercard) (saldo -80))
    (cliente (nombre "Pedro Sanchez")(tarjeta visa_oro) (saldo -1000))
)
(defrule apto-credito
    (cliente (nombre ?n)(tarjeta ?t)(saldo ?s))
    ;(or (> ?s 100) (?t visa_oro))
    (or (test (> ?s 100))
        (test (eq ?t visa_oro))
    =>
    (printout t "cliente apto para credito: "?n ?t ?s crlf)
)
