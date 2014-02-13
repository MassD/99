(*

Create a list containing all integers within a given range. (easy)

If first argument is smaller than second, produce a list in decreasing order.

*)

let range i j =
  let rec gen x y acc =
    if x = y then x::acc
    else if x < y then gen x (y-1) (y::acc)
    else gen x (y+1) (y::acc)
  in 
  gen i j []

let i,j = 4,9
let i1,j1 = 9,4

