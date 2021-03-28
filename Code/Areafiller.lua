rm Filler
edit Filler
local robot = require("robot")
local term = require("term")
local computer = require("computer")
local component = require("component")
local sides = require("sides")
local keyboard = require("keyboard")

slot = 1;
robot.select(1);
wanteditem = "no";
counter = 0;

local function init()
	item = component.inventory_controller.getStackInInternalSlot(1);
	wanteditem = item.label
end

local function selector()
	::redo::
	counter = 0;
	for i = robot.inventorySize(),1,-1 do
		item = component.inventory_controller.getStackInInternalSlot(i);
		if item ~= nil then
			if item.label == wanteditem then
				robot.select(i);
				counter = item.size;
			end
		end
    end
	if counter == 0 then
		os.sleep(100)
		goto redo
	end
	robot.place()
end

local function place()
	s, r = robot.place()
	if (s == nil) then
		selector()
	end
end

local function backorturn()
	back, discard = robot.back();
	if (back) then
		place();
	else
		robot.turnLeft()
	end
end

init()
while (true) do
backorturn();
end
