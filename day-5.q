/ Advent of Code - 2019 - Day 5

fileData:read0 `$"input/day-5.data";

instrLength:1 2 3 4 5 6 7 8 99!4 4 2 2 3 3 4 4 1;
k)jumpOps:5 6!((~=)[;0]; =[;0]);
compOps:7 8!(<;=);

/ Part 1
.d5.p1:{
    input:"J"$"," vs first fileData;

    opIndex:0;

    while[not ""~input opIndex;
        instr:((5 - count string input opIndex)#"0"),string input opIndex;

        op:"I"$-2#instr;
        pModes:"B"$/:1 2 3!instr 2 1 0;

        if[not op in 1 2 3 4;
            :input;
        ];

        if[op in 1 2;
            res:(::;+;*)[op]. (input;::)[pModes 1 2]@'input opIndex + 1 2;

            $[pModes 3;
                '"Instruction Error - immediate mode for write location [ Instr: ",instr," ]";
            / else
                input[input opIndex + 3]:res
            ];
        ];

        if[op = 3;
            1 "Input: ";
            input[input opIndex + 1]:"J"$read0 0;
        ];

        if[op = 4;
            -1 "Output: ",.Q.s1 (input;::)[pModes 1] input opIndex + 1;
        ];

        opIndex+:instrLength op;
    ];

    :input;
 };

/ Part 2
.d5.p2:{
    input:"J"$"," vs first fileData;

    opIndex:0;

    while[1b;
        instr:((5 - count string input opIndex)#"0"),string input opIndex;

        op:"I"$-2#instr;
        pModes:"B"$/:1 2 3!instr 2 1 0;

        if[not op in 1 2 3 4 5 6 7 8;
            :input;
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
            1 "Input: ";
            input[input opIndex + 1]:"J"$read0 0;
        ];

        if[op = 4;
            -1 "Output: ",.Q.s1 (input;::)[pModes 1] input opIndex + 1;
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
