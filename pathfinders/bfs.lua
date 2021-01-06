local Queue = require('queue')
local util = require('util')

function bfs(graph, root)
    local visited = {}
    local queue = Queue:fromList({root})
    --queue:pushRight(root)
    while not queue:empty() do
        local vertex = queue:popLeft()

        for _, neighbour in ipairs(graph[vertex]) do
            if not visited[neighbour] then
                visited[neighbour] = true
                queue:pushRight(neighbour)
            end
        end
    end
    local result = keysToSet(visited)
    return result
end

return bfs