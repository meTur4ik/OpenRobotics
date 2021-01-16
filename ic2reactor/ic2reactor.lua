local redstone = require('component').redstone
local os = require('os')

local rsSide = 0

function main()
    -- 0 side is down
    redstone.setOutput(rsSide, 15)
    os.sleep(40)
    redstone.setOutput(rsSide, 0)
end

main()