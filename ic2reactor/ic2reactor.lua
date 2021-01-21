local redstone = require('component').redstone
local inventory = require('component').inventory_controller
local os = require('os')

-- 0 side is down
local rsSide = 0

local invSide = 0

local percentage = 20

local arraySize = {
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
    return 100 * (item.maxDamage - item.damage) / item.maxDamage
end

-- damage percentage
function anyLZHLowerThan(percent)
    if percent > 100 or percent < 0 then
        error('percent should be between 0 and 100')
    end

    local isLower = false
    local items = refreshItems()
    print('items state for current scan')
    for i=1, arraySize.rows do
        local lzh1 = linear2DRead(items, arraySize, i, 2)
        local percent1 = damagePercentage(lzh1)
        if percent1 < percent then
            isLower = true
        end

        local lzh2 = linear2DRead(items, arraySize, i, 5)
        local percent2 = damagePercentage(lzh2)
        if percent2 < percent then
            isLower = true
        end

        local lzh3 = linear2DRead(items, arraySize, i, 8)
        local percent3 = damagePercentage(lzh3)
        if percent3 < percent then
            isLower = true
        end
        print(string.format("row %s:", i),
            string.format( "%s%%", percent1),
            string.format( "%s%%", percent2),
            string.format( "%s%%", percent3)
        )

        if isLower then
            return true
        end
    end

    return false
end

function main()
    local items = refreshItems()
    if not anyLZHLowerThan(percentage) then
        redstoneOn()
        print('redstone is on')
    end

    while true do
        os.sleep(1)
        if anyLZHLowerThan(percentage) then
            redstoneOff()
            print('redstone is off')
            break
        end
    end

    redstoneOff()
end

main()