local redstone = require('component').redstone
local inventory = require('component').inventory_controller
local os = require('os')

-- 0 side is down
local rsSide = 0

local invSide = 0

rs = {
    i = 9,
    j = 6
}

function linear2DRead(arr2D, rowSize, i, j)
    if i < 1 then
        error(string.format('index out of bounds, i = %s', i))
    end
    if j < 1 or j > rowSize.j then
        error(string.format('index out of bounds, j = %s', j))
    end
    return arr2D[(i - 1) * rowSize.i + j]
end

function linear2DWrite(arr2D, rowSize, i, j, value)
    if i < 1 or i > rowSize.i then
        error(string.format('index out of bounds, i = %s', i))
    end
    if j < 1 or j > rowSize.j then
        error(string.format('index out of bounds, j = %s', j))
    end
    arr2D[(i - 1) * rowSize.i + j] = value
end

function refreshItems()
    local items = inventory.getAllStacks(invSide).getAll()
    return items
end

function main()
    local items = inventory
    redstone.setOutput(rsSide, 15)
    os.sleep(40)
    redstone.setOutput(rsSide, 0)
end

main()