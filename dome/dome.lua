local robot = require('robot')

local previousSlot = 1
local activeSlot = 1

function nextSlot()
    while robot.count() < 1
    do
        activeSlot = activeSlot + 1
        if activeSlot > robot.inventorySize()
        then
            print('no more blocks left')
            os.exit()
        end
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

-- precondition

robot.select(activeSlot)

while robot.count() < 1
do
    nextSlot()
end

-- precondition end

-- main
line(5)