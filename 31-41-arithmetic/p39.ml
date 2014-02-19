(*

A list of prime numbers. (easy)

Given a range of integers by its lower and upper limit, construct a list of all prime numbers in that range.

*)

let sieve n =
  let a = Array.make (n+1) true in
  let rec falsing j k =
    if j > n then ()
    else (a.(j) <- false; falsing (j+k) k)
  in
  for i = 2 to n do
    if a.(i) then falsing (2*i) i
    else ()
  done;
  a

let rec all_primes i j =
  if i > j then all_primes j i
  else 
    let a = sieve j in
    let rec accu acc k =
      if k > j then acc
      else if a.(k) then accu (k::acc) (k+1)
      else accu acc (k+1)
    in 
    accu [] i
