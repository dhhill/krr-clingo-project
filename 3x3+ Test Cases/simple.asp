init(object(node,1),value(at,pair(1,1))).
init(object(node,2),value(at,pair(2,1))).
init(object(node,3),value(at,pair(3,1))).
init(object(node,5),value(at,pair(1,2))).
init(object(node,6),value(at,pair(2,2))).
init(object(node,7),value(at,pair(3,2))).
init(object(node,9),value(at,pair(1,3))).
init(object(node,10),value(at,pair(2,3))).
init(object(node,11),value(at,pair(3,3))).

init(object(pickingStation,1),value(at,pair(1,1))).
init(object(pickingStation,2),value(at,pair(2,1))).

init(object(robot,1),value(at,pair(1,2))).
init(object(robot,2),value(at,pair(1,3))).
init(object(robot,3),value(at,pair(2,1))).

init(object(shelf,1),value(at,pair(2,1))).
init(object(shelf,2),value(at,pair(2,2))).
init(object(shelf,3),value(at,pair(1,2))).

init(object(product,1),value(on,pair(1,1000))).
init(object(product,2),value(on,pair(2,800))).
init(object(product,2),value(on,pair(3,200))).
%init(object(product,3),value(on,pair(3,3000))).

init(object(order,1),value(pickingStation,1)).
init(object(order,1),value(line,pair(1,500))).
init(object(order,1),value(line,pair(2,250))).
%init(object(order,1),value(line,pair(3,1250))).

init(object(order,2),value(pickingStation,2)).
init(object(order,2),value(line,pair(1,500))).
init(object(order,2),value(line,pair(2,750))).
%init(object(order,2),value(line,pair(3,1750))).
