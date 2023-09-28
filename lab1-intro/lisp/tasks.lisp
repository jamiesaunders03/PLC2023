;; code for Task 1.2(a):
(print (+ 1 2))

;; code for Task 1.2(b):
(format t "type something: ")
(setf input (read-line))
(if (string= "" input) (print "nothing typed") (format t "you typed: ~a" input))

;; code for Task 1.2(c):
(let ((prg '(+ 1 n))) (print prg)  (setf n 1) (print (eval prg))) ; define a very simple program
