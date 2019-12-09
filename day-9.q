/ Advent of Code - 2019 - Day 9

fileData:read0 `$"input/day-9.data";

instrLength:1 2 3 4 5 6 7 8 9 99!4 4 2 2 3 3 4 4 2 1;
k)jumpOps:5 6!((~=)[;0]; =[;0]);
compOps:7 8!(<;=);

.d9.p1:{
    input:"J"$"," vs first fileData;
    input,:10000#0;

    opIndex:0;
    relativeBase:0;

    while[1b;
        instr:((5 - count string input opIndex)#"0"),string input opIndex;

        op:"I"$-2#instr;
        pModes:"H"$/:1 2 3!instr 2 1 0;

        if[not op in 1 2 3 4 5 6 7 8 9;
            :input;
        ];


        opAutoInc:1b;

        readOpLookup:(input;::;input@relativeBase+);
        wrteOpLookup:(::;{'"InstrErr" };relativeBase+);

        if[op in 1 2;
            res:(::;+;*)[op]. readOpLookup[pModes 1 2]@'input opIndex + 1 2;
            input[wrteOpLookup[pModes 3] input opIndex + 3]:res;
        ];

        if[op = 3;
            1 "Input: ";
            input[wrteOpLookup[pModes 1] input opIndex + 1]:"J"$read0 0;
        ];

        if[op = 4;
            -1 "Output: ",.Q.s1 readOpLookup[pModes 1] input opIndex + 1;
        ];

        if[op in 5 6;
            jVal:readOpLookup[pModes 1] input opIndex + 1;

            if[jumpOps[op] @ jVal;
                opAutoInc:0b;
                opIndex:readOpLookup[pModes 2] input opIndex + 2;
            ];
        ];

        if[op in 7 8;
            compRes:compOps[op] . readOpLookup[pModes 1 2]@'input opIndex + 1 2;
            input[wrteOpLookup[pModes 3] input opIndex + 3]:`long$compRes;
        ];

        if[op = 9;
            relativeBase+:readOpLookup[pModes 1] input opIndex + 1;
        ];


        if[opAutoInc;
            opIndex+:instrLength op;
        ];
    ];

    :input;
 };

/ Part 2
.d9.p2:.d9.p1;
