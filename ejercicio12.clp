(deftemplate pez
    (slot boca (type STRING))
    (slot vive (type STRING))
    (slot dientes (type STRING))
    (slot color (type STRING))
    (slot tamano (type STRING))
    (slot rayasColor (type STRING))
    (slot color (type STRING))
    (slot manchas (type STRING)(allowed-values si no))
    (slot longitud (type INTEGER))


)

(defrule ciprinodontiformes
    ?f1 <-(pez (boca "pequeña")(vive "muchas partes del mundo"))
    =>
    (assert (?f1 Gonopodio))
)


(deffacts peces
    (pez (boca "pequeña")(vive "muchas partes del mundo"))
    (pez (boca grande)(vive "muchas partes del mundo"))
)