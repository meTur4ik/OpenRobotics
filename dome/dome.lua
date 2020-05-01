local robot = require('robot')
local computer = require('computer')
local component = require('component')
local gen = component.generator

local previousSlot = 2
local activeSlot = 2
local fuelSlot = 1
local fuelAmount = 1


function refill()
    local energyLevel = computer.energy() / computer.maxEnergy() * 100
    if energy < 80
    then
        previousSlot = robot.select(fuelSlot)
        gen.insert(fuelAmount)
        previousSlot = robot.select(previousSlot)
    end
end


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
    refill()
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
    line(2)
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
    local cycles = length - 1

    for i = 0, cycles, 1
    do
        line(length)
        if i < cycles
        then
            if i % 2 == 1
            then
                corner(not clockwise)
            else
                corner(clockwise)
            end
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


function cube(length, clockwise)
    -- length: number
    -- clockwise: boolean

    for i=1,length, 1
    do
        squareSurface(length, clockwise)
        robot.swingUp()
        local moved, reason = robot.up()

        while not moved
        do
            os.sleep(2)
            robot.swingUp()
            moved, reason = robot.up()
        end
    end
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

