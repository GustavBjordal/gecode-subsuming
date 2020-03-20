int: n;
set of int: N = 1..n;

array[N,N] of var 1..n*n: square;

include "globals.mzn";

constraint alldifferent(array1d(square));

annotation soften;
constraint forall(i in N)((sum(square[i,..]) = sum(1..n*n) div n)::soften);
constraint forall(i in N)((sum(square[..,i]) = sum(1..n*n) div n)::soften);
constraint (sum(i in N)(square[i,i]) = sum(1..n*n) div n)::soften;
constraint (sum(i in N)(square[n-i+1, i]) = sum(1..n*n) div n)::soften;

output [show2d(square)];

% constraint square = array2d(1..5, 1..5, [25, 5, 9, 3, 23, 4, 24, 15, 14, 8, 20, 7, 1, 16, 21, 6, 17, 18, 13, 11, 10, 12, 22, 19, 2]);

include "gecode.mzn";

solve :: relax_and_reconstruct(array1d(square), 60) satisfy;

