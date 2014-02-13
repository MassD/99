(*

Flatten a nested list structure. (medium)

# (* There is no nested list type in OCaml, so we need to define one
     first. A node of a nested list is either an element, or a list of
     nodes. *)
  type 'a node =
    | One of 'a 
    | Many of 'a node list;;
type 'a node = One of 'a | Many of 'a node list

*)

type 'a node = One of 'a | Many of 'a node list
    
let flatten nl =
  let rec flat acc = function
    | [] -> List.rev acc
    | One x::tl -> flat (x::acc) tl
    | Many nl'::tl -> flat (List.rev_append (flat [] nl') acc) tl
  in 
  flat [] nl

let l1 = [One 1]
let l2 = []
let l3 = [One 1; Many [One 2;One 3;Many [One 4]]]
let l4 = [ One "a" ; Many [ One "b" ; Many [ One "c" ; One "d" ] ; One "e" ] ]
