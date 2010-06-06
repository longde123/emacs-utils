(require 'with-stack)
(require 'eperiodic)

(defun element-name (element)
  (||| 'name {element} 2>assoc 1>cdr))
(defun element-symbol (element)
  (||| 'symbol {element} 2>assoc 1>cdr))
(defun element-name (element) (||| 'name {element} 2>assoc 1>cdr))
(defun element-symbol (element) (||| 'symbol {element} 2>assoc 1>cdr))
(defun element-atomic-mass (element)
  (||| 'atomic-mass {element} 2>assoc 1>cdr))
(defun element-density (element) (||| 'density {element} 2>assoc 1>cdr))
(defun element-melting-point (element)
  (||| 'melting-point {element} 2>assoc 1>cdr))
(defun element-boiling-point (element)
  (||| 'boiling-point {element} 2>assoc 1>cdr))
(defun element-atomic-radius (element)
  (||| 'atomic-radius {element} 2>assoc 1>cdr))
(defun element-covalent-radius (element)
  (||| 'covalent-radius {element} 2>assoc 1>cdr))
(defun element-ionic-radius (element)
  (||| 'ionic-radius {element} 2>assoc 1>cdr))
(defun element-atomic-volume (element)
  (||| 'atomic-volume {element} 2>assoc 1>cdr))
(defun element-specific-heat (element)
  (||| 'specific-heat {element} 2>assoc 1>cdr))
(defun element-fusion-heat (element)
  (||| 'fusion-heat {element} 2>assoc 1>cdr))
(defun element-evaporation-heat (element)
  (||| 'evaporation-heat {element} 2>assoc 1>cdr))
(defun element-thermal-conductivity (element)
  (||| 'thermal-conductivity {element} 2>assoc 1>cdr))
(defun element-debye-temperature (element)
  (||| 'debye-temperature {element} 2>assoc 1>cdr))
(defun element-pauling-negativity-number (element)
  (||| 'pauling-negativity-number {element} 2>assoc 1>cdr))
(defun element-first-ionization-energy (element)
  (||| 'first-ionization-energy {element} 2>assoc 1>cdr))
(defun element-oxidation-states (element)
  (||| 'oxidation-states {element} 2>assoc 1>cdr))
(defun element-lattice-structure (element)
  (||| 'lattice-structure {element} 2>assoc 1>cdr))
(defun element-lattice-constant (element)
  (||| 'lattice-constant {element} 2>assoc 1>cdr))
(defun element-lattice-c/a-ratio (element)
  (||| 'lattice-c/a-ratio {element} 2>assoc 1>cdr))
(defun element-appearance (element)
  (||| 'appearance {element} 2>assoc 1>cdr))
(defun element-discovery-date (element)
  (||| 'discovery-date {element} 2>assoc 1>cdr))
(defun element-discovered-by (element)
  (||| 'discovered-by {element} 2>assoc 1>cdr))
(defun element-named-after (element)
  (||| 'named-after {element} 2>assoc 1>cdr))

(defn get-element-by-name
  ([name [element & rest :as elements]]
   (cond
	((or (string= (upcase name) (upcase (element-name element)))
		 (string= (upcase name) (upcase (element-symbol element))))
	 element)
	((not elements) nil)
	(t (recur name rest))))
  ([name]
   (get-element-by-name name eperiodic-element-properties)))

(get-element-by-name "Helium" eperiodic-element-properties)
(get-element-by-name "He")

(defun less-electronegative-than (a b)
  (let ((en1 (read (element-pauling-negativity-number a)))
		(en2 (read (element-pauling-negativity-number b))))
	(cond ((and (numberp en1)
				(numberp en2))
		   (< en1 en2))
		  ((and (symbolp en1)
				(numberp en2))
		   nil)
		  ((and (numberp en1)
				(symbolp en2))
		   t)
		  ((and (symbolp en1)
				(symbolp en2))
		   nil))))

(defun more-electronegative-than (a b)
  (let ((en1 (read (element-pauling-negativity-number a)))
		(en2 (read (element-pauling-negativity-number b))))
	(cond ((and (numberp en1)
				(numberp en2))
		   (> en1 en2))
		  ((and (symbolp en1)
				(numberp en2))
		   nil)
		  ((and (numberp en1)
				(symbolp en2))
		   t)
		  ((and (symbolp en1)
				(symbolp en2))
		   nil))))

(setf chemical-names (||| {eperiodic-element-properties} '(1>element-symbol) map))