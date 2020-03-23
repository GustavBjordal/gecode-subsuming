include "globals.mzn";

int: n;
set of int: Cities = 1..n;

int:horizon = max(array1d(time_window));
int: depot = 1;
array[Cities,Cities] of int: distance;

array[Cities,1..2] of int: time_window;

array[Cities] of var Cities: pred;
% array[Cities] of var Cities: succ;

constraint circuit(pred) ::domain;
% constraint inverse(succ,pred);

array[Cities] of var 0..horizon: arrival_time;


constraint arrival_time[depot] = time_window[depot,1];
constraint forall(i in Cities where i != depot)(
  (arrival_time[i] >= time_window[i,1])
);

constraint forall(i in Cities where i != depot)(
  (arrival_time[i] >= arrival_time[pred[i]]+distance[pred[i],i])::soften
);


annotation soften;

constraint forall(i in Cities)(
  arrival_time[i] <= time_window[i,2]
);


var int: obj;
constraint obj = sum(i in Cities)(distance[pred[i],i]);

% array[Cities] of var 0..horizon: pred_dist;
% constraint pred_dist[depot] = 0;
% constraint forall(i in Cities where i != depot)(
%   (pred_dist[i] = distance[pred[i],i]) :: domain
% );

% output [show(obj) ++ "\n"] ++ [ show(i-1 ) ++ " " | i in arg_sort(fix(arrival_time))];

include "gecode.mzn";

solve 
::relax_and_reconstruct(pred, 70)
:: seq_search([
% int_search(pred_dist, max_regret, indomain_min, complete),
int_search(pred, dom_w_deg, indomain_random, complete),
               int_search(arrival_time,input_order, indomain_max, complete),
              ]) 
minimize obj;
% satisfy;
