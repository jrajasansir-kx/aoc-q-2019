/ Advent of Code - 2019 - Day 2

/ Part 1
input:"I"$"," vs first read0 `$"input/day-2.data";
opsLoc:where 0 = mod[;4] til count input;

func:({[input; opLoc] 
    if[not input[opLoc] in 1 2;
        :input;
    ]; 
    
    input[input opLoc + 3]:((::;+;*) input opLoc) . input input opLoc + 1 2;
    
    :input; 
 });
 
res:func/[input; opsLoc];

/ Part 2
runTest:{
    validInputs:(cross). 2#enlist til 100;

    {
        tInput:@[input; 1 2; :; x];
        tOpsLoc:where 0 = mod[;4] til count tInput;

        tRes:func/[tInput; tOpsLoc];

        if[19690720 = tRes 0;
            -1 "RESULT | Input: ",.Q.s1[x]," | Answer: ",string (100 * x 0) + x 1;
        ];
    } each validInputs
 };
