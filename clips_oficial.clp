(defrule approved
(credit-score at-least 720)
(down-payment-percent at-least 0.20)
(monthly-debt-percent no-more-than 0.36)
=>
(assert (loan-approved)))


(assert (down-payment-percent at-least 0.20))
(assert (credit-score at-least 720))


; 
(defrule grocery-list-has-milk
(grocery-list $? milk $?)
=>)

(assert (grocery-list milk eggs cheese))

(assert (grocery-list bread onions tomatoes cheese))

(assert (grocery-list bread milk tomatoes cheese))


(defrule at-least-3-items
(grocery-list ? ? ? $?)
=>)

;
(deftemplate person
(multislot name))

(defrule may-be-related
    (person (name $?first1 ?last))
    (person (name $?first2&~$?first1 ?last))
    =>
    (println (implode$ ?first1) " " ?last " may be related to " (implode$ ?first2) " " ?last "."))

(defrule mostrar
    (person (name $?first1 ?last))
    =>
    (println (implode$ ?first1) " otro implode => "  ?last " .")

)

(assert (person (name Joe Bob Green)))
(assert (person (name Martin Brown)))
(assert (person (name Sue Ann Brown)))


(deftemplate person
  (multislot name))

(defrule concatenate-names
  (declare (salience 10))
  ?p <- (person (name $?names))
  =>
  (printout t "Nombres concatenados: " (implode$ ?names) crlf)
  (retract ?p)
)

(defrule concatenate-names
  (person (name $?names))
  =>
  (printout t "Nombres concatenados: " (implode$ ?names) crlf)
)
(defrule first-name
(person (name $?names))
=>
 (printout t "first-name: " (first$ ?names) crlf)
)
(assert (person (name Sue Ann Brown)))

; ejemplo con slot
(deftemplate person
  (slot name))

(defrule concatenate-names
  (person (name ?names))
  =>
  (printout t "Nombres concatenados: "  ?names crlf)
 
)






(defrule concatenate-elements
  (declare (salience 10))
  ?list <- (list $?elements)
  =>
  (printout t "Elementos concatenados: " (implode " " ?elements) crlf)
  (retract ?list)
)

(assert (list "elemento1" "elemento2" "elemento3"))
