
%occurs(object(robot,'r'),move('dx','dy'),'t').
robot(R, X + dx, Y + dy, T + 1) :- occurs(object(robot,R), move(dx, dy), T).

% shelf moves locations with the robot that's carrying it
shelf(S, X + dx, Y + dy, T + 1) :- occurs(object(robot,R), move(dx, dy), T), holds(R, S, T).

% everything stays where it was if no movement is indicated (commonsense law of inertia)
robot(R, X,Y, T + 1) :- robot(R, X,Y, T), not not robot(R, X,Y, T + 1), T=0..h-1.
shelf(S, X,Y, T + 1) :- shelf(S, X,Y, T), not not shelf(S, X,Y, T + 1), T=0..h-1.
holds(R, S, T + 1) :- holds(R, S, T), not not holds(R, S, T + 1), T=0..h-1.

% can only move to an adjascent square
:- move(DX, DY), |DX| + |DY| != 1.


%occurs(object(robot,'r'),pickup,'t').
holds(R, S, T) :- occurs(object(robot,R), pickup, T), robot(R, X1,Y1, T1), shelf(S, X2,Y2, T2), X1=X2, Y1=Y2, T1=T2.

% can't pick something up that is not in the same square
:- occurs(object(robot,R), pickup, T), robot(R, X,Y, T), not shelf(S, X,Y, T).

%occurs(object(robot,'r'),deliver('o','i','u'),'t').



%occurs(object(robot,'r'),putdown,'t').
not holds(R, S, T + 1) :- occurs(object(robot,R), putdown, T), holds(R, S, T).

% can't put something down if it's not being carried
:- occurs(object(robot,R), putdown, T), not holds(R, S, T).

% can't put something down in a highway square
:- occurs(object(robot,R), putdown, T), robot(R, X,Y, T), highway(H, X,Y).








% count the number of moves
%count(T) :- T = #count{T: occurs([something], T)}.

% minimize the number of moves
%#maximize{T : count(T)}.

#show occurs/3.