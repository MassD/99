type 'a edge_clause = ('a * 'a) list
type 'a graph_term = {nodes: 'a list; edges : ('a *'a) list}
type 'a human_friendly = string

let edge_clause_to_graph_term l = 
  let rec rm_dup acc = function
    | [] -> acc
    | (x,y)::tl -> 
      if List.mem x acc && List.mem y acc then rm_dup (acc) tl
      else if List.mem y acc then rm_dup (x::acc) tl
      else if List.mem x acc then rm_dup (y::acc) tl
      else rm_dup (x::y::acc) tl
  in 
  {nodes = rm_dup [] l |> List.sort compare; edges = l}

let ec = ['h', 'g';  'k', 'f';  'f', 'b';  'f', 'c';  'c', 'b']

module type NodeEdgeType =
sig
  type t
  type et
  val compare: t -> t -> int
end

(*module type Adj_graph_type = sig
  
  type nt
  type t
  
  val create_adjacency : (nt * nt list) list -> t

end*)

module Make_adj (Ne:NodeEdgeType) = struct 
    
  include Map.Make(Ne)
  
  type nt = Ne.t
  type gt = Ne.et t
  
  let create_adjacency l = List.fold_left (fun g (x,xl) -> add x xl g) (empty) l
end 


