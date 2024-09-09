% Weights
float: cl1; %\lambda_1
float: cl2; %\lambda_2
float: cl3; %\lambda_3
float: cl4; %\lambda_4
float: cl5; %\lambda_5

% Parameters for sets
int: S;
int: overline_t;
int: hat_t;
int: D;
int: P;
int: E;


% Sets
set of int: Students = 0..S;
set of int: Slots = 0..overline_t;
set of int: Morning = 0..hat_t;
set of int: Afternoon = (hat_t+1)..overline_t;
set of int: Days = 0..D;
set of int: Sessions = 0..P;
set of int: Specialisations = 0..E;

% Parameters
array[Students,Days,Slots] of int: a;
array[Students,Specialisations] of int: b;
int: u;
int: v;
int: M;



% Decision variables
array[Students,Slots,Sessions,Days] of var 0..1: x;
array[Specialisations, Sessions] of var 0..1: y;
array[Specialisations, Sessions] of var 0..1: z;
array[Sessions,Days] of var 0..1: alpha;
array[Slots,Sessions] of var 0..1: beta;
array[Sessions] of var 0..1: gamma;
array[Slots,Sessions,Specialisations] of var 0..1: delta;




% Constraints
constraint forall(s in Students)(sum(t in Slots, p in Sessions, d in Days)(x[s,t,p,d]) == 1);

constraint forall(p in Sessions)(sum(t in hat_t..(hat_t+1))(beta[t,p]) <= 1);

constraint forall(p in Sessions)(
    sum(t in Morning)(beta[t,p]) <= v * gamma[p]
);

constraint forall(p in Sessions)(
    sum(t in Afternoon)(beta[t,p]) <= v * gamma[p]
);

constraint forall(p in Sessions)(
    sum(t in Morning)(beta[t,p]) >= u * gamma[p]
);

constraint forall(p in Sessions)(
    sum(t in Afternoon)(beta[t,p]) >= u * gamma[p]
);


constraint forall(p in Sessions)(sum(d in Days)(alpha[p,d]) = gamma[p]);
constraint forall(t in Slots, p in Sessions)(sum(s in Students, d in Days)(x[s,t,p,d]) = beta[t,p]);
constraint forall(p in Sessions, d in Days)(sum(s in Students, t in Slots)(x[s,t,p,d]) <= M * alpha[p,d]);
constraint forall(p in Sessions, d in Days)(sum(s in Students, t in Slots)(x[s,t,p,d]) >= alpha[p,d]);

constraint forall(e in Specialisations, p in Sessions)(
    y[e,p] <= sum(s in Students, t in Morning, d in Days)(x[s,t,p,d] * b[s,e])
);


constraint forall(e in Specialisations, p in Sessions)(
    int2float(y[e,p]) >= sum(s in Students, t in Morning, d in Days)(int2float(x[s,t,p,d] * b[s,e])) / int2float(v)
);


constraint forall(e in Specialisations, p in Sessions)(
    y[e,p] <= 1
);

constraint forall(e in Specialisations, p in Sessions)(
    z[e,p] <= sum(s in Students, t in Afternoon, d in Days)(x[s,t,p,d] * b[s,e])
);

constraint forall(e in Specialisations, p in Sessions)(
    int2float(z[e,p]) >= sum(s in Students, t in Afternoon, d in Days)(int2float(x[s,t,p,d] * b[s,e])) / int2float(v)
);

constraint forall(e in Specialisations, p in Sessions)(
    z[e,p] <= 1
);

constraint forall(t in Slots, p in Sessions, e in Specialisations)(
    delta[t,p,e] = sum(s in Students, d in Days)(x[s,t,p,d] * b[s,e])
);


% Objective
% f1
var int: F1 = sum(t in 0..(hat_t - 1), p in Sessions)(abs(beta[t,p] - beta[t+1,p])) +
            sum(t in (hat_t + 1)..(overline_t - 1), p in Sessions)(abs(beta[t,p] - beta[t+1,p]));
            
% f2
var int: F2 = sum(e in Specialisations, p in Sessions)(y[e,p] + z[e,p]);

% f3
var int: F3 = sum(t in 0..(hat_t - 1), p in Sessions, e in Specialisations)(abs(delta[t,p,e] - delta[t+1,p,e])) +
            sum(t in (hat_t + 1)..(overline_t - 1), p in Sessions, e in Specialisations)(abs(delta[t,p,e] - delta[t+1,p,e]));
               
% f4
var int: F4 = sum(s in Students, t in Slots, p in Sessions, d in Days)(x[s,t,p,d] * (1 - a[s,d,t]));

% f5
var int: F5 = sum(p in Sessions)(gamma[p]);


solve minimize cl1 * F1 + cl2 * F2 + cl3 * F3 + cl4 * F4 + cl5 * F5;


output [
  "f1=" ++ show(F1) ++ ",",
  "f2=" ++ show(F2) ++ ",",
  "f3=" ++ show(F3) ++ ",",
  "f4=" ++ show(F4) ++ ",",
  "f5=" ++ show(F5) ++ ",\n"
] ++
[
  "\n" ++ "x = " ++ show(x)
]
