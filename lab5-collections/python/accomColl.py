# -*- coding: utf-8 -*-

import copy

## define accommodation-related classes:

class Room:
    def __init__(self, kind, size): # constructor
        self.kind = kind
        self.size = size
    def __repr__(self): 
        return f"{self.kind} {self.size[0]}cm x {self.size[1]}cm"


class House:
    def __init__(self, street, houseNum, floors, roomsPerFloor): # constructor
        self.street = street
        self.houseNum = houseNum
        self.floors = floors
        self.roomsPerFloor = roomsPerFloor
        self.check()

    def __repr__(self):  # formatting (like toString())
        result = f"{self.floors} storey house"
        result += f" at {self.houseNum} {self.street} {formatListOfLists(self.roomsPerFloor)}"
        return result

    def check(self):
        # perform dynamic type checking of all components:
        assert isinstance(self.street, str)
        assert isinstance(self.houseNum, int) and self.houseNum > 0
        assert isinstance(self.floors, int) and self.floors > 0
        assert isinstance(self.roomsPerFloor, list) and self.floors == len(self.roomsPerFloor)
        for floorRooms in self.roomsPerFloor:
            assert isinstance(floorRooms, list) and all(isinstance(room, Room) for room in floorRooms)

def formatList(list):
    return map(str, list)

def formatListOfLists(list):
    return map(formatList, list)

class Flat:
    def __init__(self, street, houseNum, floor, rooms): # constructor
        self.street = street
        self.houseNum = houseNum
        self.floor = floor
        self.rooms = rooms
        self.check()

    def __repr__(self):  # formatting (like toString())
        result = f"{floorTh(self.floor)} floor flat"
        result += f" at {self.houseNum} {self.street} {formatList(self.rooms)}"
        return result

    def check(self):
        # perform dynamic type checking of all components:
        assert isinstance(self.street, str)
        assert isinstance(self.houseNum, int) and self.houseNum > 0
        assert isinstance(self.floor, int) and self.floor > 0
        assert isinstance(self.rooms, list) and all(isinstance(room, Room) for room in self.rooms)

def floorTh(n):
    lastDigit = n % 10
    if n==0:
        return "ground"
    elif lastDigit == 1:
        return "%dst" % n
    elif lastDigit == 2:
        return "%dnd" % n
    elif lastDigit == 3:
        return "%drd" % n
    else:
        return "%dth" % n

## create some instances of accommodation:

myHouse1 = House (
    "Golden Avenue", 111, 3, [
        [Room("Kitchen",(450, 310)), Room("Launge",(550,450))],
        [Room("Bathroom",(200,180)), Room("Bedroom",(450,390)), Room("Bedroom",(400,320))],
        [Room("Bathroom",(180,180)), Room("Bedroom",(410,370)), Room("Bedroom",(380,310))],
])

myHouse2 = copy.deepcopy(myHouse1)
myHouse2.houseNum = 112

myFlat1 = Flat(
    "Silver Street", 81, 1,
    [Room("Kitchen",(350, 280)), Room("Launge",(400,320)), Room("Bedroom",(320,270))]
)

myFlat2 = copy.deepcopy(myFlat1)
myFlat2.floor = 7

# a heterogeneous list:
things = [111, myHouse1, [1,2], myHouse2, "a string", myFlat1, myFlat2]

allAccommodation_0 = [accom for accom in things if type(accom) in (House, Flat)] 
print("All accom 0:")
print(*[f" {accom}" for accom in allAccommodation_0], sep="\n")
print()

allAccommodation = [myHouse1, myHouse2, myFlat1, myFlat2]

print("All accommodation:")
for accom in allAccommodation:
    print(" ", accom)

# extract streets
streets = [accom.street for accom in allAccommodation]
print("\nAccommodation streets:")
for street in streets:
    print(" ", street)

# empty line
print()

flats = [accom for accom in allAccommodation if isinstance(accom, Flat)]

# extract floor counts from houses:
houseFloorsSequence = [accom.floors for accom in allAccommodation if isinstance(accom, House)]

print("Floor counts for houses: ")
for houseFloors in houseFloorsSequence:
    print(" ",houseFloors)

# empty line
print()

# heterogeneous dictionary:
accommodation2score = { myHouse1 : 2.0, myFlat1 : "dunno" }
print(accommodation2score)
print("myHouse1 score: ", accommodation2score[ myHouse1 ]) # like array lookup

accommodation2score [ myHouse1 ] = 2.5 # like array update
print(accommodation2score)
