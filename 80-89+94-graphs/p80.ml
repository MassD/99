(*

Conversions. (easy)

Write functions to convert between the different graph representations. With these functions, all representations are equivalent; i.e. for the following problems you can always pick freely the most convenient form. This problem is not particularly difficult, but it's a lot of work to deal with all the special cases.

*)

type 'a edge_clause = ('a * 'a) list

type 'a graph_term = { nodes : 'a list;  edges : ('a * 'a) list }

module CharMap = Map.Make(Char)
type edge = char*char
type adjacency_list = edge list CharMap.t

type human_friendly = string


