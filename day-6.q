/ Advent of Code - 2019 - Day 6

fileData:read0 `$"input/day-6.data";

store:()!();

/ Part 1
.d6.p1:{
    store::0#store;
    { store[x 0],:x 1 } each "S"$")" vs/:fileData;
    :count (raze/) each (store\) raze value store;
 };

/ Part 2
.d6.p2:{
    store::0#store;
    { store[x 0],:x 1 } each "S"$")" vs/:fileData;

    subTrees:distinct[raze value store]!1_/:(raze/) each (store\) each distinct raze value store;
    validSubTrees:where all each `SAN`YOU in/: subTrees;

    subTreeRoot:first key asc count each validSubTrees#subTrees;

    subTreeDepth:(raze/)@/:/:flip (store\) subTreeRoot;
    
    youDepth:max first each where each `YOU in/:/:subTreeDepth;
    sanDepth:max first each where each `SAN in/:/:subTreeDepth;

    :youDepth + sanDepth - 2;
 };
