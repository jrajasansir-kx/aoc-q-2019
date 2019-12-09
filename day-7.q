/ Advent of Code - 2019 - Day 7

fileData:read0 `$"input/day-7.data";

instrLength:1 2 3 4 5 6 7 8 99!4 4 2 2 3 3 4 4 1;
k)jumpOps:5 6!((~=)[;0]; =[;0]);
compOps:7 8!(<;=);

runIntcodeComp:{[i2; i1]
    input:"J"$"," vs first fileData;

    opIndex:0;

    output:(::);
    i1used:0b;
    i2used:0b;

    while[1b;
        instr:((5 - count string input opIndex)#"0"),string input opIndex;

        op:"I"$-2#instr;
        pModes:"B"$/:1 2 3!instr 2 1 0;

        if[not op in 1 2 3 4 5 6 7 8;
            :output;
        ];


        opAutoInc:1b;

        if[op in 1 2;
            res:(::;+;*)[op]. (input;::)[pModes 1 2]@'input opIndex + 1 2;

            $[pModes 3;
                '"Instruction Error - immediate mode for write location [ Instr: ",instr," ]";
            / else
                input[input opIndex + 3]:res
            ];
        ];

        if[op = 3;
            $[not i1used;
                [ input[input opIndex + 1]:i1; i1used:1b ];
            not i2used;
                [ input[input opIndex + 1]:i2; i2used:1b ];
            / else
                '"No more auto-inputs, failing"
            ];
        ];

        if[op = 4;
            output:(input;::)[pModes 1] input opIndex + 1;
        ];

        if[op in 5 6;
            jVal:(input;::)[pModes 1] input opIndex + 1;

            if[jumpOps[op] @ jVal;
                opAutoInc:0b;
                opIndex:(input;::)[pModes 2] input opIndex + 2;
            ];
        ];

        if[op in 7 8;
            compRes:compOps[op] . (input;::)[pModes 1 2]@'input opIndex + 1 2;

            $[pModes 3;
                '"Instruction Error - immediate mode for write location [ Instr: ",instr," ]";
            / else
                input[input opIndex + 3]:`long$compRes
            ];
        ];


        if[opAutoInc;
            opIndex+:instrLength op;
        ];
    ];

    :input;
 };

/ Part 1
.d7.p1:{
    allPhaseComb:(cross/) 5#enlist til 5;
    uniqueSeqs:allPhaseComb where 5 = { count key group x } each allPhaseComb;

    allOutputs:uniqueSeqs!runIntcodeComp/[0;] each uniqueSeqs;
    :`seq`output!(where max[allOutputs] = allOutputs; max allOutputs);
 };
