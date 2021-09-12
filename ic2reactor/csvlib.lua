


function split(str, delimiter)
    local result = { }
    local from  = 1
    local delim_from, delim_to = string.find(str, delimiter, from)
    while delim_from do
      table.insert(result, string.sub(str, from , delim_from-1))
      from  = delim_to + 1
      delim_from, delim_to = string.find(str, delimiter, from)
    end
    table.insert(result, string.sub(str, from))
    return result
  end


function writeStringArray(array)
    local stringArray = {}
    for index, value in ipairs(array) do
        local str = ''
        for index, value in ipairs(value) do
            str = str .. tostring(value) .. ','
        end
        str = str:sub(1, -2)
        table.insert(stringArray, str)
    end
    return stringArray
end

function readStringArray(stringArray)
    local array = {}
    for index, row in ipairs(stringArray) do
        array[index] = {}
        local values = split(row, ',')
        array[index] = values
    end
    return array
end

function readFile(filePath)
    local lines = io.lines(filePath)
    local array = readStringArray(lines)
    return array
end

function writeFile(filePath, array)
    local lines = writeStringArray(array)
    local file = io.open(filePath, "w")
    local ran, errorMessage = pcall(file, lines)
    file:close()

    if not ran then
        error('cannot write file\n' .. errorMessage)
    end
end

function writeLines(file, lines)
    for line in lines do
        file:write(line)
        file:write('\n')
    end
end

return {
    ['readStringArray'] = readStringArray,
    ['writeStringArray'] = writeStringArray,
    ['split'] = split,
    ['readFile'] = readFile,
    ['writeFile'] = writeFile
}