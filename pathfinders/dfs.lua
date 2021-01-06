local util = require('util')

function dfs(graph, start, visited)
    visited = visited or nil
    if visited == nil then
        visited = {}
    end
    table.insert(visited, start)
    
    local g1 = util.setDiff(graph[start], visited)
    
    for _, next in ipairs(g1) do
        dfs(graph, next, visited)
    end
    return visited
end

return dfs
