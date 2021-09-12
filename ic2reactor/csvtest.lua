local csv = require('csvlib')
local sh = require('shell')

function getLzhPositions(config)
    local positions = {}

    for i = 1, #config, 1 do
        for j = 1, #config[1], 1 do
            local position = {}
            if config[i][j] == 'h' then
                position.i = i
                position.j = j
                table.insert(positions, position)
            end
        end
    end
end

function main(...)
    local args, opts = sh.parse(...)

    for k, v in pairs(args) do
        print(k, v)
    end

    for k, v in pairs(opts) do
        print(k, v)
    end

    if not opts['schema'] then
        error('no schema. use --schema=/path/to/schema parameter')
    end

    local config = csv.readFile(opts['schema'])
    -- for i = 1, #config, 1 do
    --     for j = 1, #config[1], 1 do
    --         print(config[i][j])
    --     end
    -- end
    local lzh = getLzhPositions(config)
    for pos in lzh do
        print(pos.i, pos.j)
    end

end

main(...)