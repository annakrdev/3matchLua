local gameModel = require("match3.game.gameModel")
local gameInit = require("match3.game.gameInput")
local gameRender = require("match3.game.gameRender")

local gameController = {}
local running = true


--- модуль, управляющим "жизненым циклом" игры
function gameController.start()
    
    gameModel.init()
    local board = gameModel.dump()
    gameRender.render(board)

    while running do

        if not gameModel.isRunning() then

            local answer = gameInit.input()

            if answer.comand == "mix" then gameModel.mix() end
            if answer.comand == "q" then running = false end
            if answer.comand == "move" then gameModel.move(answer.from, answer.to) end
            
        end
        
        gameModel.tick()
        if not gameModel.lookForPossibles() then gameModel.mix() end
        
        local board = gameModel.dump()
        gameRender.render(board)
    end
    gameRender.endGame()

end

return gameController