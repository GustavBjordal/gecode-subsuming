
include "globals.mzn";

%-------------------------------------------------
% Model parameters
%-------------------------------------------------
int: n_cars;      % The number of cars
int: n_options;   % The number of options to install, e.g "sun roof", "air-conditioning".
int: n_confs;     % The number of configurations. A configuration specifies a variant on the basic model.
                  % e.g. a configuration may include the basic model, sun roof and air-conditioning.

set of int: cars             = 1..n_cars;
set of int: options          = 1..n_options;
set of int: configurations   = 1..n_confs;



array [options] of int: k;
array [options] of int: min_caps;       % min_caps[j] --   the minimum capacity of the jth station (the jth station installs jth option).  
array [options] of int: max_caps;       % max_caps[j] --   the maximum capacity of the jth station 

array [configurations]  of int: n_cars_by_confs;        % n_cars_by_confs[j] -- the required number of cars of jth configuration. 
array [configurations, options]  of int: confs;         % if confs[i,j] == 1 then ith option has to be installed for jth configuration

array [options] of int: options_ordering;               % An options ordering: options for which demand is closer to capacity are assigned first. [1]

%----------------------------------------------------
% Additional model parameters 
%----------------------------------------------------

% the number of options in each configuration
array [configurations] of int: n_opts_by_confs = [ sum (j in options)( confs[i,j] ) | i in configurations];

% set of configurations for each option 
array[options] of set of int: confs_by_opts = 
[ 
	{i| i in configurations where (confs[i,j] mod 2  = 1)}
	| j in options 
];



array [cars]    of var configurations:         seq_confs;
array [options, cars]  of var 0..1:            b_seq_confs; % = array2d(options, cars, [ confs[seq_confs[c], o] | o in options, c in cars ]);

constraint forall(o in options, c in cars)(
b_seq_confs[o,c] = confs[seq_confs[c],o] ::domain
);

constraint global_cardinality_closed(seq_confs, configurations, n_cars_by_confs);

annotation soften;
constraint forall(o in options, j in 1 .. n_cars-k[o])(
 (sum(i in j..j+k[o]-1)(b_seq_confs[o, i]) <= max_caps[o])::soften
);

include "gecode.mzn";

solve 
::relax_and_reconstruct(seq_confs, 60)
::int_search(seq_confs, first_fail, indomain_min, complete)
satisfy;

output [
"Solution: \n",
"\t cars =   \n \t", show(seq_confs), "\n",
"\t options by cars =   \n", show2d(b_seq_confs), "\n"];


