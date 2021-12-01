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
   ; root
   (printout t "mean concave points? ") (assert (field-value (field "mean concave points") (value (read))))
   ; lvl-1
   (printout t "worst radius? ") (assert (field-value (field "worst radius") (value (read))))
   (printout t "worst perimeter? ") (assert (field-value (field "worst perimeter") (value (read))))
   ; lvl-2
   (printout t "radius error? ") (assert (field-value (field "radius error") (value (read))))
   (printout t "mean texture? ") (assert (field-value (field "mean texture") (value (read)))) ; duplicate
   (printout t "worst texture? ") (assert (field-value (field "worst texture") (value (read)))) ; duplicate
   ; lvl-3
   (printout t "mean smoothness? ") (assert (field-value (field "mean smoothness") (value (read))))
   (printout t "concave points error? ") (assert (field-value (field "concave points error") (value (read))))
   (printout t "worst concave points? ") (assert (field-value (field "worst concave points") (value (read))))
   (printout t "perimeter error? ") (assert (field-value (field "perimeter error") (value (read))))
   ; lvl-4
   (printout t "worst area? ") (assert (field-value (field "worst area") (value (read))))
   (printout t "mean radius? ") (assert (field-value (field "mean radius") (value (read)))) ; duplicate
)

; root
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

; cabang kiri
(defrule split-1
   ?id <- (id 1)
   (field-value (field "worst radius") (value ?v))
=>
   (retract ?id)
   (if (> ?v 16.83)
      then (assert (id 8))
      else (assert (id 2))
   )
)

(defrule split-2
   ?id <- (id 2)
   (field-value (field "radius error") (value ?v))
=>
   (retract ?id)
   (if (> ?v 0.63)
      then (assert (id 7))
      else (assert (id 3))
   )
)

(defrule split-3
   ?id <- (id 3)
   (field-value (field "worst texture") (value ?v))
=>
   (retract ?id)
   (if (> ?v 30.15)
      then (assert (id 4))
      else (printout t "Hasil Prediksi = Terprediksi kanker payudara" crlf)
   )
)

(defrule split-4
   ?id <- (id 4)
   (field-value (field "worst area") (value ?v))
=>
   (retract ?id)
   (if (> ?v 641.60)
      then (assert (id 5))
      else (printout t "Hasil Prediksi = Terprediksi kanker payudara" crlf)
   )
)

(defrule split-5
   ?id <- (id 5)
   (field-value (field "mean radius") (value ?v))
=>
   (retract ?id)
   (if (> ?v 13.45)
      then (printout t "Hasil Prediksi = Terprediksi kanker payudara" crlf)
      else (assert (id 6))
   )
)

(defrule split-6
   ?id <- (id 6)
   (field-value (field "mean texture") (value ?v))
=>
   (retract ?id)
   (if (> ?v 28.79)
      then (printout t "Hasil Prediksi = Terprediksi kanker payudara" crlf)
      else (printout t "Hasil Prediksi = Terprediksi tidak kanker payudara" crlf)
   )
)

(defrule split-7
   ?id <- (id 7)
   (field-value (field "mean smoothness") (value ?v))
=>
   (retract ?id)
   (if (> ?v 0.09)
      then (printout t "Hasil Prediksi = Terprediksi tidak kanker payudara" crlf)
      else (printout t "Hasil Prediksi = Terprediksi kanker payudara" crlf)
   )
)

(defrule split-8
   ?id <- (id 8)
   (field-value (field "mean texture") (value ?v))
=>
   (retract ?id)
   (if (> ?v 16.19)
      then (assert (id 9))
      else (printout t "Hasil Prediksi = Terprediksi kanker payudara" crlf)
   )
)

(defrule split-9
   ?id <- (id 9)
   (field-value (field "concave points error") (value ?v))
=>
   (retract ?id)
   (if (> ?v 0.01)
      then (printout t "Hasil Prediksi = Terprediksi kanker payudara" crlf)
      else (printout t "Hasil Prediksi = Terprediksi tidak kanker payudara" crlf)
   )
)

; cabang kanan
(defrule split-10
   ?id <- (id 10)
   (field-value (field "worst perimeter") (value ?v))
=>
   (retract ?id)
   (if (> ?v 114.45)
      then (printout t "Hasil Prediksi = Terprediksi tidak kanker payudara" crlf)
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
      then (printout t "Hasil Prediksi = Terprediksi tidak kanker payudara" crlf)
      else (printout t "Hasil Prediksi = Terprediksi kanker payudara" crlf)
   )
)

(defrule split-13
   ?id <- (id 13)
   (field-value (field "perimeter error") (value ?v))
=>
   (retract ?id)
   (if (> ?v 1.56)
      then (printout t "Hasil Prediksi = Terprediksi tidak kanker payudara" crlf)
      else (assert (id 14))
   )
)

(defrule split-14
   ?id <- (id 14)
   (field-value (field "mean radius") (value ?v))
=>
   (retract ?id)
   (if (> ?v 13.34)
      then (printout t "Hasil Prediksi = Terprediksi kanker payudara" crlf)
      else (printout t "Hasil Prediksi = Terprediksi tidak kanker payudara" crlf)
   )
)