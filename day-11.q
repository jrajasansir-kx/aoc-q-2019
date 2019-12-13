/ Advent of Code - 2019 - Day 11

fileData:read0 `$"input/day-11.data";

instrLength:1 2 3 4 5 6 7 8 9 99!4 4 2 2 3 3 4 4 2 1;
k)jumpOps:5 6!((~=)[;0]; =[;0]);
compOps:7 8!(<;=);

moves:()!();
moves[90]:(0;+);
moves[180]:(1;-);
moves[270]:(0;-);
moves[360]:(1;+);

robotIntCode:{[startColor]
    program:"J"$"," vs first fileData;
    program,:10000#0;

    opIndex:0;
    relativeBase:0;

    output:`long$();

    currentCoOrd:0 0;
    painted:enlist[(0 0)]!enlist startColor;
    robotDir:360;

    while[1b;
        instr:((5 - count string program opIndex)#"0"),string program opIndex;

        op:"I"$-2#instr;
        pModes:"H"$/:1 2 3!instr 2 1 0;

        if[not op in 1 2 3 4 5 6 7 8 9;
            :painted;
        ];


        opAutoInc:1b;

        readOpLookup:(program;::;program@relativeBase+);
        wrteOpLookup:(::;{'"InstrErr" };relativeBase+);

        if[op in 1 2;
            res:(::;+;*)[op]. readOpLookup[pModes 1 2]@'program opIndex + 1 2;
            program[wrteOpLookup[pModes 3] program opIndex + 3]:res;
        ];

        if[op = 3;
            newInput:0^painted currentCoOrd;

            program[wrteOpLookup[pModes 1] program opIndex + 1]:newInput;
        ];

        if[op = 4;
            newOutput:readOpLookup[pModes 1] program opIndex + 1;

            output,:newOutput;

            if[2 = count output;
                painted[enlist currentCoOrd]:output 0;
                
                robotDir+:(-90;90) output 1;
                robotDir:$[robotDir <= 0; 360 + robotDir; robotDir > 360; robotDir - 360; robotDir];

                move:moves robotDir;
                currentCoOrd:@[currentCoOrd; move 0; move 1; 1];
                
                output:2_ output;
            ];
        ];

        if[op in 5 6;
            jVal:readOpLookup[pModes 1] program opIndex + 1;

            if[jumpOps[op] @ jVal;
                opAutoInc:0b;
                opIndex:readOpLookup[pModes 2] program opIndex + 2;
            ];
        ];

        if[op in 7 8;
            compRes:compOps[op] . readOpLookup[pModes 1 2]@'program opIndex + 1 2;
            program[wrteOpLookup[pModes 3] program opIndex + 3]:`long$compRes;
        ];

        if[op = 9;
            relativeBase+:readOpLookup[pModes 1] program opIndex + 1;
        ];


        if[opAutoInc;
            opIndex+:instrLength op;
        ];
    ];

    :program;
 };

.d11.p1:{
    paintRes:robotIntCode 0;
    :count paintRes;
 };

.d11.p2:{
    paintRes:robotIntCode 1;
    normalisedCoOrds:(abs[min asc key paintRes] +/: key paintRes)!value paintRes;

    canvasSize:max key normalisedCoOrds;

    canvas::(1+ last canvasSize)#enlist (1 + first canvasSize)#" ";

    {[x;coords] canvas::.[canvas; reverse x; :; ".#" coords x] }[;normalisedCoOrds] each key normalisedCoOrds;
    -1 reverse canvas;
 };

