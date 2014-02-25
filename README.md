## 99 problems in OCaml

The 99 problems are famous and have [Lisp version](http://www.ic.unicamp.br/~meidanis/courses/mc336/2006s2/funcional/L-99_Ninety-Nine_Lisp_Problems.html), [Prolog version](https://sites.google.com/site/prologsite/prolog-problems/), and [Haskell version](http://www.haskell.org/haskellwiki/99_questions), etc. 

This README is basically a restructured version of [ocaml.org-99problems](http://ocaml.org/learn/tutorials/99problems.html)

Though the problems number from 1 to 99, there are some gaps and some additions marked with letters. There are actually only 88 problems.

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
    
	(* use this type in your code *)
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

    (* use this type in your code *)
    type 'a rle =
      | One of 'a
      | Many of int * 'a

    # encode ["a";"a";"a";"a";"b";"c";"c";"a";"a";"d";"e";"e";"e";"e"];;
    - : string rle list = [Many (4, "a"); One "b"; Many (2, "c"); Many (2, "a"); One "d";Many (4, "e")]

##### 12. Decode a run-length encoded list. (medium)

Given a run-length code list generated as specified in the previous problem, construct its uncompressed version.

    # decode [Many (4,"a"); One "b"; Many (2,"c"); Many (2,"a"); One "d"; Many (4,"e")];;
    - : string list = ["a"; "a"; "a"; "a"; "b"; "c"; "c"; "a"; "a"; "d"; "e"; "e"; "e"; "e"]
	
##### 13. Run-length encoding of a list (direct solution). (medium)

Implement the so-called run-length encoding data compression method directly. I.e. don't explicitly create the sublists containing the duplicates, as in problem "Pack consecutive duplicates of list elements into sublists", but only count them. As in problem "Modified run-length encoding", simplify the result list by replacing the singleton lists (1 X) by X.

    # encode ["a";"a";"a";"a";"b";"c";"c";"a";"a";"d";"e";"e";"e";"e"];;
    - : string rle list = [Many (4, "a"); One "b"; Many (2, "c"); Many (2, "a"); One "d"; Many (4, "e")]

##### 14. Duplicate the elements of a list. (easy)

    # duplicate ["a";"b";"c";"c";"d"];;
    - : string list = ["a"; "a"; "b"; "b"; "c"; "c"; "c"; "c"; "d"; "d"]

##### 15. Replicate the elements of a list a given number of times. (medium)

    # replicate ["a";"b";"c"] 3;;
    - : string list = ["a"; "a"; "a"; "b"; "b"; "b"; "c"; "c"; "c"]
	
##### 16. Drop every N'th element from a list. (medium)

    # drop ["a";"b";"c";"d";"e";"f";"g";"h";"i";"j"] 3;;
    - : string list = ["a"; "b"; "d"; "e"; "g"; "h"; "j"]
	
##### 17. Split a list into two parts; the length of the first part is given. (easy)

If the length of the first part is longer than the entire list, then the first part is the list and the second part is empty.

    # split ["a";"b";"c";"d";"e";"f";"g";"h";"i";"j"] 3;;
    - : string list * string list = (["a"; "b"; "c"], ["d"; "e"; "f"; "g"; "h"; "i"; "j"])
    # split ["a";"b";"c";"d"] 5;;
    - : string list * string list = (["a"; "b"; "c"; "d"], [])
	
##### 18. Extract a slice from a list. (medium)

Given two indices, i and k, the slice is the list containing the elements between the i'th and k'th element of the original list (both limits included). Start counting the elements with 0 (this is the way the List module numbers elements).

    # slice ["a";"b";"c";"d";"e";"f";"g";"h";"i";"j"] 2 6;;
    - : string list = ["c"; "d"; "e"; "f"; "g"]

##### 19. Rotate a list N places to the left. (medium)

    # rotate ["a"; "b"; "c"; "d"; "e"; "f"; "g"; "h"] 3;;
    - : string list = ["d"; "e"; "f"; "g"; "h"; "a"; "b"; "c"]
    # rotate ["a"; "b"; "c"; "d"; "e"; "f"; "g"; "h"] (-2);;
    - : string list = ["g"; "h"; "a"; "b"; "c"; "d"; "e"; "f"]


##### 20. Remove the K'th element from a list. (easy)

The first element of the list is numbered 0, the second 1,...

    # remove_at 1 ["a";"b";"c";"d"];;
    - : string list = ["a"; "c"; "d"]
	
##### 21. Insert an element at a given position into a list. (easy)

Start counting list elements with 0. If the position is larger or equal to the length of the list, insert the element at the end. (The behavior is unspecified if the position is negative.)

    # insert_at "alfa" 1 ["a";"b";"c";"d"];;
    - : string list = ["a"; "alfa"; "b"; "c"; "d"]
    # insert_at "alfa" 3 ["a";"b";"c";"d"];;
    - : string list = ["a"; "b"; "c"; "alfa"; "d"]
    # insert_at "alfa" 4 ["a";"b";"c";"d"];;
    - : string list = ["a"; "b"; "c"; "d"; "alfa"]

##### 22. Create a list containing all integers within a given range. (easy)

If first argument is smaller than second, produce a list in decreasing order.

    # range 4 9;;
    - : int list = [4; 5; 6; 7; 8; 9]
    # range 9 4;;
    - : int list = [9; 8; 7; 6; 5; 4]

##### 23. Extract a given number of randomly selected elements from a list. (medium)

The selected items shall be returned in a list. We use the Random module but do not initialize it with Random.self_init for reproducibility.

    # rand_select ["a";"b";"c";"d";"e";"f";"g";"h"] 3;;
    - : string list = ["g"; "d"; "a"]
	
##### 24. Lotto: Draw N different random numbers from the set 1..M. (easy)

The selected numbers shall be returned in a list.

    # lotto_select 6 49;;
    - : int list = [10; 20; 44; 22; 41; 2]
	
##### 25. Generate a random permutation of the elements of a list. (easy)

    # permutation ["a"; "b"; "c"; "d"; "e"; "f"];;
    - : string list = ["a"; "e"; "f"; "b"; "d"; "c"]

##### 26. Generate the combinations of K distinct objects chosen from the N elements of a list. (medium)

In how many ways can a committee of 3 be chosen from a group of 12 people? We all know that there are C(12,3) = 220 possibilities (C(N,K) denotes the well-known binomial coefficients). For pure mathematicians, this result may be great. But we want to really generate all the possibilities in a list.

    # extract 2 ["a";"b";"c";"d"];;
    - : string list list = [["c"; "d"]; ["b"; "d"]; ["b"; "c"]; ["a"; "d"]; ["a"; "c"]; ["a"; "b"]]
	
##### 27. Group the elements of a set into disjoint subsets. (medium)

A. In how many ways can a group of 9 people work in 3 disjoint subgroups of 2, 3 and 4 persons? Write a function that generates all the possibilities and returns them in a list.

B. Generalize the above function in a way that we can specify a list of group sizes and the function will return a list of groups.

    # group ["a";"b";"c";"d"]  [2;1];;
    - : string list list list =[[["a"; "b"]; ["c"]]; [["a"; "c"]; ["b"]]; [["b"; "c"]; ["a"]];[["a"; "b"]; ["d"]]; [["a"; "c"]; ["d"]]; [["b"; "c"]; ["d"]];[["a"; "d"]; ["b"]]; [["b"; "d"]; ["a"]]; [["a"; "d"]; ["c"]];[["b"; "d"]; ["c"]]; [["c"; "d"]; ["a"]]; [["c"; "d"]; ["b"]]]
	
##### 28. Sorting a list of lists according to length of sublists. (medium)

A. We suppose that a list contains elements that are lists themselves. The objective is to sort the elements of this list according to their length. E.g. short lists first, longer lists later, or vice versa.

B. Again, we suppose that a list contains elements that are lists themselves. But this time the objective is to sort the elements of this list according to their length frequency; i.e., in the default, where sorting is done ascendingly, lists with rare lengths are placed first, others with a more frequent length come later.


    # length_sort [ ["a";"b";"c"]; ["d";"e"]; ["f";"g";"h"]; ["d";"e"];["i";"j";"k";"l"]; ["m";"n"]; ["o"] ];;
    - : string list list = [["o"]; ["d"; "e"]; ["d"; "e"]; ["m"; "n"]; ["a"; "b"; "c"]; ["f"; "g"; "h"];["i"; "j"; "k"; "l"]]
    # frequency_sort [ ["a";"b";"c"]; ["d";"e"]; ["f";"g";"h"]; ["d";"e"];["i";"j";"k";"l"]; ["m";"n"]; ["o"] ];;
    - : string list list = [["i"; "j"; "k"; "l"]; ["o"]; ["a"; "b"; "c"]; ["f"; "g"; "h"]; ["d"; "e"];["d"; "e"]; ["m"; "n"]]

### Arithmetic

##### 31. Determine whether a given integer number is prime. (medium)

    # not(is_prime 1);;
    - : bool = true
    # is_prime 7;;
    - : bool = true
    # not (is_prime 12);;

##### 32. Determine the greatest common divisor of two positive integer numbers. (medium)

Use Euclid's algorithm.

    # gcd 13 27;;
    - : int = 1
    # gcd 20536 7826;;
    - : int = 2

##### 33. Determine whether two positive integer numbers are coprime. (easy)

Two numbers are coprime if their greatest common divisor equals 1.

    # coprime 13 27;;
    - : bool = true
    # not (coprime 20536 7826);;
    - : bool = true

##### 34. Calculate Euler's totient function φ(m). (medium)

Euler's so-called totient function φ(m) is defined as the number of positive integers r (1 ≤ r < m) that are coprime to m. We let φ(1) = 1.

Find out what the value of φ(m) is if m is a prime number. Euler's totient function plays an important role in one of the most widely used public key cryptography methods (RSA). In this exercise you should use the most primitive method to calculate this function (there are smarter ways that we shall discuss later).

    # phi 10;;
    - : int = 4
    # phi 13;;
    - : int = 12


##### 35. Determine the prime factors of a given positive integer. (medium)

Construct a flat list containing the prime factors in ascending order.

    # factors 315;;
    - : int list = [3; 3; 5; 7]
	
#### 36. Determine the prime factors of a given positive integer (2). (medium)

Construct a list containing the prime factors and their multiplicity. Hint: The problem is similar to problem Run-length encoding of a list (direct solution).

    # factors 315;;
    - : (int * int) list = [(3, 2); (5, 1); (7, 1)]

##### 37. Calculate Euler's totient function φ(m) (improved). (medium)

See problem "Calculate Euler's totient function φ(m)" for the definition of Euler's totient function. If the list of the prime factors of a number m is known in the form of the previous problem then the function phi(m) can be efficiently calculated as follows: Let [(p1, m1); (p2, m2); (p3, m3); ...] be the list of prime factors (and their multiplicities) of a given number m. Then φ(m) can be calculated with the following formula:

φ(m) = (p1 - 1) × p1m1 - 1 × (p2 - 1) × p2m2 - 1 × (p3 - 1) × p3m3 - 1 × ⋯

    # phi_improved 10;;
    - : int = 4
    # phi_improved 13;;
    - : int = 12
	
##### 38. Compare the two methods of calculating Euler's totient function. (easy)

Use the solutions of problems "Calculate Euler's totient function φ(m)" and "Calculate Euler's totient function φ(m) (improved)" to compare the algorithms. Take the number of logical inferences as a measure for efficiency. Try to calculate φ(10090) as an example.	

    # timeit phi 10090;;
    - : float = 0.00580191612243652344
    # timeit phi_improved 10090;;
    - : float = 7.08103179931640625e-05
	
##### 39. A list of prime numbers. (easy)

Given a range of integers by its lower and upper limit, construct a list of all prime numbers in that range.

    # List.length (all_primes 2 7920);;
    - : int = 1000

##### 40. Goldbach's conjecture. (medium)

Goldbach's conjecture says that every positive even number greater than 2 is the sum of two prime numbers. Example: 28 = 5 + 23. It is one of the most famous facts in number theory that has not been proved to be correct in the general case. It has been numerically confirmed up to very large numbers. Write a function to find the two prime numbers that sum up to a given even integer.

    # goldbach 28;;
    - : int * int = (5, 23)

##### 41. A list of Goldbach compositions. (medium)

Given a range of integers by its lower and upper limit, print a list of all even numbers and their Goldbach composition.

In most cases, if an even number is written as the sum of two prime numbers, one of them is very small. Very rarely, the primes are both bigger than say 50. Try to find out how many such cases there are in the range 2..3000.

    # goldbach_list 9 20;;
    - : (int * (int * int)) list = [(10, (3, 7)); (12, (5, 7)); (14, (3, 11)); (16, (3, 13)); (18, (5, 13)); (20, (3, 17))]
    # goldbach_limit 1 2000 50;;
    - : (int * (int * int)) list = [(992, (73, 919)); (1382, (61, 1321)); (1856, (67, 1789)); (1928, (61, 1867))]
	
### Logic and Codes

Let us define a small "language" for boolean expressions containing variables:

    type bool_expr =
      | Var of string
      | Not of bool_expr
      | And of bool_expr * bool_expr
      | Or of bool_expr * bool_expr

A logical expression in two variables can then be written in prefix notation. For example, (a ∨ b) ∧ (a ∧ b) is written:

    # And(Or(Var "a", Var "b"), And(Var "a", Var "b"));;
    - : bool_expr = And (Or (Var "a", Var "b"), And (Var "a", Var "b"))

##### 47. Truth tables for logical expressions (2 variables). (medium)

Define a function, table2 which returns the truth table of a given logical expression in two variables (specified as arguments). The return value must be a list of triples containing (value\_of\_a, value\_of\_b, value\_of\_expr).

    # table2 "a" "b" (And(Var "a", Or(Var "a", Var "b")));;
    - : (bool * bool * bool) list = [(true, true, true); (true, false, true); (false, true, false);(false, false, false)]
	
##### 48. Truth tables for logical expressions. (medium)

Generalize the previous problem in such a way that the logical expression may contain any number of logical variables. Define table in a way that table variables expr returns the truth table for the expression expr, which contains the logical variables enumerated in variables.

    # table ["a"; "b"] (And(Var "a", Or(Var "a", Var "b")));;
    - : ((string * bool) list * bool) list = 
		  [([("a", true); ("b", true)], true);
		   ([("a", true); ("b", false)], true);
		   ([("a", false); ("b", true)], false); 
		   ([("a", false); ("b", false)], false)]
    # let a = Var "a" and b = Var "b" and c = Var "c" in 
	  table ["a"; "b"; "c"] (Or(And(a, Or(b,c)), Or(And(a,b), And(a,c))));;
    - : ((string * bool) list * bool) list =
		[([("a", true); ("b", true); ("c", true)], true);
		 ([("a", true); ("b", true); ("c", false)], true);
		 ([("a", true); ("b", false); ("c", true)], true);
		 ([("a", true); ("b", false); ("c", false)], false);
		 ([("a", false); ("b", true); ("c", true)], false);
		 ([("a", false); ("b", true); ("c", false)], false);
		 ([("a", false); ("b", false); ("c", true)], false);
		 ([("a", false); ("b", false); ("c", false)], false)]

##### 49. Gray code. (medium)

An n-bit Gray code is a sequence of n-bit strings constructed according to certain rules. For example,

    n = 1: C(1) = ['0','1'].
    n = 2: C(2) = ['00','01','11','10'].
    n = 3: C(3) = ['000','001','011','010',´110´,´111´,´101´,´100´].

Find out the construction rules and write a function with the following specification: gray n returns the n-bit Gray code.

    # gray 1;;
    - : string list = ["0"; "1"]
    # gray 2;;
    - : string list = ["00"; "01"; "10"; "11"]
    # gray 3;;
    - : string list = ["000"; "001"; "010"; "011"; "100"; "101"; "110"; "111"]

##### 50. Huffman code. (hard)

First of all, consult a good book on discrete mathematics or algorithms for a detailed description of Huffman codes (you can start with the [Wikipedia page](http://en.wikipedia.org/wiki/Huffman_coding))!

We suppose a set of symbols with their frequencies, given as a list of `Fr(S,F)` terms, such as `fs = [Fr(a,45); Fr(b,13); Fr(c,12); Fr(d,16); Fr(e,9); Fr(f,5)]`. 

Our objective is to construct a list `Hc(S,C)` terms, where `C` is _the Huffman code word_ for the symbol `S`. 

In our example, the result could be `hs = [Hc(a,'0'); Hc(b,'101'); Hc(c,'100'); Hc(d,'111'); Hc(e,'1101'); hc(f,'1100')]` or `[hc(a,'01'),...etc.]`. 

The task shall be performed by the function huffman defined as follows: huffman(fs) returns the Huffman code table for the frequency table fs

    # huffman [('a',45);('b',13);('c',12);('d',16);('e',9);('f',5)]
    - char * string list = [('a',"0");('b',"101");('c',"100");('d',"111");('e',"1101");('f',"1100")]

### Binary Trees

A binary tree is either empty or it is composed of a root element and two successors, which are binary trees themselves.

In OCaml, one can define a new type `binary_tree` that carries an arbitrary value of type `'a` at each node.

    type 'a binary_tree =
      | Empty
      | Node of 'a * 'a binary_tree * 'a binary_tree
	  
An example of tree carrying char data is:

    # let example_tree = 
		Node('a', Node('b', Node('d', Empty, Empty), Node('e', Empty, Empty)),
         Node('c', Empty, Node('f', Node('g', Empty, Empty), Empty)));;
    - val example_tree : char binary_tree =
		Node ('a', Node ('b', Node ('d', Empty, Empty), Node ('e', Empty, Empty)),
		Node ('c', Empty, Node ('f', Node ('g', Empty, Empty), Empty)))
		
In OCaml, the strict type discipline guarantees that, if you get a value of type `binary_tree`, then it must have been created with the two constructors `Empty` and `Node`.

*Be careful* that in OCaml, the definition of Leaf is different from typical imperative programming like Java. `Empty` is like `Null` and definition of `Leaf` here is the `Node` whose both left and right children are `Empty`.*

   
##### 55.Construct completely balanced binary trees. (medium)

In a completely balanced binary tree, the following property holds for every node: The number of nodes in its left subtree and the number of nodes in its right subtree are almost equal, which means their difference is not greater than one.

Write a function cbal_tree to construct completely balanced binary trees for a given number of nodes. The function should generate all solutions via backtracking. Put the letter 'x' as information into all nodes of the tree.

    # cbal_tree 4;;
    - : char binary_tree list = [Node ('x', Node ('x', Empty, Empty), Node ('x', Node ('x', Empty, Empty), Empty)); Node ('x', Node ('x', Empty, Empty),Node ('x', Empty, Node ('x', Empty, Empty))); Node ('x', Node ('x', Node ('x', Empty, Empty), Empty),Node ('x', Empty, Empty)); Node ('x', Node ('x', Empty, Node ('x', Empty, Empty)),Node ('x', Empty, Empty))]
    # List.length(cbal_tree 40);;
    - : int = 524288

##### 56. Symmetric binary trees. (medium)

Let us call a binary tree symmetric if you can draw a vertical line through the root node and then the right subtree is the mirror image of the left subtree. Write a function `is_symmetric` to check whether a given binary tree is symmetric.

Hint: Write a function `is_mirror` first to check whether one tree is the mirror image of another. We are only interested in the structure, not in the contents of the nodes.

##### 57. Binary search trees (dictionaries). (medium)

A. Construct a binary search tree from a list of integer numbers.

    # construct [3;2;5;7;1];;
    - : int binary_tree = Node (3, Node (2, Node (1, Empty, Empty), Empty),Node (5, Empty, Node (7, Empty, Empty)))
 
B. Then use this function to test the solution of the previous problem.
 
    # is_symmetric(construct [5;3;18;1;4;12;21]);;
    - : bool = true
    # not(is_symmetric(construct [3;2;5;7;4]));;
    - : bool = true
	
##### 58. Generate-and-test paradigm. (medium)

Apply the generate-and-test paradigm to construct all symmetric, completely balanced binary trees with a given number of nodes.

    # sym_cbal_trees 5;;
    - : char binary_tree list = 
		[
			Node ('x', Node ('x', Node ('x', Empty, Empty), Empty),Node ('x', Empty, Node ('x', Empty, Empty)));
			Node ('x', Node ('x', Empty, Node ('x', Empty, Empty)),Node ('x', Node ('x', Empty, Empty), Empty))
		]

How many such trees are there with 57 nodes? Investigate about how many solutions there are for a given number of nodes? What if the number is even? Write an appropriate function.

    # List.length (sym_cbal_trees 57);;
    - : int = 256
    # List.map (fun n -> n, List.length(sym_cbal_trees n)) (range 10 20);;
    - : (int * int) list = [(10, 0); (11, 4); (12, 0); (13, 4); (14, 0); (15, 1); (16, 0); (17, 8);(18, 0); (19, 16); (20, 0)]

##### 59. Construct height-balanced binary trees. (medium)

In a height-balanced binary tree, the following property holds for every node: The height of its left subtree and the height of its right subtree are almost equal, which means their difference is not greater than one.

Write a function hbal_tree to construct height-balanced binary trees for a given height. The function should generate all solutions via backtracking. Put the letter 'x' as information into all nodes of the tree.

    # let t = hbal_tree 3;;
    val t : char binary_tree list =
      [Node ('x', Node ('x', Empty, Node ('x', Empty, Empty)),
        Node ('x', Empty, Node ('x', Empty, Empty)));
       Node ('x', Node ('x', Empty, Node ('x', Empty, Empty)),
        Node ('x', Node ('x', Empty, Empty), Empty));
       Node ('x', Node ('x', Empty, Node ('x', Empty, Empty)),
        Node ('x', Node ('x', Empty, Empty), Node ('x', Empty, Empty)));
       Node ('x', Node ('x', Node ('x', Empty, Empty), Empty),
        Node ('x', Empty, Node ('x', Empty, Empty)));
       Node ('x', Node ('x', Node ('x', Empty, Empty), Empty),
        Node ('x', Node ('x', Empty, Empty), Empty));
       Node ('x', Node ('x', Node ('x', Empty, Empty), Empty),
        Node ('x', Node ('x', Empty, Empty), Node ('x', Empty, Empty)));
       Node ('x', Node ('x', Node ('x', Empty, Empty), Node ('x', Empty, Empty)),
        Node ('x', Empty, Node ('x', Empty, Empty)));
       Node ('x', Node ('x', Node ('x', Empty, Empty), Node ('x', Empty, Empty)),
        Node ('x', Node ('x', Empty, Empty), Empty));
       Node ('x', Node ('x', Node ('x', Empty, Empty), Node ('x', Empty, Empty)),
        Node ('x', Node ('x', Empty, Empty), Node ('x', Empty, Empty)));
       Node ('x', Node ('x', Empty, Node ('x', Empty, Empty)),
        Node ('x', Empty, Empty));
       Node ('x', Node ('x', Node ('x', Empty, Empty), Empty),
        Node ('x', Empty, Empty));
       Node ('x', Node ('x', Node ('x', Empty, Empty), Node ('x', Empty, Empty)),
        Node ('x', Empty, Empty));
       Node ('x', Node ('x', Empty, Empty),
        Node ('x', Empty, Node ('x', Empty, Empty)));
       Node ('x', Node ('x', Empty, Empty),
        Node ('x', Node ('x', Empty, Empty), Empty));
       Node ('x', Node ('x', Empty, Empty),
        Node ('x', Node ('x', Empty, Empty), Node ('x', Empty, Empty)))]
    # let x = 'x';;
    val x : char = 'x'
    # List.mem (Node(x, Node(x, Node(x, Empty, Empty), Node(x, Empty, Empty)),
                 Node(x, Node(x, Empty, Empty), Node(x, Empty, Empty)))) t;;
    - : bool = true
    # List.mem (Node(x, Node(x, Node(x, Empty, Empty), Node(x, Empty, Empty)),
                 Node(x, Node(x, Empty, Empty), Empty))) t;;
    - : bool = true
    # List.length t;;
    - : int = 15
	
##### 60. Construct height-balanced binary trees with a given number of nodes. (medium)

Consider a height-balanced binary tree of height h. What is the maximum number of nodes it can contain? 

A. Clearly, maxN = 2h - 1. However, what is the minimum number minN? This question is more difficult. Try to find a recursive statement and turn it into a function `min_nodes` defined as follows: `min_nodes h` returns the minimum number of nodes in a height-balanced binary tree of height h.

B. On the other hand, we might ask: what is the maximum height H a height-balanced binary tree with N nodes can have? `max_height n` returns the maximum height of a height-balanced binary tree with n nodes.

C. Now, we can attack the main problem: construct all the height-balanced binary trees with a given nuber of nodes. `hbal_tree_nodes n` returns a list of all height-balanced binary tree with n nodes.

    # List.length(hbal_tree_nodes 15);;
    - : int = 1553

##### 61. Count the leaves of a binary tree. (easy)

A leaf is a node with no successors. Write a function count_leaves to count them.

     # count_leaves Empty;;
     - : int = 0
     # count_leaves example_tree;;
     - : int = 3
	 
##### 61A. Collect the leaves of a binary tree in a list. (easy)

A leaf is a node with no successors. Write a function leaves to collect them in a list.

    # leaves Empty;;
    - : 'a list = []
    # leaves example_tree;;
    - : char list = ['d'; 'e'; 'g']

##### 62. Collect the internal nodes of a binary tree in a list. (easy)

An internal node of a binary tree has either one or two non-empty successors. Write a function internals to collect them in a list.

    # internals (Node('a', Empty, Empty));;
    - : char list = []
    # internals example_tree;;
    - : char list = ['b'; 'a'; 'c'; 'f']
	
##### 62A. Collect the nodes at a given level in a list. (easy)

A node of a binary tree is at level N if the path from the root to the node has length N-1. The root node is at level 1. Write a function at_level t l to collect all nodes of the tree t at level l in a list.

    # at_level example_tree 2;;
    - : char list = ['b'; 'c']
    # at_level example_tree 5;;
    - : char list = []

##### 63. Construct a complete binary tree. (medium)

A complete binary tree with height H is defined as follows: The levels 1,2,3,...,H-1 contain the maximum number of nodes (i.e 2i-1 at the level i, note that we start counting the levels from 1 at the root). In level H, which may contain less than the maximum possible number of nodes, all the nodes are "left-adjusted". This means that in a levelorder tree traversal all internal nodes come first, the leaves come second, and empty successors (the nil's which are not really nodes!) come last.

Particularly, complete binary trees are used as data structures (or addressing schemes) for heaps.

We can assign an address number to each node in a complete binary tree by enumerating the nodes in levelorder, starting at the root with number 1. In doing so, we realize that for every node X with address A the following property holds: The address of X's left and right successors are `2*A` and `2*A+1`, respectively, supposed the successors do exist. This fact can be used to elegantly construct a complete binary tree structure. Write a function `is_complete_binary_tree` with the following specification: `is_complete_binary_tree n t` returns true iff t is a complete binary tree with n nodes.

##### 64. Layout a binary tree (1). (medium)

As a preparation for drawing the tree, a layout algorithm is required to determine the position of each node in a rectangular grid. Several layout methods are conceivable, one of them is shown in the illustration.

![Binary Tree Grid](http://ocaml.org/img/tree-layout1.gif)

In this layout strategy, the position of a node v is obtained by the following two rules:

- x(v) is equal to the position of the node v in the inorder sequence;
- y(v) is equal to the depth of the node v in the tree.

In order to store the position of the nodes, we redefine the OCaml type representing a node (and its successors) as follows:

    type 'a pos_binary_tree =
      | E (* represents the empty tree *)
      | N of 'a * int * int * 'a pos_binary_tree * 'a pos_binary_tree
	  
`N(w,x,y,l,r)` represents a (non-empty) binary tree with root `w` "positioned" at `(x,y)`, and subtrees `l` and `r`. 

Write a function `layout_binary_tree` with the following specification: `layout_binary_tree t` returns the "positioned" binary tree obtained from the binary tree `t`.

##### 65. Layout a binary tree (2). (medium)

![Binary Tree Grid](http://ocaml.org/img/tree-layout2.gif)

An alternative layout method is depicted in this illustration. Find out the rules and write the corresponding OCaml function.

Hint: On a given level, the horizontal distance between neighbouring nodes is constant.


##### 66. Layout a binary tree (3). (hard)

![Binary Tree Grid](http://ocaml.org/img/tree-layout3.gif)

Yet another layout strategy is shown in the above illustration. The method yields a very compact layout while maintaining a certain symmetry in every node. Find out the rules and write the corresponding predicate.

Hint: Consider the horizontal distance between a node and its successor nodes. How tight can you pack together two subtrees to construct the combined binary tree? This is a difficult problem. Don't give up too early!

##### 67. A string representation of binary trees. (medium)

![Binary Tree](http://ocaml.org/img/binary-tree.gif)

Somebody represents binary trees as strings of the following type (see example): `"a(b(d,e),c(,f(g,)))"`.

- Write an OCaml function which generates this string representation, if the tree is given as usual (as `Empty` or `Node(x,l,r)` term). 

- Then write a function which does this inverse; i.e. given the string representation, construct the tree in the usual form. 

- Finally, combine the two predicates in a single function `tree_string` which can be used in both directions.

- Write the same predicate `tree_string` using [difference lists](https://en.wikipedia.org/wiki/Difference_list) and a single predicate `tree_dlist` which does the conversion between a tree and a difference list in both directions.

For simplicity, suppose the information in the nodes is a single letter and there are no spaces in the string.

##### 68. Preorder and inorder sequences of binary trees. (medium)

We consider binary trees with nodes that are identified by single lower-case letters, as in the example of the previous problem.

1. Write functions `preorder` and `inorder` that construct the `preorder` and `inorder` sequence of a given binary tree, respectively. The results should be atoms, e.g. 'abdecfg' for the preorder sequence of the example in the previous problem.

2. Can you use preorder from problem part 1 in the reverse direction; i.e. given a preorder sequence, construct a corresponding tree? If not, make the necessary arrangements.

3. If both the preorder sequence and the inorder sequence of the nodes of a binary tree are given, then the tree is determined unambiguously. Write a function `pre_in_tree` that does the job.

4. Solve problems 1 to 3 using [difference lists](https://en.wikipedia.org/wiki/Difference_list). Cool! Use the function `timeit` (defined in problem “Compare the two methods of calculating Euler's totient function.”) to compare the solutions.

What happens if the same character appears in more than one node. Try for instance `pre_in_tree "aba" "baa"`.

##### 69. Dotstring representation of binary trees. (medium)

We consider again binary trees with nodes that are identified by single lower-case letters, as in the example of problem “A string representation of binary trees”. 

Such a tree can be represented by the preorder sequence of its nodes in which dots (.) are inserted where an empty subtree (nil) is encountered during the tree traversal. For example, the tree shown in problem “A string representation of binary trees” (`"a(b(d,e),c(,f(g,)))"`) is represented as `'abd..e..c.fg...'`. First, try to establish a syntax (`BNF` or `syntax diagrams`) and then write a function `tree_dotstring` which does the conversion in both directions. Use difference lists.

### Multiway Trees

A multiway tree is composed of a root element and a (possibly empty) set of successors which are multiway trees themselves. A multiway tree is never empty. The set of successor trees is sometimes called a forest.

![Multiway Trees](http://ocaml.org/img/multiway-tree.gif)

To represent multiway trees, we will use the following type which is a direct translation of the definition:

    type 'a mult_tree = T of 'a * 'a mult_tree list
	
The example tree depicted opposite is therefore represented by the following OCaml expression:

    T('a', [T('f',[T('g',[])]); T('c',[]); T('b',[T('d',[]); T('e',[])])])

##### 70B. Check whether a given term represents a multiway tree.

    # is_multiway_tree T('a', [T('f',[T('g',[])]); T('c',[]); T('b',[T('d',[]); T('e',[])])]);;
	- : true


##### 70C. Count the nodes of a multiway tree. (easy)

    # count_nodes (T('a', [T('f',[]) ]));;
    - : int = 2

##### 70. Tree construction from a node string. (medium)

![Multiway Tree](http://ocaml.org/img/multiway-tree.gif)

We suppose that the nodes of a multiway tree contain single characters. In the depth-first order sequence of its nodes, a special character ^ has been inserted whenever, during the tree traversal, the move is a backtrack to the previous level.

By this rule, the tree in the figure opposite is represented as: afg^^c^bd^e^^^.

Write functions `string_of_tree : char mult_tree -> string` to construct the string representing the tree and `tree_of_string : string -> char mult_tree` to construct the tree when the string is given.

    # let t = T('a', [T('f',[T('g',[])]); T('c',[]);T('b',[T('d',[]); T('e',[])])]);;
    val t : char mult_tree = T ('a',[T ('f', [T ('g', [])]); T ('c', []); T ('b', [T ('d', []); T ('e', [])])])
    # string_of_tree t;;
    - : string = "afg^^c^bd^e^^^"
    # tree_of_string "afg^^c^bd^e^^^";;
    - : char mult_tree = T ('a',[T ('f', [T ('g', [])]); T ('c', []); T ('b', [T ('d', []); T ('e', [])])])

##### 71. Determine the internal path length of a tree. (easy)

We define the internal path length of a multiway tree as the total sum of the path lengths from the root to all nodes of the tree. By this definition, the tree `t` in the figure of the previous problem has an internal path length of 9. Write a function `ipl tree` that returns the internal path length of `tree`.

    # ipl t;;
    - : int = 9
	
##### 72. Construct the bottom-up order sequence of the tree nodes. (easy)

Write a function `bottom_up t` which constructs the bottom-up sequence of the nodes of the multiway tree `t`.

    # bottom_up (T('a', [T('b', [])]));;
    - : char list = ['b'; 'a']
    # bottom_up t;;
    - : char list = ['g'; 'f'; 'c'; 'd'; 'e'; 'b'; 'a']


##### 73. Lisp-like tree representation. (medium)

There is a particular notation for multiway trees in Lisp. The picture shows how multiway tree structures are represented in Lisp.

![Lisp representation of multiway](http://ocaml.org/img/lisp-like-tree.png)

Note that in the "lispy" notation a node with successors (children) in the tree is always the first element in a list, followed by its children. The "lispy" representation of a multiway tree is a sequence of atoms and parentheses '(' and ')'. This is very close to the way trees are represented in OCaml, except that no constructor `T` is used. Write a function `lispy : char mult_tree -> string` that returns the lispy notation of the tree.

    # lispy (T('a', []));;
    - : string = "a"
    # lispy (T('a', [T('b', [])]));;
    - : string = "(a b)"
    # lispy t;;
    - : string = "(a (f g) c (b d e))"


***

## 99+ problems in OCaml

Here are the problems that I think median, harder or much harder than 99 problems in OCaml, but definitely worth thinking.

### List

### Max

### Binary Trees

##### Find distance between two given keys of a Binary Tree(medium)

Find the distance between two keys in a binary tree, no parent pointers are given. Distance between two nodes is the minimum number of edges to be traversed to reach one node from other.

ref: http://www.geeksforgeeks.org/find-distance-two-given-nodes/

##### Print all nodes that don’t have sibling (medium)

Given a Binary Tree, print all nodes that don’t have a sibling (a sibling is a node that has same parent. In a Binary Tree, there can be at most one sibling). Root should not be printed as root cannot have a sibling.

![No sibling](http://d2o58evtke57tz.cloudfront.net/wp-content/uploads/Binary-Tree.png)

ref: http://www.geeksforgeeks.org/print-nodes-dont-sibling-binary-tree/

##### Lowest Common Ancestor in a Binary Tree (medium)

Given a binary tree (not a binary search tree) and two values say n1 and n2, write a program to find the least common ancestor.

![LCA](http://d2o58evtke57tz.cloudfront.net/wp-content/uploads/lca.png)

ref: http://www.geeksforgeeks.org/lowest-common-ancestor-binary-tree-set-1/

##### Remove all nodes which don’t lie in any path with sum>= k (medium+)

Given a binary tree, a complete path is defined as a path from root to a leaf. The sum of all nodes on that path is defined as the sum of that path. Given a number K, you have to remove (prune the tree) all nodes which don’t lie in any path with sum>=k.

Note: A node can be part of multiple paths. So we have to delete it only in case when all paths from it have sum less than K.

Consider the following Binary Tree  
          1  
      /      \  
     2        3  
   /   \     /  \  
  4     5   6    7  
 / \    /       /  
8   9  12      10  
   / \           \  
  13  14         11  
      /   
     15   

For input k = 20, the tree should be changed to following
(Nodes with values 6 and 8 are deleted)  
          1   
      /      \  
     2        3  
   /   \        \  
  4     5        7  
   \    /       /  
    9  12      10  
   / \           \  
  13  14         11  
      /   
     15   

For input k = 45, the tree should be changed to following.  
      1   
    /   
   2     
  /   
 4    
  \    
   9     
    \   
     14  
     /
    15   
	
ref: http://www.geeksforgeeks.org/remove-all-nodes-which-lie-on-a-path-having-sum-less-than-k/
