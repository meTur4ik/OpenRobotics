function readStringArray(arr)
    local o = {}
    local lastSection = nil

    function parseStr(str)
        local key, value = str:match '^(%a+%d*)%s*=%s*([^;]+);*$' -- key=value
        local section = str:match '^%[%s*(%w+)%s*%];*$' -- [section]

        if section then
            o[section] = {}
            lastSection = section
        elseif key and value then
            o[lastSection][key] = value
        end
    end

    for count = 1, #arr do
        parseStr(arr[count])
    end

    return o
end

function writeStringArray(obj)
    local strs = {}
    
    for key, value in pairs(obj) do
        table.insert(strs, '[' .. tostring(key) .. ']')
        for key, value in pairs(value) do
            table.insert(strs, tostring(key) .. '=' .. tostring(value))
        end
    end

    return strs
end

function toFile(obj, filename)
    local strs = writeStringArray(obj)
    local file = io.open(filename, "w")
    for i = 1, #strs do
        file:write(strs[i]..'\n')
        --print(strs[i])
    end
    file:flush()
    file:close()
end

function fromFile(filename)
    local file = io.open(filename)
    local strs = {}

    repeat
        local str = file:read()
        if str then
            table.insert(strs, str)
        end
    until not str

    file:close()
    local obj = readStringArray(strs)

    return obj
end

return {
    ['deserialize'] = readStringArray,
    ['serialize'] = writeStringArray,
    ['toFile'] = toFile,
    ['fromFile'] = fromFile
}

--[[
local s = {'[sec1]', 'f = bar-*./'}

local o = readStringArray(s)

print(o.sec1.f)
]]