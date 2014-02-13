## 99 problems in OCaml

The 99 problems are famous and have [Lisp version](http://www.ic.unicamp.br/~meidanis/courses/mc336/2006s2/funcional/L-99_Ninety-Nine_Lisp_Problems.html), [Prolog version](https://sites.google.com/site/prologsite/prolog-problems/), and [Haskell version](http://www.haskell.org/haskellwiki/99_questions), etc. 

This README is basically a restructured version of [ocaml.org-99problems](http://ocaml.org/learn/tutorials/99problems.html)

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

##### 3. Find the k'th element of a list. (easy)

	# at 3 [ "a" ; "b"; "c"; "d"; "e" ];;
	- : string option = Some "c"
    # at 3 [ "a" ];;
	- : string option = None
	
##### 4. Find the number of elements of a list. (easy)

OCaml standard library has List.length but we ask that you reimplement it. Bonus for a tail recursive solution.

    # length [ "a" ; "b" ; "c"];;
    - : int = 3
    # length [];;
    - : int = 0
	
##### 5. Reverse a list. (easy)

OCaml standard library has List.rev but we ask that you reimplement it.

    # rev ["a" ; "b" ; "c"];;
    - : string list = ["c"; "b"; "a"]
	
##### 6. Find out whether a list is a palindrome. (easy)

HINT: a palindrome is its own reverse.

     # is_palindrome [ "x" ; "a" ; "m" ; "a" ; "x" ];;
     - : bool = true
     # not (is_palindrome [ "a" ; "b" ]);;
     - : bool = true

##### 7. Flatten a nested list structure. (medium)

There is no nested list type in OCaml, so we need to define one first. A node of a nested list is either an element, or a list of nodes.
    
    type 'a node =
      | One of 'a 
      | Many of 'a node list


	# flatten [ One "a" ; Many [ One "b" ; Many [ One "c" ; One "d" ] ; One "e" ] ];;
	- : string list = ["a"; "b"; "c"; "d"; "e"]
	
##### 8. Eliminate consecutive duplicates of list elements. (medium)

    # compress ["a";"a";"a";"a";"b";"c";"c";"a";"a";"d";"e";"e";"e";"e"];;
    - : string list = ["a"; "b"; "c"; "a"; "d"; "e"]
	
##### 9. Pack consecutive duplicates of list elements into sublists. (medium)

    # pack ["a";"a";"a";"a";"b";"c";"c";"a";"a";"d";"d";"e";"e";"e";"e"];;
    - : string list list = [["a"; "a"; "a"; "a"]; ["b"]; ["c"; "c"]; ["a"; "a"]; ["d"; "d"];["e"; "e"; "e"; "e"]]
	
##### 10. Run-length encoding of a list. (easy)

If you need so, refresh your memory about [run-length encoding](http://en.wikipedia.org/wiki/Run-length_encoding)

    # encode ["a";"a";"a";"a";"b";"c";"c";"a";"a";"d";"e";"e";"e";"e"];;
    - : (int * string) list =
    [(4, "a"); (1, "b"); (2, "c"); (2, "a"); (1, "d"); (4, "e")]
	
##### 11. Modified run-length encoding. (easy)

Modify the result of the previous problem in such a way that if an element has no duplicates it is simply copied into the result list. Only elements with duplicates are transferred as (N E) lists.

Since OCaml lists are homogeneous, one needs to define a type to hold both single elements and sub-lists.

    type 'a rle =
      | One of 'a
      | Many of int * 'a

    # encode ["a";"a";"a";"a";"b";"c";"c";"a";"a";"d";"e";"e";"e";"e"];;
    - : string rle list = [Many (4, "a"); One "b"; Many (2, "c"); Many (2, "a"); One "d";Many (4, "e")]


