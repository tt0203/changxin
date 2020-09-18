let
fx=(x,y)=>if y=0 then {{}} else List.TransformMany(x,each if _>y then {} else @fx(List.Skip(x,(t)=>t<=_),y-_),(m,n)=>{m}&n)
in
fx
