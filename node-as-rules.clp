; =====================================================
; FACT TEMPLATES
; =====================================================

; The phase fact indicates the current action to be
; undertaken before the game can begin

; (phase 
;    <action>)      ; Either choose-player or 
                    ; select-pile-size

(deftemplate field-value
   (slot field)
   (slot value)
)

; ====================================================
; DEFFACTS 
; ====================================================

(deffacts initial-fact
   (initial-fact)
   (id 0)
)

; *****
; RULES 
; *****

(defrule input-fields
   (initial-fact)
=>
   (printout t "mean concave points? ") (assert (field-value (field "mean concave points") (value (read))))
   ; Mungkin bisa ditambahin cabang kiri
   (printout t "worst perimeter? ") (assert (field-value (field "worst perimeter") (value (read))))
   (printout t "worst texture? ") (assert (field-value (field "worst texture") (value (read))))
   (printout t "worst concave points? ") (assert (field-value (field "worst concave points") (value (read))))
   (printout t "perimeter error? ") (assert (field-value (field "perimeter error") (value (read))))
   (printout t "mean radius? ") (assert (field-value (field "mean radius") (value (read))))
)

(defrule split-0
   ?id <- (id 0)
   (field-value (field "mean concave points") (value ?v))
=>
   (retract ?id)
   (if (> ?v 0.05)
      then (assert (id 10))
      else (assert (id 1))
   )
)

; Buat split-1 sampai split-9

(defrule split-10
   ?id <- (id 10)
   (field-value (field "worst perimeter") (value ?v))
=>
   (retract ?id)
   (if (> ?v 114.45)
      then (printout t "Terprediksi tidak kanker payudara" crlf)
      else (assert (id 11))
   )
)

(defrule split-11
   ?id <- (id 11)
   (field-value (field "worst texture") (value ?v))
=>
   (retract ?id)
   (if (> ?v 25.65)
      then (assert (id 13))
      else (assert (id 12))
   )
)

(defrule split-12
   ?id <- (id 12)
   (field-value (field "worst concave points") (value ?v))
=>
   (retract ?id)
   (if (> ?v 0.17)
      then (printout t "Terprediksi tidak kanker payudara" crlf)
      else (printout t "Terprediksi kanker payudara" crlf)
   )
)

(defrule split-13
   ?id <- (id 13)
   (field-value (field "perimeter error") (value ?v))
=>
   (retract ?id)
   (if (> ?v 1.56)
      then (printout t "Terprediksi tidak kanker payudara" crlf)
      else (assert (id 14))
   )
)

(defrule split-14
   ?id <- (id 14)
   (field-value (field "mean radius") (value ?v))
=>
   (retract ?id)
   (if (> ?v 13.34)
      then (printout t "Terprediksi kanker payudara" crlf)
      else (printout t "Terprediksi tidak kanker payudara" crlf)
   )
)