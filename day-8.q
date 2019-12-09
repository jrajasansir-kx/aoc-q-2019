// Advent of Code - 2019 - Day 8

fileData:read0 `$"input/day-8.data";

/ Part 1
.d8.p1:{
    w:25;
    h:6;

    img:w cut/:(h*w) cut first fileData;

    zerosPerLayer:count each raze each where@/:/:"0"=/:/:img;

    layerWith0:first where min[zerosPerLayer] = zerosPerLayer;
    
    ones:count raze where each "1"=/:/:img layerWith0;
    twos:count raze where each "2"=/:/:img layerWith0;

    :ones*twos;
 };

/ Part 2
.d8.p2:{
    w:25;
    h:6;

    img:w cut/:(h*w) cut first fileData;

    imgByPixel:flip raze each "H"$/:/:/:img;

    res:w cut imgByPixel @' first each where each not 2 = imgByPixel;

    resStr:ssr[.Q.s res; enlist "0"; " "];

    -1 resStr;
 };
