(deftemplate persona "Tipo de entidad persona"
    (slot posicion (type INTEGER)); campo para la ordenación de los registros segun diferentes criterios
    (slot dni)
    (slot nombre)
    (multislot apellidos)
    (slot nacimiento (type INTEGER));Año nacimiento
    (slot profesion)
    (slot padre) ;Contendrá el DNI del padre
    (slot madre) ;Contendrá el DNI de la madre
    (slot conyuge); contendrá el DNI del conyuge
)

(deffacts personas
(persona (posicion 1) (dni 156688068A) (nombre Pedro) (apellidos "Ponce Sala") (nacimiento 1941) (profesion "cartero"))
(persona (posicion 2) (dni 080245678A) (nombre Francisco) (apellidos "Ponce Suarez") (nacimiento 1960) (profesion "Informatico")
(padre 156688068A) (madre 112244069A) (conyuge 663355046A))
(persona (posicion 3) (dni 856678098A) (nombre Zeus) (apellidos "Aonce Suarez") (nacimiento 1961) (profesion "Agricultor") (padre
156688068A)(madre 112244069A) (conyuge 333344059A))
(persona (posicion 4) (dni 356688068A) (nombre Pepe) (apellidos "Ponce Saez") (nacimiento 1980) (profesion "Lechero") (padre
080245678A) (madre 663355046A))
(persona (posicion 5) (dni 556688068A) (nombre Luis) (apellidos "Ponce Lopez") (nacimiento 1972) (profesion "cartero") (padre
856678098A) (madre 333344059A) (conyuge 552299078A))
(persona (posicion 6) (dni 456688068A) (nombre Juan) (apellidos "Ponce Lopez") (nacimiento 1981) (profesion "elect") (padre
856678098A) (madre 663355046A) )
(persona (posicion 7) (dni 552299078A) (nombre Carol) (apellidos "Ponce Saez") (nacimiento 1973) (profesion "azafata") (padre
080245678A) (madre 663355046A)(conyuge 556688068A))
(persona (posicion 8) (dni 663355046A) (nombre Petra) (apellidos "Saez Diaz") (nacimiento 1963) (profesion "ama casa") (conyuge
080245678A))
(persona (posicion 9) (dni 333344059A) (nombre Manuela) (apellidos "Lopez Perez") (nacimiento 1962) (profesion "cartero")
(conyuge 856678098A))
(persona (posicion 10) (dni 112244069A) (nombre Felisa) (apellidos "Suarez Garcia") (nacimiento 1948) (profesion "ama casa")
(conyuge 156688068A))

)

(defrule ordenar-por-apellidos "ordenar por apellidos"
    ?x1<-(persona(posicion ?i)(apellidos $?ap1))
    ?x2<-(persona(posicion ?j)(apellidos $?ap2))
    ;(test (= ?j (+ ?i 1)))
    ;Pasamos la variable multicampo a una cadena simple y se compara
    (test (> (str-compare (implode$ $?ap1) (implode$ $?ap2)) 0)) ;Ordenadas alfabeticamente
    =>
    (modify ?x1 (posicion ?j))
    (modify ?x2 (posicion ?i))
)

