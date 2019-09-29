% requires 11
% moved the starting location of the robots to reduce the time

init(object(node,1),value(at,pair(1,1))).
init(object(node,2),value(at,pair(2,1))).
init(object(node,3),value(at,pair(3,1))).
init(object(node,4),value(at,pair(4,1))).
init(object(node,5),value(at,pair(1,2))).
init(object(node,6),value(at,pair(2,2))).
init(object(node,7),value(at,pair(3,2))).
init(object(node,8),value(at,pair(4,2))).
init(object(node,9),value(at,pair(1,3))).
init(object(node,10),value(at,pair(2,3))).
init(object(node,11),value(at,pair(3,3))).
init(object(node,12),value(at,pair(4,3))).
init(object(node,13),value(at,pair(1,4))).
init(object(node,14),value(at,pair(2,4))).
init(object(node,15),value(at,pair(3,4))).
init(object(node,16),value(at,pair(4,4))).

init(object(pickingStation,1),value(at,pair(2,2))).
init(object(pickingStation,2),value(at,pair(2,3))).
init(object(pickingStation,3),value(at,pair(3,2))).
init(object(pickingStation,4),value(at,pair(3,3))).

init(object(robot,1),value(at,pair(1,2))).
init(object(robot,2),value(at,pair(1,3))).
init(object(robot,3),value(at,pair(4,2))).
init(object(robot,4),value(at,pair(4,3))).

init(object(shelf,1),value(at,pair(1,2))).
init(object(shelf,2),value(at,pair(1,3))).
init(object(shelf,3),value(at,pair(2,1))).
init(object(shelf,4),value(at,pair(3,1))).
init(object(shelf,5),value(at,pair(2,4))).
init(object(shelf,6),value(at,pair(3,4))).
init(object(shelf,7),value(at,pair(4,2))).
init(object(shelf,8),value(at,pair(4,3))).

init(object(product,1),value(on,pair(1,500))).
init(object(product,1),value(on,pair(3,500))).
init(object(product,2),value(on,pair(2,500))).
init(object(product,2),value(on,pair(5,500))).
init(object(product,3),value(on,pair(4,500))).
init(object(product,3),value(on,pair(7,500))).
init(object(product,4),value(on,pair(6,500))).
init(object(product,4),value(on,pair(8,500))).

init(object(order,1),value(pickingStation,1)).
init(object(order,1),value(line,pair(1,1000))).

init(object(order,2),value(pickingStation,2)).
init(object(order,2),value(line,pair(2,1000))).

init(object(order,3),value(pickingStation,3)).
init(object(order,3),value(line,pair(3,1000))).

init(object(order,4),value(pickingStation,4)).
init(object(order,4),value(line,pair(4,1000))).
