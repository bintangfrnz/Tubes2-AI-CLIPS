; =====================================================
; FACT TEMPLATES
; =====================================================

; The phase fact indicates the current action to be
; undertaken before the game can begin

; (phase 
;    <action>)      ; Either choose-player or 
                    ; select-pile-size

(deftemplate node-numeric
   (slot id)
   (slot field)
   (slot treshold)
   (slot child0)
   (slot child1)
)
(deftemplate leaf
   (slot id)
   (slot value)
)
(deftemplate print-id
   (slot id)
   (slot offset)
   (slot branch-side)
)

; ====================================================
; DEFFACTS 
; ====================================================

(deffacts tree-leafs
   (leaf (id 0) (value "Hasil Prediksi = Terprediksi tidak kanker payudara"))
   (leaf (id 1) (value "Hasil Prediksi = Terprediksi kanker payudara"))
)

(deffacts tree-nodes
   ; root
   (node-numeric (id 2) (field "mean concave points") (treshold 0.05) (child0 3) (child1 12))
      ; Cabang kiri
      (node-numeric (id 3) (field "worst radius") (treshold 16.83) (child0 4) (child1 10))
         (node-numeric (id 4) (field "radius error") (treshold 0.63) (child0 5) (child1 9))
            (node-numeric (id 5) (field "worst texture") (treshold 30.15) (child0 1) (child1 6))
               (node-numeric (id 6) (field "worst area") (treshold 641.60) (child0 1) (child1 7))
                  (node-numeric (id 7) (field "mean radius") (treshold 13.45) (child0 8) (child1 1))
                     (node-numeric (id 8) (field "mean texture") (treshold 28.79) (child0 0) (child1 1))
            (node-numeric (id 9) (field "mean smoothness") (treshold 0.09) (child0 1) (child1 0))
         (node-numeric (id 10) (field "mean texture") (treshold 16.19) (child0 1) (child1 11))
            (node-numeric (id 11) (field "concave points error") (treshold 0.01) (child0 0) (child1 1))
      ; Cabang kanan
      (node-numeric (id 12) (field "worst perimeter") (treshold 114.45) (child0 13) (child1 0))
         (node-numeric (id 13) (field "worst texture") (treshold 25.65) (child0 14) (child1 15))
            (node-numeric (id 14) (field "worst concave points") (treshold 0.17) (child0 1) (child1 0))
            (node-numeric (id 15) (field "perimeter error") (treshold 1.56) (child0 16) (child1 0))
               (node-numeric (id 16) (field "mean radius") (treshold 13.34) (child0 0) (child1 1))
)

(deffacts initial-fact
   (is-read)
   (id 2)
   (print-id (id 2) (offset -1) (branch-side 0))
)

; *****
; RULES 
; *****

(defrule input-field
   ?r <- (is-read)
	(id ?id)
   (node-numeric (id ?id) (field ?field) (treshold ?th) (child0 ?c0) (child1 ?c1))
=>
   (printout t ?field)
   (printout t "? ")
   (assert (input (read)))
   (retract ?r)
)

(defrule traverse
   ?node <- (id ?id)
   (node-numeric (id ?id) (field ?field) (treshold ?th) (child0 ?c0) (child1 ?c1))
   ?i <- (input ?in)
=>
   (retract ?node ?i)
   (if (> ?in ?th)
      then (assert (id ?c1))
      else (assert (id ?c0))
   )
   (assert (is-read))
)

(defrule result
   (id ?id)
   (leaf (id ?id) (value ?val))
=>
   (printout t ?val crlf crlf)
)

(defrule print-tree
   ?pi <- (print-id (id ?id) (offset ?off) (branch-side ?bs))
   (node-numeric (id ?id) (field ?field) (treshold ?th) (child0 ?c0) (child1 ?c1))
=>
   (retract ?pi)
   (loop-for-count ?off (printout t "|    "))
   (if (< ?bs 0)
      then (printout t "|no: "))
   (if (> ?bs 0)
      then (printout t "yes: "))
   (printout t ?field " > " ?th "?" crlf)
   (assert (print-id (id ?c1) (offset (+ ?off 1)) (branch-side 1)))
   (assert (print-id (id ?c0) (offset (+ ?off 1)) (branch-side -1)))
)

(defrule print-leaf
   ?pi <- (print-id (id ?id) (offset ?off) (branch-side ?bs))
=>
   (retract ?pi)
   (loop-for-count ?off (printout t "|    "))
   (if (< ?bs 0)
      then (printout t "|no: "))
   (if (> ?bs 0)
      then (printout t "yes: "))
   (printout t ?id ".0" crlf)
)

