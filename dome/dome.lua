local robot = require('robot')

local previousSlot = 1
local activeSlot = 1

-- precondition

robot.select(activeSlot)

while robot.count() < 1
do
    nextSlot()
end

-- precondition end

function nextSlot()
    if robot.count() > 0
    then
       return nil
    end

    activeSlot = activeSlot + 1
    previousSlot = robot.select(activeSlot)
end


function line(length: number)
    for i = 0, length, 1
    do
        robot.swing()
        robot.forward()
        local placed, _ = robot.placeDown()
        nextSlot()
    end
end

-- main
line(5)