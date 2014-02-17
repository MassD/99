(*

A list of Goldbach compositions. (medium)

A. Given a range of integers by its lower and upper limit, print a list of all even numbers and their Goldbach composition.

B. In most cases, if an even number is written as the sum of two prime numbers, one of them is very small. Very rarely, the primes are both bigger than say 50. Try to find out how many such cases there are in the range 2..3000.

*)


let sieve n =
  let a = Array.make (n+1) true in
  let rec falsing j k =
    if j > n then ()
    else (a.(j) <- false;falsing (j+k) k)
  in 
  for i = 2 to n do
    if a.(i) then falsing (i+i) i
    else ()
  done;
  a

let goldbach_list i j =
  let a = sieve j in
  let goldbach n =
    let rec check i =
      if i > n then raise Not_found
      else if a.(i) && a.(n-i) then (i,n-i)
      else check (i+1)
    in 
    check 2
  in 
  let rec accum acc k =
    if k > j then acc
    else if k < 4 then accum acc 4
    else accum ((k,goldbach k)::acc) (k+2)
  in 
  accum [] i 

let goldbach_limit i j limit =
  goldbach_list i j |> List.filter (fun (k,(i,j)) -> if i > limit && j > limit then true else false)
