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
    while robot.count() < 1
    do
        activeSlot = activeSlot + 1
        previousSlot = robot.select(activeSlot)
    end
end


function line(length)
    for i = 1, length, 1
    do
        robot.swing()
        local moved, reason = robot.forward()
        while not moved
        do
            os.sleep(2)
            robot.swing()
            moved, reason = robot.forward()
        end
        local placed, _ = robot.placeDown()
        nextSlot()
    end
end

-- main
line(5)