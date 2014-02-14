(*

##### 28. Sorting a list of lists according to length of sublists. (medium)

1. We suppose that a list contains elements that are lists themselves. The objective is to sort the elements of this list according to their length. E.g. short lists first, longer lists later, or vice versa.

2. Again, we suppose that a list contains elements that are lists themselves. But this time the objective is to sort the elements of this list according to their length frequency; i.e., in the default, where sorting is done ascendingly, lists with rare lengths are placed first, others with a more frequent length come later.

*)

let length_sort l =
  List.map (fun x -> (x,List.length x)) l |> List.sort (fun x y -> compare (snd x) (snd y)) |> List.map fst

let compare_snd x y = compare (snd x) (snd y)

let frequency_sort l =
  let sl = List.map (fun x -> (x,List.length x)) l |> List.sort compare_snd in
  let hd,hd_len = List.hd sl in
  let acc,sub,c,_ = List.fold_left (fun (acc,sub,c,len1) (x,len2) -> if len2 = len1 then acc,x::sub,c+1,len1 else (sub,c)::acc,[x],1,len2) ([],[hd],1,hd_len) (List.tl sl) in
  let l2 = (sub,c)::acc in
  List.sort compare_snd l2 |> List.map (fun (sub,_) -> sub) |> List.flatten

let l = [ ["a";"b";"c"]; ["d";"e"]; ["f";"g";"h"]; ["d";"e"];["i";"j";"k";"l"]; ["m";"n"]; ["o"] ]
  
