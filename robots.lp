%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% robots.lp
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% sort and object declaration
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

holdable(H) :- object(shelf, H).
holdable(nothing).

% order object with indicated types available
object(node; highway; pickingStation; robot; shelf; product; order).

%initialize state based on input

%init(object(node,'n'),value(at,pair('x','y'))).
node(X,Y) :- init(object(node, N), value(at,pair(X,Y))).

%init(object(highway,'h'),value(at,pair('x','y'))).
highway(X,Y) :- init(object(highway, H), value(at,pair(X,Y))).

%init(object(pickingStation,'p'),value(at,pair('x','y'))).
pickingStation(P, X,Y) :- init(object(pickingStation, P), value(at,pair(X,Y))).

%init(object(robot,'r'),value(at,pair('x','y'))).
robot(R, X,Y, 0) :- init(object(robot, R), value(at,pair(X,Y))).
object(robot, R) :- init(object(robot, R), value(at,pair(X,Y))).
holds(R, nothing, 0) :- init(object(robot, R), value(at,pair(X,Y))).

%init(object(shelf,'s'),value(at,pair('x','y'))).
shelf(S, X,Y, 0) :- init(object(shelf, S), value(at,pair(X,Y))).
object(shelf, S) :- init(object(shelf, S), value(at,pair(X,Y))).

%init(object(product,'i'),value(on,pair('s','u'))).
product(I, S,U) :- init(object(product, I), value(on,pair(S,U))).  % S is the shelf, U is the number of units on the shelf

%init(object(order,'o'),value(line,pair('i','u'))).
order(O, I,U) :- init(object(order, O), value(line,pair(I,U))).  % I is the product, U is the number of units ordered
leftToDeliver(O, I,U, 0) :- init(object(order, O), value(line,pair(I,U))).

%init(object(order,'o'),value(pickingStation,'p')).
order(O, P) :- init(object(order, O), value(pickingStation, P)).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% state constraints
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% a robot can only have one position at any given time
:- robot(R, X1,Y1, T), robot(R, X2,Y2, T), X1!=X2, Y1!=Y2.

% no two occupants of the same square
:- robot(R1, X,Y, T), robot(R2, X,Y, T), R1!=R2.

% each robot can only hold one shelf
:- holds(R, S1, T), holds(R, S2, T), S1!=S2.

% if a robot is holding a shelf, the shelf has the same location as the robot
shelf(S, X,Y, T) :- robot(R, X,Y, T), holds(R, S, T), S!=nothing.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% effects and preconditions of actions
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%occurs(object(robot,’r’),move(’dx’,’dy’),’t’).
robot(R, X+DX,Y+DY, T+1) :- robot(R, X,Y, T), move(R, DX, DY, T).
occurs(object(robot, R), move(DX,DY), T) :- robot(R, X,Y, T), move(R, DX, DY, T).

%occurs(object(robot,’r’),pickup,’t’).
holds(R, S, T+1) :- pickup(R, S, T).
occurs(object(robot, R), pickup, T) :- pickup(R, S, T).

%occurs(object(robot,’r’),deliver(’o’,’i’,’u’),’t’).
leftToDeliver(O, I, U - U1, T+1) :- deliver(R, O, I, U1, T), leftToDeliver(O, I, U, T).
occurs(object(robot, R), deliver(O, I, U), T) :- deliver(R, O, I, U, T).

%occurs(object(robot,'r'), putdown,'t').
holds(R, nothing, T + 1) :- putdown(R, S, T).
occurs(object(robot, R), putdown, T) :- putdown(R, S, T).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% action constraints
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% move ----------------------------------------------------------------------------------------------------

% can only move to an adjascent square
:- move(R, DX,DY, T), |DX| + |DY| != 1.

% can't move outside of the established grid
:- robot(R, X,Y, T), not node(X,Y).

% robots cannot swap squares
:- robot(R1, X1,Y1, T), robot(R2, X2,Y2, T), robot(R1, X2,Y2, T + 1), robot(R2, X1,Y1, T + 1), R1!=R2.

% robot can't go into a square with a shelf if it's already carrying a shelf
%:- robot(R, X,Y, T), move(R, DX,DY, T), holds(R, S1, T), shelf(S2, X+DX, Y+DY, T + 1), S1 != S2.



% pickup ----------------------------------------------------------------------------------------------------

% can't pick something up that is not in the same square
:- pickup(R, S, T), robot(R, X,Y, T), not shelf(S, X,Y, T).

% can't pick something up if already holding something
:- pickup(R, S, T), holds(R, S1, T), S1!=nothing.



% deliver ----------------------------------------------------------------------------------------------------

% can't deliver if not at the picking station
:- deliver(R, O, I,U, T), robot(R, X,Y, T), not {pickingStation(P, X,Y)} = 1.

% can't deliver if the robot isn't holding a shelf that matches the order
:- robot(R, X,Y, T), pickingStation(P, X,Y), order(O, P), order(O, I,U1), holds(R, S, T), product(I, S,U2), deliver(R, O, I,U2, T).


% only deliver if the robot is holding a shelf that matches the order, and is at the picking station
deliver(R, O, I,U2, T) :- robot(R, X,Y, T), pickingStation(P, X,Y), order(O, P), order(O, I,U1), holds(R, S, T), product(I, S,U2).




% putdown ----------------------------------------------------------------------------------------------------

% can't put something down if it's not being carried
:- putdown(R, S, T), not holds(R, S, T).

% can't put down nothing
:- putdown(R, S, T), S=nothing.

% can't put something down in a highway square
:- putdown(R, S, T), robot(R, X,Y, T), highway(X,Y).





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% domain independent axioms
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% fluents are initially exogenous 
1{robot(R, X,Y, 0):node(X,Y)}1 :- robot(R, X,Y, 0).
1{holds(R, nothing, 0)}1 :- object(robot, R).
1{shelf(S, X,Y, 0):node(X,Y)}1 :- shelf(S, X,Y, 0).

% uniqueness and existence of value constraints
:- not {node(X,Y)} = 1, robot(R, X,Y, T), T=0..h.
:- not {robot(R, X,Y, T)} 1, node(X,Y), T=0..h.
:- not {robot(R, X,Y, T)} = 1, object(robot, R), T=0..h.
:- not {shelf(S, X,Y, T)} = 1, object(shelf, S), T=0..h.
:- not {holds(R, S, T)} = 1, object(robot, R), T=0..h.
:- not {deliver(R, O, I,U, T)} 1, object(robot, R), T=0..h.


% actions are exogenous

% move
{move(R, DX,DY, T)} :- object(robot, R), DX=-1..1, DY=-1..1, T = 0..h-1.

% pickup
{pickup(R, S, T)} :- object(robot, R), object(shelf, S), T = 0..h-1.

% deliver
{deliver(R, O, I,U, T)} :- object(robot, R), order(O, I,U), T = 0..h-1.

% putdown
{putdown(R, S, T)} :- object(robot, R), object(shelf, S), T = 0..h-1.


% everything stays where it was if no movement is indicated (commonsense law of inertia)
{robot(R, X,Y, T + 1)} :- robot(R, X,Y, T), T=0..h-1.
{shelf(S, X,Y, T + 1)} :- shelf(S, X,Y, T), T=0..h-1.
{holds(R, S, T + 1)} :- holds(R, S, T), T=0..h-1.
{leftToDeliver(O, I,U, T + 1)} :- leftToDeliver(O, I,U, T), T=0..h-1.





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% goal
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

totalLeftToDeliver(X) :- X = #sum{U, O,I, T: leftToDeliver(O, I,U, T)}.
%#minimize{X : totalLeftToDeliver(X)}.

:- #sum{U, O,I: leftToDeliver(O, I,U, h)} != 0.

% count how many time units are needed, then minimize that number
timeUnits(N) :- N = #count{T: move(R, DX, DY, T)}.
%#minimize{N: timeUnits(N)}.



#show timeUnits/1.
%#show totalLeftToDeliver/1.
%#show shelf/4.
%#show robot/4.
%#show holds/3.
#show pickup/3.
#show putdown/3.