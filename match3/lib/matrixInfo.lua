local deepCopy = require("match3.lib.deepCopy")

---- модуль, позваляющий узнать информацию о матрице ----
local matrixInfo = {}

function matrixInfo.lines3Exist(matrix)
    
    for r = 2, #matrix - 1, 1 do

        for c = 1, #matrix[r], 1 do
            if matrix[r - 1][c] == matrix[r][c] and matrix[r][c] == matrix[r + 1][c] then return true end
        end

    end

    for r = 1, #matrix, 1 do

        for c = 2, #matrix[r] - 1, 1 do
            if matrix[r][c - 1] == matrix[r][c] and matrix[r][c] == matrix[r][c + 1] then return true end
        end

    end

    return false
end

function matrixInfo.search(matrix, predicate)

    for r = 1, #matrix, 1 do
        
        for c = 1, #matrix[r], 1 do
            if predicate(matrix[r][c]) then return true end
        end

    end

    return false
end

return matrixInfo