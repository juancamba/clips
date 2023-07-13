# clips examples
Esto pretende ser un repositorio de codigo de la asignatura **Ingeniería y Gestión del Conocimiento** del cuarto curso del grado de Ingeniería en tecnología de la información de la UNED

Tratamos de implementar los ejercicios que nos dió el equipo docente de la UNED, ya que la mayoria no funciona

We try to implement the exercises that the UNED teaching team gave us, since most of them do not work



Comands
```
(load "D:\\repo\\file.clp")
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