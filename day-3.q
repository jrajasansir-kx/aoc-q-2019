/ Advent of Code - 2019 - Day 3

fileData:read0 `$":input/day-3.data";


map:`R`U`L`D!((0;+);(1;+);(0;-);(1;-));

buildCoOrd:{[coord; op; move]
    @[coord; op 0; op 1; move]
 };

modTil:{
    $[x = 0;
        :enlist 0;
    / else
        :((::;neg) 0 > x) 1_ til 1 + abs x
    ];
 };


/ Part 1
.d3.p1:{
    wires:{ flip "SI"$(1#;1_)@/:\:x } each "," vs/: fileData;
    wireOps:enlist[0 0],/:(map;::)@'/: flip each wires;

    coords:enlist[0 0],/:(buildCoOrd\) ./: wireOps;

    intersections:1_ (inter). { enlist[0 0],raze (cross)./: x + next modTil@/:/:deltas x } each coords;
    :min sum each abs intersections;
 };

/ Part 2
.d3.p2:{
    wires:{ flip "SI"$(1#;1_)@/:\:x } each "," vs/: fileData;
    wireOps:enlist[0 0],/:(map;::)@'/: flip each wires;

    coords:enlist[0 0],/:(buildCoOrd\) ./: wireOps;

    trace:{ enlist[0 0],raze (cross)./: x + next modTil@/:/:deltas x } each coords;
    intersections:1_ (inter). trace;

    :min raze sum each where@/:/: intersections ~/:/:\: trace;
 };
