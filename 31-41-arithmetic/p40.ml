(*

Goldbach's conjecture. (medium)

Goldbach's conjecture says that every positive even number greater than 2 is the sum of two prime numbers. Example: 28 = 5 + 23. It is one of the most famous facts in number theory that has not been proved to be correct in the general case. It has been numerically confirmed up to very large numbers. Write a function to find the two prime numbers that sum up to a given even integer.

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

let goldbach n =
  if n mod 2 <> 0 then failwith "Not an even number"
  else if n < 4 then failwith "Not bigger than 2"
  else 
    let a = sieve n in
    let rec check i =
      if i > n-2 then raise Not_found
      else if a.(i) && a.(n-i) then (i,n-i)
      else check (i+1)
    in 
    check 2
