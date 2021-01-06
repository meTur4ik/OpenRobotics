local util = require('util')

function dfs(graph, start, visited)
    visited = visited or nil
    if visited == nil then
        visited = {}
    end
    visited[start] = true
    local visitedArray = util.keysToSet(visited)
    local g1 = util.setDiff(graph[start], visitedArray)
    
    for _, next in ipairs(g1) do
        dfs(graph, next, visited)
    end
    local result = util.keysToSet(visited)
    return result
end

return dfs
