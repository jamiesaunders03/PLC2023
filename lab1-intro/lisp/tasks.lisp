;; code for Task 1.2(a):
(print (+ 1 2))

;; code for Task 1.2(b):
(format t "type something: ")
(setf input (read-line))
(if (string= "" input) (print "nothing typed") (format t "you typed: ~a" input))

;; code for Task 1.2(c):
(setf prg '(+ 1 n)) ; define a very simple program
(print prg) ; print the program
(setf n 1)
(print (eval prg))
; TODO: execute the program with n = 1 and print its result
