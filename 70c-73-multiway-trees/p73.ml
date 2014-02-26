(*

 Lisp-like tree representation. (medium)

There is a particular notation for multiway trees in Lisp. The picture shows how multiway tree structures are represented in Lisp.

Note that in the "lispy" notation a node with successors (children) in the tree is always the first element in a list, followed by its children. The "lispy" representation of a multiway tree is a sequence of atoms and parentheses '(' and ')'. This is very close to the way trees are represented in OCaml, except that no constructor `T` is used. Write a function lispy :` char mult_tree -> string` that returns the lispy notation of the tree.

*)

type 'a mult_tree = T of 'a * 'a mult_tree list

let rec lispy (T(k,mtl)) =
  if mtl = [] then Char.escaped k
  else
    "(" ^ (Char.escaped k) ^ (List.fold_left (fun acc mt -> acc ^ " " ^ (lispy mt)) "" mtl) ^ ")"

let mt = T('a', [T('f',[T('g',[])]); T('c',[]);T('b',[T('d',[]); T('e',[])])]);;
let mt1 = T(1,[T(2,[]);T(3,[]);T(4,[])])
