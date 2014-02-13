(*

Find the last element of a list.

(Note that the Lisp transcription of this problem is incorrect.)

Example in Haskell:

Prelude> myLast [1,2,3,4]
4
Prelude> myLast ['x','y','z']
'z'

*)


let rec last = function
  | [] -> None
  | hd::[] -> Some hd
  | hd::tl -> last tl

let l1 = []
let l2 = [1;2;3;4]
let l3 = ['x';'y']


