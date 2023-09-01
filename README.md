# clips examples
Esto pretende ser un repositorio de codigo de la asignatura **Ingeniería y Gestión del Conocimiento** del cuarto curso del grado de Ingeniería en tecnología de la información de la UNED

Tratamos de implementar los ejercicios que nos dió el equipo docente de la UNED, ya que la mayoria no funciona

We try to implement the exercises that the UNED teaching team gave us, since most of them do not work



Comands
```
(load "D:\\Juan\\UNED\\2022 - 2023\\Ingenieria y gestion conocimiento\\clips_codigo\\clips\\ejercicio21.clp")
(load "D:\\Juan\\UNED\\2022 - 2023\\Ingenieria y gestion conocimiento\\clips_codigo\\clips\\examen22f1b.clp")

(reset) to initialize rules and facts
(clear) to reset system
(run) to run the fact in the agenda
```

## Ejercicio 3
Queremos un programa basado en reglas Clips (3 ptos) que pida al usuario introducir
uno o varios colores y el programa debe mostrar en pantalla el nombre de todos aquellos
países en cuya banderan aparezcan tales colores (supuestamente almacenados como hechos).
La bandera podría contener otros colores además de los pedidos


We want a program based on Clips (3 pts) rules that asks the user to enter
one or several colors and the program must display the name of all those colors on the screen.
countries on whose flag such colors appear (supposedly stored as facts).
The flag could contain other colors besides the orders

## Ejercicio 3.2
La instrucción "?f1<-(datos $?antes ?x ?y $?resto)" es un patrón en CLIPS que busca un hecho de tipo "datos" con el siguiente patrón de valores:

El patrón "?$antes" coincide con cero o más valores que se encuentran antes del valor asignado a la variable "?x" en el campo "datos".

La variable "?x" se asigna al primer valor después de los valores coincidentes con "?$antes".

La variable "?y" se asigna al siguiente valor después de "?x".

El patrón "?$resto" coincide con cero o más valores que siguen después de "?y" en el campo "datos".

## Ejercicio 6 

Define las plantillas necesarias para poder almacenar la información necesaria para el siguiente problema y escribe las reglas necesarias para su resolución: Supongamos que un profesor hace dos exámenes de prácticas a lo largo del curso, cuyas notas almacena con formato numérico, obteniendo la nota final de prácticas como la media de ambas notas. A esta nota final de prácticas se le restará una décima de punto por cada falta de asistencia. Obtener la nota final de prácticas con formato nominal según el iguiente criterio:

* [0, 5): Suspenso
* [5, 7): Aprobado
* [7, 9): Notable
* [9, 9.8): Sobresaliente
* [9.8, 10]: Matrícula de honor.

Construye una regla para cada tipo de nota, son todas iguales pero cambia la comparativa

```
(defrule nota_sobresaliente
    ?f1<-(nota (nombre ?nomb) (nota1 ?n1) (nota2 ?n2) (faltas ?falta) (nota-nominal nil))
    (test (>= (- (/ (+ ?n1 ?n2) 2) (* ?falta 0.1)) 9))
    (test (< (- (/ (+ ?n1 ?n2) 2) (* ?falta 0.1)) 9.8))
    =>
    (retract ?f1)
    (assert (nota (nombre ?nomb) (nota1 ?n1) (nota2 ?n2) (faltas ?falta) (nota-nominal Sobresaliente)))
)
```

## Ejercicio 8
Define una plantilla para almacenar fechas y escribe las regla que comprueben si la fecha no es válida. (Nota: un año es bisiesto si es múltiplo de 4 pero no de 100, salvo cuando sea múltiplo de 400, en cuyo caso sí que es bisiesto.)

Hace cuatro reglas para comprobar los meses con 28,29,30 y 31 dias. Además genera otra para la fecha invalida


## Ejercicio 16
Ej-16. Dado un mapa que representa la situación de distintas ciudades, se quiere construir un sistema en Clips que permita contestar preguntas sobre la posición relativa de dos ciudades, con las siguientes características:

a) Se introducirán exclusivamente hechos correspondientes a las relaciones “estar al norte de” y “estar al oeste de” y sólo
entre las ciudades más próximas entre sí. Por ejemplo, si suponemos 9 ciudades distribuidas en una cuadrícula:
```
A B C
D E F
G H I
```
sólo se establecerán como hechos: “A está al norte de D”, “A está al oeste de B”, etc.

b) El sistema de representación será capaz de inferir todas las relaciones inversas de las dadas directamente, es decir, lasrelaciones “estar al sur de” y “estar al este de”.

c) Se inferirán nuevas relaciones por transitividad. Por ejemplo, sabiendo que “A está al norte de D” y que “D está al norte de G” se inferirá que “A está al norte de G”.

d) Se inferirán las relaciones noroeste, noreste, suroeste y sureste a partir de los hechos iniciales. Por ejemplo, se podrá inferir que “C está al noreste de G”.

e) El hecho que se utilizará para consultar al sistema será ( situación <ciudad_1> <ciudad_2> ). Cuando este hecho se inserta en el sistema, el mismo debe responder mostrando por pantalla la  situación de la ciudad 1 con respecto a la ciudad 2.


## Ejercicio 21
Ej-21. Supóngase una agencia de viajes que ofrece viajes de trenes a sus clientes. Los viajes tienen unos atributos como son: el
lugar de origen y el lugar de destino y una tarifa inicial que se utilizará para calcular el precio final del viaje. 

Los viajes en tren se caracterizan por: 

	* el tipo de tren (AVE o TALGO)
	* por la clase (turista o preferente)
	* por el período de salida (blanco, rojo o azul) 
	* tipo de cliente (asiduo o esporádico).

Sin descuentos ni incrementos, los precios de un viaje en clase turista, entre dos ciudades, son los siguientes y dependen del tipo
de tren.

ORIGEN DESTINO AVE TALGO
* Madrid Córdoba 70 60
* Madrid Sevilla 80 70
* Barcelona Madrid --- 80

El precio sería el mismo para el viaje Barcelona-Madrid que para el viaje Madrid-Barcelona.
Se utilizan las siguientes reglas para calcular el precio final:
* Si el viaje es en clase preferente, los precios de la tabla se ven incrementados en un 30%
* Si la fecha de salida es azul, el precio del billete se reduce en un 10% y si es roja se incrementa en un 10%.
* Si el cliente es asiduo, el precio se reduce en un 10%
* Si el viajero es menor de 22 años (tarifa joven), se le aplica un 20% de reducción.
* Si el viajero es mayor de 65 años (tarifa dorada), se le aplica un 50% de reducción.
* Los descuentos y suplementos se aplican en el orden establecido en el enunciado.

## Ejercicio 21b
Es una versión simplificada del anterior

Creamos los hechos por los incrementos o decrementos son si viaja en preferente que le incrementa un 0.3