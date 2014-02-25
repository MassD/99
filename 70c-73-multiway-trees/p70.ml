(*

Tree construction from a node string. (medium)

![Multiway Tree](http://ocaml.org/img/multiway-tree.gif)

We suppose that the nodes of a multiway tree contain single characters. In the depth-first order sequence of its nodes, a special character ^ has been inserted whenever, during the tree traversal, the move is a backtrack to the previous level.

By this rule, the tree in the figure opposite is represented as: afg^^c^bd^e^^^.

Write functions `string_of_tree : char mult_tree -> string` to construct the string representing the tree and `tree_of_string : string -> char mult_tree` to construct the tree when the string is given.

*)

type 'a mult_tree = T of 'a * 'a mult_tree list

let rec string_of_tree (T (k, mtl)) =
  (Char.escaped k) ^ (str_of_mtl mtl)
and str_of_mtl = function
    | [] -> ""
    | hd::tl -> string_of_tree hd ^ "^" ^ (str_of_mtl tl)

let tree_of_string s =
  let len = String.length s in
  if len = 0 then failwith "parse error"
  else 
    let rec tree_of_str s i =
      if i >= len || s.[i] = '^' then failwith "parse error"
      else T (s[i], mtl_of_str s (i+1))
    and mtl_of_str s j =
      if s[j] = '^' || j >= len then []
      else [tree_of_str s j]
    in 
    tree_of_str s 0




let mt = T ('a', [T('f',[T('g',[])]); T('c',[]);T('b',[T('d',[]); T('e',[])])])
