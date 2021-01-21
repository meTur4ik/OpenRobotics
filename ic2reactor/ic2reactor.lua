local redstone = require('component').redstone
local inventory = require('component').inventory_controller
local os = require('os')

-- 0 side is down
local rsSide = 0

local invSide = 0

local rs = {
    columns = 9,
    rows = 6
}

function linear2DRead(arr2D, rowSize, i, j)
    if i < 1 or i > rowSize.columns then
        error(string.format('index out of bounds, i = %s', i))
    end
    if j < 1 or j > rowSize.rows then
        error(string.format('index out of bounds, j = %s', j))
    end
    return arr2D[(i - 1) * rowSize.columns + j]
end

function linear2DWrite(arr2D, rowSize, i, j, value)
    if i < 1 or i > rowSize.columns then
        error(string.format('index out of bounds, i = %s', i))
    end
    if j < 1 or j > rowSize.rows then
        error(string.format('index out of bounds, j = %s', j))
    end
    arr2D[(i - 1) * rowSize.columns + j] = value
end

function refreshItems()
    local items = inventory.getAllStacks(invSide).getAll()
    return items
end

function main()
    local items = refreshItems()
    for j=1,rs.rows do
        local lzh1 = linear2DRead(items, rs, 2)
        print('lzh1')
        print(lzh1.name, lzh1.damage)

        local lzh2 = linear2DRead(items, rs, 5)
        print('lzh2')
        print(lzh2.name, lzh2.damage)
        
        local lzh3 = linear2DRead(items, rs, 8)
        print('lzh3')
        print(lzh3.name, lzh3.damage)
    end
end

main()