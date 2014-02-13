## 99 problems in OCaml

The 99 problems are famous and have [Lisp version](http://www.ic.unicamp.br/~meidanis/courses/mc336/2006s2/funcional/L-99_Ninety-Nine_Lisp_Problems.html), [Prolog version](https://sites.google.com/site/prologsite/prolog-problems/), and [Haskell version](http://www.haskell.org/haskellwiki/99_questions), etc.

### Lists

##### 1. Write a function last : 'a list -> 'a option that returns the last element of a list. (easy)

    # last [ "a" ; "b" ; "c" ; "d" ];;
    - : string option = Some "d"
    # last [];;
    - : 'a option = None
	
##### 2. Find the last but one (last and penultimate) elements of a list. (easy)

    # last_two [ "a" ; "b" ; "c" ; "d" ];;
    - : (string * string) option = Some ("c", "d")
    # last_two [ "a" ];;
    - : (string * string) option = None
