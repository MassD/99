(*

An n-bit Gray code is a sequence of n-bit strings constructed according to certain rules. For example,

n = 1: C(1) = ['0','1'].
n = 2: C(2) = ['00','01','11','10'].
n = 3: C(3) = ['000','001','011','010',´110´,´111´,´101´,´100´].

Find out the construction rules and write a function with the following specification: gray n returns the n-bit Gray code.

*)

let string_of_list l =
  let buf = Buffer.create 8 in
  let rec sol = function
    | [] -> Buffer.contents buf
    | hd::tl -> (Buffer.add_string buf (string_of_int hd);sol tl)
  in 
  sol l

let gray n =
  let rec gray' acc i =
    if i > n then acc
    else gray' ((List.map (fun x -> 0::x) acc) @ (List.rev_map (fun x -> 1::x) acc)) (i+1)
  in 
  gray' [[0];[1]] 2 |> List.map string_of_list
