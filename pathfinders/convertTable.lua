function convert3DListToGraph(list3D)
    local number = 1
    local len1 = #list3D
    local len2 = #list3D[1]
    local len3 = #list3D[2]
    for i = 1, len1 do
        for j = 1, len2 do
            for k = 1, len3 do
                local var = list3D[i][j][k]
                list3D[i][j][k] = {var, number}
                number = number + 1
            end
        end
    end
    -- supposing [i][j][k][1] - value, [i][j][k][2] - number
    local result = {}
    number = 1
    for i = 1, len1 do
        for j = 1, len2 do
            for k = 1, len3 do
                result[number] = {}
                if i - 1 >= 1 then
                    table.insert(result[number], list3D[i - 1][j][k][2])
                end
                if i + 1 <= #list3D then
                    table.insert(result[number], list3D[i + 1][j][k][2])
                end
                if j - 1 >= 1 then
                    table.insert(result[number], list3D[i][j - 1][k][2])
                end
                if j + 1 <= #list3D[1] then
                    table.insert(result[number], list3D[i][j + 1][k][2])
                end
                if k - 1 >= 1 then
                    table.insert(result[number], list3D[i][j][k - 1][2])
                end
                if k + 1 <= #list3D[2] then
                    table.insert(result[number], list3D[i][j][k + 1][2])
                end
                number = number + 1
            end
        end
    end
    return result
end

function main()
    -- local arr = {}
    -- arr[1] = {}
    -- arr[1][1] = {322, 228, 1337}
    -- arr[1][2] = {322, 228, 1337}
    -- arr[1][3] = {322, 228, 1337}
    -- arr[2] = {}
    -- arr[2][1] = {322, 228, 1337}
    -- arr[2][2] = {322, 228, 1337}
    -- arr[2][3] = {322, 228, 1337}
    -- arr[3] = {}
    -- arr[3][1] = {322, 228, 1337}
    -- arr[3][2] = {322, 228, 1337}
    -- arr[3][3] = {322, 228, 1337}

    -- local arr2 = {
    --     [1] = {
    --         [1] = {
    --             {322, 228, 1337}
    --         },
    --         [2] = {
    --             {322, 228, 1337}
    --         },
    --         [3] = {
    --             {322, 228, 1337}
    --         }
    --     },
    --     [2] = {
    --         [1] = {
    --             {322, 228, 1337}
    --         },
    --         [2] = {
    --             {322, 228, 1337}
    --         },
    --         [3] = {
    --             {322, 228, 1337}
    --         }
    --     },
    --     [3] = {
    --         [1] = {
    --             {322, 228, 1337}
    --         },
    --         [2] = {
    --             {322, 228, 1337}
    --         },
    --         [3] = {
    --             {322, 228, 1337}
    --         }
    --     }
    -- }
    local arr3 = {
        {
            {
                {322, 228, 1337}
            },
            {
                {322, 228, 1337}
            },
            {
                {322, 228, 1337}
            }
        },
        {
            {
                {322, 228, 1337}
            },
            {
                {322, 228, 1337}
            },
            {
                {322, 228, 1337}
            }
        },
        {
            {
                {322, 228, 1337}
            },
            {
                {322, 228, 1337}
            },
            {
                {322, 228, 1337}
            }
        }
    }
    local arr4 = {}
    for i = 1, 48 do
        arr4[i] = {}
        for j=1, 48 do
            arr4[i][j] = {}
            for k=1, 64 do
                arr4[i][j][k] = k
            end
        end
    end
    --print(arr[1][1][1])
     print(#arr4)
    -- print(#arr[1])
    -- print(#arr[1][1])
end

main()