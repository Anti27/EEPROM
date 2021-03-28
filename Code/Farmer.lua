local robot = require("robot")
local term = require("term")
local computer = require("computer")
local component = require("component")
local sides = require("sides")
local keyboard = require("keyboard")

robot.select(1);
lastExp = 0;
maxbatt = 100000;

file = io.open("quant", "r");
io.input(file);
treeFeller = io.read();
io.close(file);

local function printStuff()
	local double expdouble = component.experience.level();
	exp = string.format("%.4f",expdouble);
	local double diff = expdouble - lastExp;
	felled = string.format("%.0f",treeFeller);
	lastExp = expdouble;
	diffExp = string.format("%.8f",diff);
	term.clear();
	print("I have " .. exp .. " Exp.\nThats " .. diffExp .. " more than last time.\nI planted " .. felled .. " Crops.");
	component.sign.setValue("I have\n" .. exp .. " Exp.\nI planted\n" .. felled .. " Crops.");
	file = io.open("quant", "wb");
	io.output(file);
	io.write(treeFeller);
	io.close(file);
end

local function errorStuff(err)
	print(err);
end

local function updateStuff()
	error = xpcall(printStuff, errorStuff);
	while (error == false) do
		os.sleep(1);
		error = xpcall(printStuff, errorStuff);
	end
end

local function checkCorrect()
	x, y, z = component.navigation.getPosition();
	if ( x == -7.5 and y == 65.5 and z == -24.5) then
		result = true;
	else
		result = false;
	end
	return result;
end

local function sucky()
	component.tractor_beam.suck()
	while (component.tractor_beam.suck()) do
		component.tractor_beam.suck();
		end
end

local function gotoX(arg)
	x, y, z = component.navigation.getPosition();
	if ( x >= arg ) then
		while ( x > arg ) do
			while ( component.navigation.getFacing() ~= 4 ) do
				robot.turnLeft();
			end
			robot.forward();
			x, y, z = component.navigation.getPosition();
		end
	else
		while ( x < arg ) do
			while ( component.navigation.getFacing() ~= 5 ) do
				robot.turnLeft();
			end
			robot.forward();
			x, y, z = component.navigation.getPosition();
		end
	end	
end

local function gotoY(arg)
	x, y, z = component.navigation.getPosition();
	if ( y >= arg ) then
		while ( y > arg ) do
			robot.down();
			x, y, z = component.navigation.getPosition();
		end
	else
		while ( y < arg ) do
			robot.up();
			x, y, z = component.navigation.getPosition();
		end
	end	
end

local function gotoZ(arg)
	x, y, z = component.navigation.getPosition();
	if ( z >= arg ) then
		while ( z > arg ) do
			while ( component.navigation.getFacing() ~= 2 ) do
				robot.turnLeft();
			end
			robot.forward();
			x, y, z = component.navigation.getPosition();
		end
	else
		while ( z < arg ) do
			while ( component.navigation.getFacing() ~= 3 ) do
				robot.turnLeft();
			end
			robot.forward();
			x, y, z = component.navigation.getPosition();
		end
	end	
end

local function breaktoX(arg)
	x, y, z = component.navigation.getPosition();
	if ( x >= arg ) then
		while ( x > arg ) do
			while ( component.navigation.getFacing() ~= 4 ) do
				robot.turnLeft();
			end
			robot.swing()
			sucky()
			robot.forward();
			x, y, z = component.navigation.getPosition();
		end
	else
		while ( x < arg ) do
			while ( component.navigation.getFacing() ~= 5 ) do
				robot.turnLeft();
			end
			robot.swing()
			sucky()
			robot.forward();
			x, y, z = component.navigation.getPosition();
		end
	end	
end

local function breaktoY(arg)
	x, y, z = component.navigation.getPosition();
	if ( y >= arg ) then
		while ( y > arg ) do
			robot.swingDown()
			robot.down();
			x, y, z = component.navigation.getPosition();
		end
	else
		while ( y < arg ) do
			robot.swingUp()
			robot.up();
			x, y, z = component.navigation.getPosition();
		end
	end	
end

local function breaktoZ(arg)
	x, y, z = component.navigation.getPosition();
	if ( z >= arg ) then
		while ( z > arg ) do
			while ( component.navigation.getFacing() ~= 2 ) do
				robot.turnLeft();
			end
			robot.swing()
			sucky()
			robot.forward();
			x, y, z = component.navigation.getPosition();
		end
	else
		while ( z < arg ) do
			while ( component.navigation.getFacing() ~= 3 ) do
				robot.turnLeft();
			end
			robot.swing()
			sucky()
			robot.forward();
			x, y, z = component.navigation.getPosition();
		end
	end	
end

local function farmtoZ(arg)
	x, y, z = component.navigation.getPosition();
	if ( z >= arg ) then
		while ( z > arg ) do
			while ( component.navigation.getFacing() ~= 2 ) do
				robot.turnLeft();
			end
			treeFeller = treeFeller + 1 ;
			robot.useDown()
			sucky()
			robot.forward();
			x, y, z = component.navigation.getPosition();
		end
	else
		while ( z < arg ) do
			while ( component.navigation.getFacing() ~= 3 ) do
				robot.turnLeft();
			end
			treeFeller = treeFeller + 1 ;
			robot.useDown()
			sucky()
			robot.forward();
			x, y, z = component.navigation.getPosition();
		end
	end	
end

local function init()
	local correct = checkCorrect();
	if (correct) then
		os.sleep(1)
	else
		gotoY(67.5);
		gotoX(-7.5);
		gotoZ(-24.5);
		gotoY(65.5);
	end
	while ( component.navigation.getFacing() ~= 4 ) do
		robot.turnLeft();
	end
end

local function dumpme()
	for i = 1, robot.inventorySize() do
        robot.select(i)
        robot.drop()
    end
	robot.select(1);
	while computer.energy() < maxbatt do
		os.sleep(1);
    end
end

local function updatierer()
	gotoY(66.5);
	gotoX(-22.5);
	gotoY(65.5);
	updateStuff();
	gotoY(66.5);
	gotoX(-7.5);
	gotoY(65.5);
end

local function gotomelon()
	gotoZ(-26.5);
	gotoX(-23.5);
end

while true do
	init();
	dumpme();
	updatierer();
	gotomelon();
	breaktoZ(-62.5)
	breaktoY(66.5)
	breaktoX(-19.5)
	breaktoY(65.5)
	breaktoZ(-28.5)
	breaktoY(66.5)
	breaktoX(-18.5)
	farmtoZ(-62.5)
	breaktoX(-16.5)
	farmtoZ(-28.5)
	breaktoX(-15.5)
	farmtoZ(-62.5)
	breaktoX(-13.5)
	farmtoZ(-28.5)
	breaktoX(-12.5)
	farmtoZ(-62.5)
	breaktoX(-10.5)
	farmtoZ(-28.5)
	breaktoX(-9.5)
	farmtoZ(-62.5)
	breaktoX(-7.5)
	farmtoZ(-28.5)
	breaktoX(-6.5)
	farmtoZ(-62.5)
	breaktoX(-4.5)
	farmtoZ(-28.5)
end
