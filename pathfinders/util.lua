function deepCopy(obj, seen)
    -- Handle non-tables and previously-seen tables.
    if type(obj) ~= 'table' then return obj end
    if seen and seen[obj] then return seen[obj] end

    -- New table; mark it as seen an copy recursively.
    local s = seen or {}
    local res = {}
    s[obj] = res
    for k, v in next, obj do res[deepCopy(k, s)] = deepCopy(v, s) end
    return setmetatable(res, getmetatable(obj))
end

function setDiff(set1, set2)
    local result = deepCopy(set1)
    local i = 1
    while i <= #result do
        for j=1, #set2 do
            if result[i] == set2[j] then
                table.remove(result, i)
                i = i - 1
            end
        end
        i = i + 1
    end
    return result
end

function indexOf(list, arg)
    for i, val in ipairs(list) do
        if val == arg then
            return i
        end
    end
end

return {
    deepCopy = deepCopy,
    setDiff = setDiff
}