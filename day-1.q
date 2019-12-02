/ Advent of Code - 2019 - Day 1

.d1.p1:{
    sum -[;2] floor %[;3] "J"$read0 `$":input/day-1.csv"
 };

.d1.p2:{
    sum sum 1_ ({0|-[;2] x div 3})\["J"$read0 `$":input/day-1.csv"]
 };
