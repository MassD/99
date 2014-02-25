(*

Preorder and inorder sequences of binary trees. (medium)

We consider binary trees with nodes that are identified by single lower-case letters, as in the example of the previous problem.

Write functions preorder and inorder that construct the preorder and inorder sequence of a given binary tree, respectively. The results should be atoms, e.g. 'abdecfg' for the preorder sequence of the example in the previous problem.

Can you use preorder from problem part 1 in the reverse direction; i.e. given a preorder sequence, construct a corresponding tree? If not, make the necessary arrangements.

If both the preorder sequence and the inorder sequence of the nodes of a binary tree are given, then the tree is determined unambiguously. Write a function pre_in_tree that does the job.

Solve problems 1 to 3 using difference lists. Cool! Use the function timeit (defined in problem “Compare the two methods of calculating Euler's totient function.”) to compare the solutions.

What happens if the same character appears in more than one node. Try for instance pre_in_tree "aba" "baa".

*)

type 'a btree = Empty | Node of 'a * 'a btree * 'a btree

let preorder' bt = 
  let rec traversal acc = function
    | Empty -> acc
    | Node (k,l,r) -> traversal (traversal (k::acc) l) r
  in 
  traversal [] bt |> List.rev

let inorder' bt = 
  let rec traversal acc = function
    | Empty -> acc
    | Node (k,l,r) -> traversal (k::(traversal acc l)) r
  in 
  traversal [] bt |> List.rev

let rec preorder = function
  | Empty -> []
  | Node (k,l,r) -> k::(preorder l)@(preorder r)

let rec inorder = function
  | Empty -> []
  | Node (k,l,r) -> inorder l @ k::inorder r

let split_at x l = 
  let rec split a i = function
    | [] -> List.rev a, i, []
    | hd::tl -> if hd = x then List.rev a, i, tl else split (hd::a) (i+1) tl
  in 
  split [] 0 l

let split_at_len n l =
  let rec split a i = function
    | [] -> List.rev a, []
    | hd::tl when i < n -> split (hd::a) (i+1) tl
    | _ as l -> List.rev a, l
  in 
  split [] 0 l

let rec pre_in_tree pl il =
  match pl with
    | [] -> Empty
    | hd::tl -> 
      let a,i,b = split_at hd il in
      let pre_a, pre_b = split_at_len i tl in
      Node (hd, pre_in_tree pre_a a, pre_in_tree pre_b b) 

let bt = Node (1, 
	       Node (2, 
		      Node (3, Empty, Empty), 
		      Node (4, Empty, Empty)), 
		Node (5, 
		       Empty, 
		       Node (6, 
			     Node (7, Empty, Empty), 
			     Empty)
		)
)
