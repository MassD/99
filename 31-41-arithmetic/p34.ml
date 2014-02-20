(*

Calculate Euler's totient function φ(m). (medium)

Euler's so-called totient function φ(m) is defined as the number of positive integers r (1 ≤ r < m) that are coprime to m. We let φ(1) = 1.

Find out what the value of φ(m) is if m is a prime number. Euler's totient function plays an important role in one of the most widely used public key cryptography methods (RSA). In this exercise you should use the most primitive method to calculate this function (there are smarter ways that we shall discuss later).

*)

let gcd a b = 
  if a = b then a
  else if a > b then gcd b (a-b)
  else gcd a (b-a)

let coprime a b = (not (a mod 2 = 0 && b mod 2 = 0)) && gcd a b = 1

let phi m =
  let rec check i c =
    if i >= m then c
    else if coprime i m then check (i+1) (c+1)
    else check (i+1) c
  in 
  check 2 1
