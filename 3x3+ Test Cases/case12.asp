% requires h=12
% moved shelves in closer to reduce time from ~17

init(object(node,1),value(at,pair(1,1))).
init(object(node,2),value(at,pair(1,2))).
init(object(node,3),value(at,pair(1,3))).
init(object(node,4),value(at,pair(2,1))).
init(object(node,5),value(at,pair(2,2))).
init(object(node,6),value(at,pair(2,3))).
init(object(node,7),value(at,pair(3,1))).
init(object(node,8),value(at,pair(3,2))).
init(object(node,9),value(at,pair(3,3))).

init(object(pickingStation,1),value(at,pair(2,2))).

init(object(robot,1),value(at,pair(3,1))).

init(object(shelf,1),value(at,pair(1,2))).
init(object(shelf,2),value(at,pair(3,2))).

init(object(highway,1),value(at,pair(1,2))).
init(object(highway,2),value(at,pair(1,3))).
init(object(highway,3),value(at,pair(2,1))).
init(object(highway,4),value(at,pair(2,3))).
init(object(highway,5),value(at,pair(3,1))).
init(object(highway,6),value(at,pair(3,2))).

init(object(product,1),value(on,pair(1,500))).
init(object(product,1),value(on,pair(2,500))).

init(object(order,1),value(pickingStation,1)).
init(object(order,1),value(line,pair(1,1000))).
