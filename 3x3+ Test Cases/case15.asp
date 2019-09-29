% requires h=10
% had to take out a few orders to reduce time steps

init(object(node,1),value(at,pair(1,1))).
init(object(node,2),value(at,pair(1,2))).
init(object(node,3),value(at,pair(1,3))).
init(object(node,4),value(at,pair(2,1))).
init(object(node,5),value(at,pair(2,2))).
init(object(node,6),value(at,pair(2,3))).
init(object(node,7),value(at,pair(3,1))).
init(object(node,8),value(at,pair(3,2))).
init(object(node,9),value(at,pair(3,3))).

init(object(pickingStation,1),value(at,pair(1,1))).
init(object(pickingStation,2),value(at,pair(1,2))).
init(object(pickingStation,3),value(at,pair(1,3))).
init(object(pickingStation,4),value(at,pair(2,1))).
init(object(pickingStation,5),value(at,pair(2,3))).
init(object(pickingStation,6),value(at,pair(3,1))).
init(object(pickingStation,7),value(at,pair(3,3))).

init(object(robot,1),value(at,pair(3,2))).

init(object(shelf,1),value(at,pair(3,2))).

init(object(highway,1),value(at,pair(3,2))).

init(object(product,1),value(on,pair(1,700))).

init(object(order,1),value(pickingStation,1)).
init(object(order,1),value(line,pair(1,100))).

init(object(order,2),value(pickingStation,2)).
init(object(order,2),value(line,pair(1,100))).

%init(object(order,3),value(pickingStation,3)).
%init(object(order,3),value(line,pair(1,100))).

init(object(order,4),value(pickingStation,4)).
init(object(order,4),value(line,pair(1,100))).

%init(object(order,5),value(pickingStation,5)).
%init(object(order,5),value(line,pair(1,100))).

init(object(order,6),value(pickingStation,6)).
init(object(order,6),value(line,pair(1,100))).

%init(object(order,7),value(pickingStation,7)).
%init(object(order,7),value(line,pair(1,100))).
