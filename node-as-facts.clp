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

; ====================================================
; DEFFACTS 
; ====================================================

(deffacts tree-leafs
   (leaf (id 0) (value "Terprediksi tidak kanker payudara"))
   (leaf (id 1) (value "Terprediksi kanker payudara"))
)

(deffacts tree-nodes ; Taroh node tree disini, atm gw buat cabang kiri dlu
   (node-numeric (id 2) (field "mean concave points") (treshold 0.05) (child0 3) (child1 1))
      (node-numeric (id 3) (field "worst radius") (treshold 16.83) (child0 4) (child1 10))
         (node-numeric (id 4) (field "radius error") (treshold 0.63) (child0 5) (child1 9))
            (node-numeric (id 5) (field "worst texture") (treshold 30.15) (child0 1) (child1 6))
               (node-numeric (id 6) (field "worst area") (treshold 641.60) (child0 1) (child1 7))
                  (node-numeric (id 7) (field "mean radius") (treshold 13.45) (child0 8) (child1 1))
                     (node-numeric (id 8) (field "mean texture") (treshold 28.79) (child0 0) (child1 1))
            (node-numeric (id 9) (field "mean smoothness") (treshold 0.09) (child0 1) (child1 0))
         (node-numeric (id 10) (field "mean texture") (treshold 16.19) (child0 1) (child1 11))
            (node-numeric (id 11) (field "concave points error") (treshold 0.01) (child0 0) (child1 1))
      ; Sok kalo mau lanjutin cabang kanan
)

(deffacts initial-fact
   (is-read)
   (id 2)
)

; *****
; RULES 
; *****

(defrule read
   ?r <- (is-read)
	(id ?id)
   (node-numeric (id ?id) (field ?field) (treshold ?th) (child0 ?c0) (child1 ?c1))
=>
   (printout t ?field)
   (printout t "? ")
   (assert (input (read)))
   (retract ?r)
)

(defrule traverse-left
   ?node <- (id ?id)
   (node-numeric (id ?id) (field ?field) (treshold ?th) (child0 ?c0) (child1 ?c1))
   ?i <- (input ?in)
   (test (<= ?in ?th))
=>
   (retract ?node ?i)
   (assert (id ?c0))
   (assert (is-read))
)

(defrule traverse-right
   ?node <- (id ?id)
   (node-numeric (id ?id) (field ?field) (treshold ?th) (child0 ?c0) (child1 ?c1))
   ?i <- (input ?in)
   (test (> ?in ?th))
=>
   (retract ?node ?i)
   (assert (id ?c1))
   (assert (is-read))
)

(defrule result
   (id ?id)
   (leaf (id ?id) (value ?val))
=>
   (printout t ?val crlf)
)


