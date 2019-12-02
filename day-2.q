/ Advent of Code - 2019 - Day 2

/ Part 1
operate:({[input; opLoc] 
    if[not input[opLoc] in 1 2;
        :input;
    ]; 
    
    input[input opLoc + 3]:((::;+;*) input opLoc) . input input opLoc + 1 2;
    
    :input; 
 });

.d2.p1:{
    input:"I"$"," vs first read0 `$"input/day-2.data";
    opsLoc:where 0 = mod[;4] til count input;

    :operate/[input; opsLoc];
 };
 
/ Part 2
.d2.p2:{
    input:"I"$"," vs first read0 `$"input/day-2.data";

    nv:(cross). 2#enlist til 100;

    res:{[origIn; nv]
        tInput:@[origIn; 1 2; :; nv];
        tOpsLoc:where 0 = mod[;4] til count tInput;

        tRes:operate/[tInput; tOpsLoc];

        $[19690720 = tRes 0;
            :nv;
        / else
            :();
        ];
    }[input;] each nv;

    :first res where not ()~/:res;
 };
