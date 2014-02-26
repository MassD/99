(*

Tree construction from a node string. (medium)

![Multiway Tree](http://ocaml.org/img/multiway-tree.gif)

We suppose that the nodes of a multiway tree contain single characters. In the depth-first order sequence of its nodes, a special character ^ has been inserted whenever, during the tree traversal, the move is a backtrack to the previous level.

By this rule, the tree in the figure opposite is represented as: afg^^c^bd^e^^^.

Write functions `string_of_tree : char mult_tree -> string` to construct the string representing the tree and `tree_of_string : string -> char mult_tree` to construct the tree when the string is given.

*)

type 'a mult_tree = T of 'a * 'a mult_tree list

let rec string_of_tree (T (k,mtl)) =
  (Char.escaped k) ^ (List.fold_left (fun acc mt -> acc ^ (string_of_tree mt)) "" mtl) ^ "^"

let rec scan_for_kids s acc c p q i =
  if i > q && c != 0 then failwith "parse error"
  else if i > q then List.rev acc
  else if s.[i] <> '^' then scan_for_kids s acc (c+1) p q (i+1)
  else if s.[i] = '^' && c = 1 then (print_endline (String.sub s p (i-p));scan_for_kids s ((p,i-1)::acc) 0 (i+1) q (i+1))
  else scan_for_kids s acc (c-1) p q (i+1)

let tree_of_string s = 
  let len = String.length s in
  let rec build s (p,q) = 
    if p >= len then failwith "parse error"
    else T (s.[p], scan_for_kids s [] 0 (p+1) q (p+1) |> List.map (build s))
  in 
  build s (0,len-2)




let mt = T ('a', [T('f',[T('g',[])]); T('c',[]);T('b',[T('d',[]); T('e',[])])])

let s = "afg^^c^bd^e^^^"


