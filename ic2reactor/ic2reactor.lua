local redstone = require('component').redstone
local inventory = require('component').inventory_controller
local os = require('os')

-- 0 side is down
local rsSide = 0

local invSide = 0

local rs = {
    rows = 6,
    columns = 9
}

-- i is for row position, j is for column position
function linear2DRead(arr2D, sizes, i, j)
    if j < 1 or j > sizes.columns then
        error(string.format('index out of bounds, i = %s', j))
    end
    if i < 1 or i > sizes.rows then
        error(string.format('index out of bounds, j = %s', i))
    end
    return arr2D[(i - 1) * sizes.columns + j]
end

-- i is for row position, j is for column position
function linear2DWrite(arr2D, sizes, i, j, value)
    if j < 1 or j > sizes.columns then
        error(string.format('index out of bounds, i = %s', j))
    end
    if i < 1 or i > sizes.rows then
        error(string.format('index out of bounds, j = %s', i))
    end
    arr2D[(i - 1) * sizes.columns + j] = value
end

function refreshItems()
    local items = inventory.getAllStacks(invSide).getAll()
    return items
end

function redstoneOn()
    redstone.setOutput(rsSide, 15)
end

function redstoneOff()
    redstone.setOutput(rsSide, 0)
end

function damagePercentage(item)
    return (item.maxDamage - item.damage) / item.maxDamage
end

-- damage percentage
function anyLZHLowerThan(percent)
    if percent > 100 or percent < 0 then
        error('percent should be between 0 and 100')
    end

    local items = refreshItems()
    for i=1, rs.rows do
        local lzh1 = linear2DRead(items, rs, i, 2)
        if damagePercentage(lzh1) < percent then
            return true
        end
        print('lzh1', lzh1.name, lzh1.damage)

        local lzh2 = linear2DRead(items, rs, i, 5)
        if damagePercentage(lzh2) < percent then
            return true
        end
        print('lzh2', lzh2.name, lzh2.damage)

        local lzh3 = linear2DRead(items, rs, i, 8)
        if damagePercentage(lzh3) < percent then
            return true
        end
        print('lzh3', lzh3.name, lzh3.damage)
    end

    return false
end

function main()
    local items = refreshItems()
    print(damagePercentage(linear2DRead(items, rs, 1, 2)))
end

main()