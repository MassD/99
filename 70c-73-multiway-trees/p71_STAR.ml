(*

Determine the internal path length of a tree. (easy)

We define the internal path length of a multiway tree as the total sum of the path lengths from the root to all nodes of the tree. By this definition, the tree t in the figure of the previous problem has an internal path length of 9. Write a function ipl tree that returns the internal path length of tree.

*)

type 'a mult_tree = T of 'a * 'a mult_tree list

let ipl mt =
  let rec ipl_aux p (T(_,mtl)) =
    List.fold_left (fun acc mt -> acc+(ipl_aux (p+1) mt)) p mtl
  in 
  ipl_aux 0 mt

let mt = T('a', [T('f',[T('g',[])]); T('c',[]);T('b',[T('d',[]); T('e',[])])]);;
let mt1 = T(1,[T(2,[]);T(3,[]);T(4,[])])
