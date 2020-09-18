let
fx=(x)=>List.Transform({1..Number.Power(2,List.Count(x))-1},(y)=> List.Accumulate({0..List.Count(x)-1},"",(a,b)=>
a&({"",x{b}}{Number.BitwiseAnd(Number.BitwiseShiftRight(y,b),1)})))
in
fx
