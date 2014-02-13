(*

Find out whether a list is a palindrome. (easy)

HINT: a palindrome is its own reverse.

*)

let is_palindrome l = l <> [] && l = List.rev l

let l1 = [1;2;3]
let l2 = [1;2;3;2;1]
let l3 = []
