(*

Construct the bottom-up order sequence of the tree nodes. (easy)

Write a function bottom_up t which constructs the bottom-up sequence of the nodes of the multiway tree t

*)

type 'a mult_tree = T of 'a * 'a mult_tree list

let rec bottom_up (T(k,mtl)) =
  List.fold_left (fun acc mt -> acc @ bottom_up mt) [] mtl @ [k]

let mt = T('a', [T('f',[T('g',[])]); T('c',[]);T('b',[T('d',[]); T('e',[])])]);;
let mt1 = T(1,[T(2,[]);T(3,[]);T(4,[])])
