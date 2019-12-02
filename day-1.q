/ Advent of Code - 2019 - Day 1

/ Part 1
sum -[;2] floor %[;3] "J"$read0 `$":input/day-1.csv"

/ Part 2
sum sum 1_ ({0|-[;2] x div 3})\["J"$read0 `$":input/day-1.csv"]
