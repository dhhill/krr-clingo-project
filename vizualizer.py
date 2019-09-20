import re

init = """
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

init(object(pickingStation,1),value(at,pair(1,3))).
init(object(pickingStation,2),value(at,pair(3,1))).

init(object(robot,2),value(at,pair(2,2))).

init(object(shelf,4),value(at,pair(4,4))).

init(object(product,2),value(on,pair(4,1))).

init(object(order,2),value(pickingStation,2)).
init(object(order,2),value(line,pair(2,1))). 

"""

output = """
occurs(object(robot,2),deliver(2,2,1),10) occurs(object(robot,2),pickup,5) occurs(object(robot,2),move(-1,0),6) occurs(object(robot,2),move(-1,0),7) occurs(object(robot,2),move(-1,0),8) occurs(object(robot,2),move(0,-1),9) occurs(object(robot,2),move(0,1),3) occurs(object(robot,2),move(0,1),4) occurs(object(robot,2),move(1,0),1) occurs(object(robot,2),move(1,0),2)
"""


class Robot:
    def __init__(self, x, y):
        self.x = x
        self.y = y
        self.carrying = -1
    def __repr__(self):
        return 'Robot at ' + str(self.x) + ',' + str(self.y)
    
    def move(self, params):
        self.x += params[0]
        self.y += params[1]
        if self.carrying != -1:
            shelf_dict[self.carrying].x += params[0]
            shelf_dict[self.carrying].y += params[1]

    def pickup(self):
        if self.carrying != -1:
            print('trying to pickup while carrying')
        for s in shelf_dict:
            if shelf_dict[s].x == self.x and shelf_dict[s].y == self.y:
                self.carrying = s
        if self.carrying == -1:
            print('trying to pickup nothing')
    
    def putdown(self):
        if self.carrying == -1:
            print('putting down nothing')
        self.carrying = -1
    
    def deliver(self):
        if self.carrying == -1:
            print('delivering without holding shelf')
        if not any((picking_station_dict[h].x == self.x and picking_station_dict[h].y == self.y) for h in picking_station_dict):
            print('delivering to bad location')

class Shelf:
    def __init__(self, x, y):
        self.x = x
        self.y = y
    def __repr__(self):
        return 'Shelf at ' + str(self.x) + ',' + str(self.y)

class Highway:
    def __init__(self, x, y):
        self.x = x
        self.y = y
    def __repr__(self):
        return 'Highway at ' + str(self.x) + ',' + str(self.y)

class Picking_station:
    def __init__(self, x, y):
        self.x = x
        self.y = y
    def __repr__(self):
        return 'Picking station at ' + str(self.x) + ',' + str(self.y)

##################################################
# Parse
##################################################
# output
action_list = output.split()
organized_actions = {}
max_t = 0
for action_string in action_list:
    action_string = action_string + ';'
    timestep = int(re.search('\d*(?=\)\;)',action_string).group(0))
    robot_id = int(re.search('\d*(?=\)\,)',action_string).group(0))
    action = re.search('(?<=\)\,)\w\w',action_string).group(0)
    action_params = [int(x) for x in re.findall('-?\d*',action_string) if x != ''][1:-1]
    if timestep not in organized_actions:
        organized_actions[timestep] = []
    organized_actions[timestep].append({
        'robot_id':robot_id,
        'action':action,
        'action_params':action_params
    })
    max_t = max(max_t,timestep)

# init
init_list = init.split()
highway_dict = {}
robot_dict = {}
shelf_dict = {}
picking_station_dict = {}
max_x = 0
max_y = 0

for init_string in init_list:
    params = [int(x) for x in re.findall('-?\d*',init_string) if x != '']
    location = False
    if 'highway' in init_string:
        location = True
        highway_dict[params[0]] = Highway(params[1], params[2])
    if 'robot' in init_string:
        location = True
        robot_dict[params[0]] = Robot(params[1], params[2])
    if 'shelf' in init_string:
        location = True
        shelf_dict[params[0]] = Shelf(params[1], params[2])
    if 'pickingStation' in init_string and len(params) == 3:
        picking_station_dict[params[0]] = Picking_station(params[1], params[2])

    if location:
        max_x = max(params[-2],max_x)
        max_y = max(params[-1],max_y)

##################################################
# Visualize
##################################################
def print_map():
    print('--'*max_x)
    for y in range(1,max_y+1):
        for x in range(1,max_x+1):
            if any((robot_dict[b].x == x and robot_dict[b].y == y) for b in robot_dict):
                print('R', end='')
                if any((shelf_dict[s].x == x and shelf_dict[s].y == y) for s in shelf_dict):
                    print('S', end='')
                elif any((highway_dict[h].x == x and highway_dict[h].y == y) for h in highway_dict):
                    print('H', end='')
                elif any((picking_station_dict[h].x == x and picking_station_dict[h].y == y) for h in picking_station_dict):
                    print('P', end='')
                else:
                    print(' ', end='')
            elif any((shelf_dict[s].x == x and shelf_dict[s].y == y) for s in shelf_dict):
                print('S ', end='')
            elif any((highway_dict[h].x == x and highway_dict[h].y == y) for h in highway_dict):
                print('H ', end='')
            elif any((picking_station_dict[h].x == x and picking_station_dict[h].y == y) for h in picking_station_dict):
                print('P ', end='')
            else:
                print('  ', end='')
        print('|')
    print('--'*max_x)

print_map()
for timestep in range(max_t):
    for action in organized_actions[timestep+1]:
        print(action)
        if action['action'] == 'mo':
            robot_dict[action['robot_id']].move(action['action_params'])
        elif action['action'] == 'pi':
            robot_dict[action['robot_id']].pickup()
        elif action['action'] == 'pu':
            robot_dict[action['robot_id']].putdown()
        elif action['action'] == 'de':
            robot_dict[action['robot_id']].deliver()
    print_map()
