local matrixInfo = require("match3.lib.matrixInfo")
local deepCopy = require("match3.lib.deepCopy")

local matrixs = {}

---- модуль с действиями над матрицами ----
function matrixs.createMatrix(rows, collums, generator)

    local matrix = {}
    for r = 1, rows, 1 do

        matrix[r] = {}
        for c = 1, collums, 1 do
            matrix[r][c] = generator()
        end

    end

    return matrix
end

function matrixs.mix(matrix, generator)

    repeat

        for r = 1, #matrix, 1 do
            for c = 1, #matrix[r] do

                matrix[r][c] = generator()
                
            end
        end

    until not matrixInfo.lines3Exist(matrix) and matrixs.lookForPossibles(matrix) 

end

function matrixs.swap(matrix, from, to)
    matrix[from.row][from.col], matrix[to.row][to.col] = matrix[to.row][to.col], matrix[from.row][from.col]
end

function matrixs.convert3lines(matrix, convert) 

    local virtualmatrix = deepCopy(matrix)

    for r = 2, #matrix - 1, 1 do

        for c = 1, #matrix[r], 1 do
            if matrix[r - 1][c] == matrix[r][c] and matrix[r][c] == matrix[r + 1][c] then 

                convert(virtualmatrix[r - 1][c])
                convert(virtualmatrix[r][c])
                convert(virtualmatrix[r + 1][c])

            end
        end

    end

    for r = 1, #matrix, 1 do

        for c = 2, #matrix[r] - 1, 1 do
            if matrix[r][c - 1] == matrix[r][c] and matrix[r][c] == matrix[r][c + 1] then

                convert(virtualmatrix[r][c - 1])
                convert(virtualmatrix[r][c])
                convert(virtualmatrix[r][c + 1])

            end
        end

    end

    return virtualmatrix

end

function matrixs.apply(matrix, converters)

    for i = 1, #converters, 1 do
        for  r = 1, #matrix, 1 do
            for c = 1, #matrix[r], 1 do

                if converters[i].predicate(matrix[r][c]) then
                    converters[i].action(matrix, r, c)
                end

            end
        end
    end

end

function matrixs.falling(matrix, predicate, generator)    

    for c = #matrix[1], 1, -1 do

        for r = 2, #matrix, 1 do

            if predicate(matrix[r][c]) then

                matrix[r][c] , matrix[r - 1][c] = matrix[r - 1][c], matrix[r][c]        

            end

        end

        if predicate(matrix[1][c]) then
            matrix[1][c] = generator()
        end

    end

end

function matrixs.lookForPossibles(matrix)

    local virtualmatrix = deepCopy(matrix)

    local function try_swap(r, c, dr, dc)

        local from = {row = r, col = c}
        local to = {row = r + dr, col = c + dc}

        matrixs.swap(virtualmatrix, from, to)
        
        if matrixInfo.lines3Exist(virtualmatrix) then
            return true
        else
            matrixs.swap(virtualmatrix, from, to)
            return false
        end
        
    end

    for r = 1, #matrix, 1 do 
        for c = 1, #matrix[r], 1 do
            if try_swap(r, c, 0, 1) or try_swap(r, c, 1, 0) then return true end
        end
    end

    return false
end

return matrixs