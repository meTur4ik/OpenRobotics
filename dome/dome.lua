local robot = require('robot')
local computer = require('computer')
local math = require('math')
local component = require('component')
local gen = component.generator

local previousSlot = 2
local activeSlot = 2
local fuelSlot = 1
local fuelAmount = 5


function refill()
    local energyLevel = computer.energy() / computer.maxEnergy() * 100
    if energyLevel < 80 and gen.count() < 1
    then
        previousSlot = robot.select(fuelSlot)
        gen.insert(fuelAmount)
        previousSlot = robot.select(activeSlot)
        os.sleep(1)
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

    for i = 1, length - 1
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


function rectangularSurface(length, width, clockwise)
    -- width: number, right/left from robot current facing
    -- length: number, forward from robot current facing
    -- clockwise: boolean

    local cycles = width - 1

    for i = 0, cycles
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
    line(width)
    turn(clockwise)
end


function brick(length, width, heigth, clockwise)
    -- width: number, right/left from robot current facing
    -- length: number, forward from robot current facing
    -- heigth: number
    -- clockwise: boolean

    for i = 1, heigth
    do
        rectangularSurface(length, width, clockwise)
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


function moveToStartingPoint(width, clockwise)
    -- width: number
    line(2)
    turn(not clockwise)
    local blocksTilStart = math.floor(width / 2) + 1
    line(blocksTilStart)
    turn(clockwise)
end


-- main

function main()
    precondition()
    local length = 19
    local width = 45
    local heigth = 9
    local clockwise = true
    moveToStartingPoint(width, clockwise)
    brick(length, width, heigth, clockwise)
    --rectangularSurface(5, true)
    --squarePerimeter(5, true)
end

main()

