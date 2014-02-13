(*

Find the k'th element of a list. (easy)

# at 3 [ "a" ; "b"; "c"; "d"; "e" ];;
- : string option = Some "c"
# at 3 [ "a" ];;
- : string option = None

*)

let rec at k = function
  | [] -> None
  | hd::tl when k = 0 -> Some hd
  | hd::tl -> at (k-1) tl

let k1,l1 = 3,[1]
let k2,l2 = 3,[1;2;3;4]
