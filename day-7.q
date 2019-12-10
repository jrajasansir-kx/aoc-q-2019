/ Advent of Code - 2019 - Day 7

fileData:read0 `$"input/day-7.data";

instrLength:1 2 3 4 5 6 7 8 99!4 4 2 2 3 3 4 4 1;
k)jumpOps:5 6!((~=)[;0]; =[;0]);
compOps:7 8!(<;=);

runIntcodeComp:{[input; phase]
    program:"J"$"," vs first fileData;

    opIndex:0;

    output:`long$();
    input:phase,input;
    inputsUsed:count[input]#0b;

    while[1b;
        instr:((5 - count string program opIndex)#"0"),string program opIndex;

        op:"I"$-2#instr;
        pModes:"B"$/:1 2 3!instr 2 1 0;

        if[not op in 1 2 3 4 5 6 7 8;
            :output;
        ];


        opAutoInc:1b;

        if[op in 1 2;
            res:(::;+;*)[op]. (program;::)[pModes 1 2]@'program opIndex + 1 2;

            $[pModes 3;
                '"Instruction Error - immediate mode for write location [ Instr: ",instr," ]";
            / else
                program[program opIndex + 3]:res
            ];
        ];

        if[op = 3;
            newInput:input first where not inputsUsed;

            if[null newInput;
                '"No more auto-input, failing - I: ",.Q.s1[input]," | OP: ",string op;
            ];

            program[program opIndex + 1]:newInput;
            inputsUsed[first where not inputsUsed]:1b;
        ];

        if[op = 4;
            output,:(program;::)[pModes 1] program opIndex + 1;
        ];

        if[op in 5 6;
            jVal:(program;::)[pModes 1] program opIndex + 1;

            if[jumpOps[op] @ jVal;
                opAutoInc:0b;
                opIndex:(program;::)[pModes 2] program opIndex + 2;
            ];
        ];

        if[op in 7 8;
            compRes:compOps[op] . (program;::)[pModes 1 2]@'program opIndex + 1 2;

            $[pModes 3;
                '"Instruction Error - immediate mode for write location [ Instr: ",instr," ]";
            / else
                program[program opIndex + 3]:`long$compRes
            ];
        ];


        if[opAutoInc;
            opIndex+:instrLength op;
        ];
    ];

    :program;
 };

/ Part 1
.d7.p1:{
    allPhaseComb:(cross/) 5#enlist til 5;
    uniqueSeqs:allPhaseComb where 5 = { count key group x } each allPhaseComb;

    allOutputs:first each uniqueSeqs!runIntcodeComp/[enlist 0;] each uniqueSeqs;
    :`seq`output!(where max[allOutputs] = allOutputs; max allOutputs);
 };


runIntcodeMultiProcComp:{[input; phases]
    multiProc:`amp xkey flip `amp`phase`opIndex`program`input`output!"III***"$\:();
    multiProc[0]:(phases 0; 0; `long$(); phases[0],input; `long$());
    multiProc[1]:(phases 1; 0; `long$(); enlist phases 1; `long$());
    multiProc[2]:(phases 2; 0; `long$(); enlist phases 2; `long$());
    multiProc[3]:(phases 3; 0; `long$(); enlist phases 3; `long$());
    multiProc[4]:(phases 4; 0; `long$(); enlist phases 4; `long$());

    multiProc:update program:5#enlist ("J"$"," vs first fileData) from multiProc;

    -1 .Q.s multiProc;

    amp:0i;

    while[1b;
        ampOpIndex:multiProc[amp; `opIndex];
        ampProgram:multiProc[amp; `program];

        instr:((5 - count string ampProgram ampOpIndex)#"0"),string ampProgram ampOpIndex;

        op:"I"$-2#instr;
        pModes:"B"$/:1 2 3!instr 2 1 0;
        
        ampSwitch:0b;
        newAmp:0Ni;

        if[not op in 1 2 3 4 5 6 7 8;
            if[4 = amp;
                :delete program from multiProc;
            ];

            newAmp:amp+1;
            ampSwitch:1b;
        ];

    
        opAutoInc:1b;

        if[op in 1 2;
            res:(::;+;*)[op]. (ampProgram;::)[pModes 1 2]@'ampProgram ampOpIndex + 1 2;

            $[pModes 3;
                '"Instruction Error - immediate mode for write location [ Instr: ",instr," ]";
            / else
                ampProgram[ampProgram ampOpIndex + 3]:res
            ];
        ];

        if[op = 3;
            newInput:first multiProc[amp; `input];

            if[null newInput;
                '"No more auto-input, failing - I: ",.Q.s1 multiProc[amp; `input];
            ];

            multiProc[amp; `input]:1_ multiProc[amp; `input];
            ampProgram[ampProgram ampOpIndex + 1]:newInput;
        ];

        if[op = 4;
            newOutput:(ampProgram;::)[pModes 1] ampProgram ampOpIndex + 1;
            
            newAmp:$[amp = 4; 0; amp+1];
            ampSwitch:1b;

            multiProc[amp; `output],:newOutput;
            multiProc[newAmp; `input],:newOutput;
        ];

        if[op in 5 6;
            jVal:(ampProgram;::)[pModes 1] ampProgram ampOpIndex + 1;

            if[jumpOps[op] @ jVal;
                opAutoInc:0b;
                ampOpIndex:(ampProgram;::)[pModes 2] ampProgram ampOpIndex + 2;
            ];
        ];

        if[op in 7 8;
            compRes:compOps[op] . (ampProgram;::)[pModes 1 2]@'ampProgram ampOpIndex + 1 2;

            $[pModes 3;
                '"Instruction Error - immediate mode for write location [ Instr: ",instr," ]";
            / else
                ampProgram[ampProgram ampOpIndex + 3]:`long$compRes
            ];
        ];


        if[opAutoInc;
            ampOpIndex+:instrLength op;
        ];

        multiProc[amp; `opIndex]:ampOpIndex;
        multiProc[amp; `program]:ampProgram;

        if[ampSwitch;
            amp:newAmp;
        ];
    ];
 };


/ Part 2
.d7.p2:{
    allPhaseComb:(cross/) 5#enlist 5+til 5;
    uniqueSeqs:allPhaseComb where 5 = { count key group x } each allPhaseComb;

    allOutputs:uniqueSeqs!runIntcodeMultiProcComp[enlist 0;] each uniqueSeqs;
    allOutputs:{ last last last x } each allOutputs;

    :`seq`output!(where max[allOutputs] = allOutputs; max allOutputs);
 };
