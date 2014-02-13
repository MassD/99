(*

Lotto: Draw N different random numbers from the set 1..M. (easy)

The selected numbers shall be returned in a list.

*)

let lotto_select n m =
  let rec select i acc =
    if i = n then acc
    else 
      let r = Random.int (m-1) + 1 in
      if List.mem r acc then select i acc
      else select (i+1) (r::acc)
  in 
  select 0 []

let n,m = 6,49
