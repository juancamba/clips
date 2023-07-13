(deftemplate Venta
   (slot CodigoVendedor (type SYMBOL))
(slot CodigoProducto (type SYMBOL))
(slot PVPProducto (type INTEGER))
)
(deffacts Ventas
    (Venta (CodigoVendedor A1) (CodigoProducto ASUS-3) (PVPProducto 35))
    (Venta (CodigoVendedor A2) (CodigoProducto MIC-2) (PVPProducto 5))
    (Venta (CodigoVendedor A3) (CodigoProducto ASUS-3) (PVPProducto 25))
)
(defrule comprueba-consistencia
    (Venta (CodigoVendedor ?codiV-1) (CodigoProducto ?codiP) (PVPProducto ?pvp-1) )
    (Venta 
        (CodigoVendedor ?codiV-2&:(not (eq ?codiV-2 ?codiV-1))) 
       ; (CodigoProducto ?codiP) (PVPProducto?pvp-2&:(not (= ?pvp-2 ?pvp-1)))
    )
   
=>
   ;(printout t "El vendedor " ?codiV-1 " ha vendido el producto " ?codiP " por " ?pvp-1 " euros" crlf)
   (printout t "Inconsistencia de precios entre " ?codiV-1 "-" ?codiP " y " ?codiV-2 "-" ?codiP crlf)
    (halt)
)