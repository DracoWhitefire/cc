local tArgs = { ... }
if #tArgs ~= 3 then
    print("gebruik: dig [vooruit] [rechts] [omlaag]")
    return
end

local forwardSize = tonumber(tArgs[1])
local rightwardSize = tonumber(tArgs[2])
local downwardSize = tonumber(tArgs[3])
print("Ik begin bij het vakje voor me, linksboven aan de kubus, ga " .. forwardSize .. " vooruit, " .. rightwardSize .. " naar rechts en " .. downwardSize .. " omlaag.")
print("Doorgaan? [J/n]")
local response = io.read()
if response == "j"
or response == "J"
or response == ""
then
    print("Daar gaan we...")
else
    print("Ok, tot ziens!")
    return
end


local function refuel()
    local selected = turtle.getSelectedSlot()
    for i = 1, 16 do
        turtle.select(i)
        if turtle.refuel(0) then
            if turtle.getFuelLevel() < turtle.getFuelLimit() then
                turtle.refuel()
            end
        end
    end
    turtle.select(selected)
end


local function digForward(distance)
    for i = 1, distance do
        if turtle.detect() then
            turtle.dig()
        end
        turtle.forward()
    end
end

local function digLayer(forwardSize, rightwardSize)
    local forward = forwardSize - 1
    local rightward = rightwardSize - 1
    for i = 1, forwardSize do
        turtle.turnRight()
        digForward(rightward)
        for j = 1, rightward do
            turtle.back()
        end
        turtle.turnLeft()

        if i < forwardSize then
            digForward(1)
        end
    end
    for k = 1, forward do
        turtle.back()
    end
end


refuel()

if turtle.detect() then
    turtle.dig()
end
turtle.forward()

for i = 1, downwardSize do
    digLayer(forwardSize, rightwardSize)
    if i < downwardSize then
        if turtle.detectDown() then
            turtle.digDown()
        end
        turtle.down()
    end
    refuel()
end
for i = 1, downwardSize - 1 do
    turtle.up()
end
turtle.back()
