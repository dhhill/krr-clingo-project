
% input x and y for rows and columns of the grid, respectively

#const x=4.  %todo get this dynamically from the input
#const y=5.  %todo get this dynamically from the input
#const p=2.  %todo get this dynamically from the input

%define pairs to represent squares in the grid
%{pair(X,Y)} : X=1..x, Y=1..y.

%----------------------------------------------------------------------------------------------------------------------------------
%initialize state based on input

%init(object(node,'n'),value(at,pair('x','y'))).
node(N, X,Y) :- init(object(node, N), value(at,pair(X,Y))).

%init(object(highway,'h'),value(at,pair('x','y'))).
highway(H, X,Y) :- init(object(highway, H), value(at,pair(X,Y))).

%init(object(pickingStation,'p'),value(at,pair('x','y'))).
pickingStation(P, X,Y) :- init(object(pickingStation, P), value(at,pair(X,Y))).

%init(object(robot,'r'),value(at,pair('x','y'))).
robot(R, X,Y, 0) :- init(object(robot, R), value(at,pair(X,Y))).

%init(object(shelf,'s'),value(at,pair('x','y'))).
shelf(S, X,Y, 0) :- init(object(shelf, S), value(at,pair(X,Y))).

%init(object(product,'i'),value(on,pair('s','u'))).
product(I, S,U) :- init(object(product, I), value(on,pair(S,U))).  % S is the shelf, U is the number of units on the shelf

%init(object(order,'o'),value(line,pair('i','u'))).
order(O, I,U) :- init(object(order, O), value(line,pair(I,U))).  % I is the product, U is the number of units ordered

%init(object(order,'o'),value(pickingStation,'p')).
order(O, P) :- init(object(order, O), value(pickingStation, P)).

%----------------------------------------------------------------------------------------------------------------------------------
%constraints

% each robot has exactly one position at each time step
:- {robot(R, X,Y, T)} != 1, R=1..r, T=0..h.

% no two occupants of the same square
:- robot(R1, X,Y, T1), robot(R2, X,Y, T2), R1=R2, T1=T2.

% robots cannot swap squares
:- robot(R1, X1,Y1, T1), robot(R2, X2,Y2, T1), robot(R1, X2,Y2, T + 1), robot(R2, X1,Y1, T + 1).

% each robot can only hold one shelf
:- holds(R, S1, T), holds(R, S2, T), S1!=S2.

% robot can't go into a square with a shelf if it's already carrying a shelf
:- robot(R, X1,Y1, T), robot(R, X2,Y2, T + 1), holds(R, S1, T), shelf(S2, X2,Y2, T).




