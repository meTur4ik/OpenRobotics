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


function dot()
    nextSlot()
    robot.placeDown()
end


function line(length)
    -- length: number

    dot()

    for i = 1, length - 1, 1
    do
        robot.swing()
        local moved, reason = robot.forward()
        while not moved
        do
            os.sleep(2)
            robot.swing()
            moved, reason = robot.forward()
        end
        dot()
    end
end


function turn(clockwise)
    -- clockwise: boolean
    if clockwise
    then
        robot.turnRight()
    else
        robot.turnLeft()
    end
end


function reverseTurn(clockwise)
    turn(not clockwise)
end

function corner(clockwise)
    turn(clockwise)
    line(1)
    turn(clockwise)
end

function squarePerimeter(length, clockwise)
    -- length: number
    -- clockwise: boolean

    for i = 1, 4, 1
    do
        line(length)
        turn(clockwise)
    end
end


function squareSurface(length, clockwise)
    -- length: number
    -- clockwise: boolean

    for i = 0, length, 1
    do
        line(length)
        if i % 2 == 1
        then
            if i < length
            then
                corner(not clockwise)
            end
        else
            corner(clockwise)
        end
    end

    if length % 2 == 1
    then
        robot.turnAround()
        line(length)
    end
    
    turn(clockwise)
    line(length)
    turn(clockwise)
end


-- precondition

function precondition()
    robot.select(activeSlot)

    while robot.count() < 1
    do
        nextSlot()
    end
end


-- main

function main()
    precondition()
    squareSurface(5, true)
    --squarePerimeter(5, true)
end

main()

