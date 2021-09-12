local csv = require('csvlib')
local sh = require('shell')


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

end

main(...)