(*

Find the last but one (last and penultimate) elements of a list. (easy)

# last_two [ "a" ; "b" ; "c" ; "d" ];;
- : (string * string) option = Some ("c", "d")
# last_two [ "a" ];;
- : (string * string) option = None

*)

let rec last_two = function
  | [] | _::[] -> None
  | hd1::hd2::[] -> Some (hd1, hd2)
  | hd::tl -> last_penultimate tl

let l1 = []
let l2 = [1]
let l3 = [1;2]
let l4 = [1;2;3;4]
