local io = require('io')

local function initConfig()
    local function parseString(str, obj)
        print('dorova')
    end

    return {
        readFile = function()
            
        end,

        readStringArray = function()
            parseString({}, {})
        end
    }
end

return iniConfig()