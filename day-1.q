/ Advent of Code - 2019 - Day 1

fileData:read0 `$":input/day-1.data";

.d1.p1:{
    sum -[;2] floor %[;3] "J"$fileData
 };

.d1.p2:{
    sum sum 1_ ({0|-[;2] x div 3})\["J"$fileData]
 };
