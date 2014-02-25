(*

Count the nodes of a multiway tree. (easy)

*)

type 'a mult_tree = T of 'a * 'a mult_tree list

let rec count_nodes (T (k, mtl)) = 1 + List.fold_left (fun acc mt -> acc+count_nodes mt) 0 mtl

let mt = T('a', [T('f',[]) ])

let mt1 = T('a', [T('f',[T('g',[])]); T('c',[]); T('b',[T('d',[]); T('e',[])])])


