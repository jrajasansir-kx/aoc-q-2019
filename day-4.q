/ Advent of Code - 2019 - Day 4

/ Part 1
input:"183564-657474";

.d4.p1:{
    pInput:"J"$"-" vs input;

    allPwds:first[pInput] + til 1 + (-). reverse pInput;
    allPwdsInt:.Q.n?string allPwds;

    adjacent:where 0 in/:deltas each allPwdsInt;
    incrementing:where (asc each allPwdsInt)~'allPwdsInt;

    :count adjacent inter incrementing;
 };

/ Part 2
.d4.p2:{
    pInput:"J"$"-" vs input;

    allPwds:first[pInput] + til 1 + (-). reverse pInput;
    allPwdsInt:.Q.n?string allPwds;

    adjacent:where 0 in/:deltas each allPwdsInt;
    incrementing:where (asc each allPwdsInt)~'allPwdsInt;

    :count where any each 2=/:count@/:/:group each allPwdsInt adjacent inter incrementing;
 };
