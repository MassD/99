module type X_int = 
sig 
  val x : int 
end

module Increment (M : X_int) : X_int = struct let x = M.x + 1 end

module Increment1 (M : X_int)  = struct let y = M.x+1 end
