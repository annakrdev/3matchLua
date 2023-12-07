local deepCopy = require("match3.lib.deepCopy")
local matrixs = require("match3.lib.matrixs") 
local matrixInfo = require("match3.lib.matrixInfo")

local gemMaker = require("match3.game.Gem")

local rows = 10
local collums = 10
local board = {}
local running = false

---- модуль реализующий игровую логику ----

---- таблица, необходимая для реализации специальных гемов и в целом логики над игровым пространством ----
---- сейчас она ничего не делает, и призвана продемонстрировать структуру -----
local actionsBefore = {

    [1] = {
        predicate = function(gem)
            return gem.type == "usual"
        end,

        action = function(board, row, col)
            -- code
        end
    }

}

---- таблица, необходимая для реализации специальных гемов и в целом логики над игровым пространством ----
---- сейчас она ничего не делает, и призвана продемонстрировать структуру -----
local actionsAfter = {

    [1] = {
        predicate = function(gem)
            return gemMaker.isEmpty(gem)
        end,
        action = function(board, row, col)
            -- code
        end
    }

}

local gameModel = {}

---- инициализация ----
function gameModel.init()
    
    board = matrixs.createMatrix(rows, collums, function() return "" end)   
    matrixs.mix(board, gemMaker.createGem) 

end

---- игровой тик ----
function gameModel.tick(comand)

        
    if matrixInfo.search(board, gemMaker.isEmpty) then

        matrixs.falling(board, gemMaker.isEmpty, gemMaker.createGem)

    elseif matrixInfo.lines3Exist(board) then

        matrixs.apply(board, actionsBefore)
        board = matrixs.convert3lines(board, gemMaker.convertToEmpty)
        matrixs.apply(board, actionsAfter)
            
    else
        running = false
    end

    
end

---- перемешивание игрового поля ----
function gameModel.mix()
    matrixs.mix(board, gemMaker.createGem) 
end

---- пермещение гемов в игровом пространстве ----
function gameModel.move(from, to) 

    matrixs.swap(board, from, to)
    if matrixInfo.lines3Exist(board) then 
        running = true
    else 
        matrixs.swap(board, from, to)
    end

end

---- позволяет узнать есть ли возможные ходы ----
function gameModel.lookForPossibles()
    return matrixs.lookForPossibles(board)
end


---- возрощает игровое пространство для отрисовки ----
function gameModel.dump()
    return deepCopy(board)
end

---- проверка состояния игры ----
function gameModel.isRunning()
    return running
end

return gameModel