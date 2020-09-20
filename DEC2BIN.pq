(num as number)=>
List.Last(
    List.Generate(
           () =>[reminder = num,
                 binString= Number.ToText(Number.BitwiseAnd(reminder,1))],
           each [reminder]> 0,
           each [reminder = Number.BitwiseShiftRight([reminder],1),
                 binString= Number.ToText(Number.BitwiseAnd(reminder,1))&[binString]],
           each [binString]
        )
)
