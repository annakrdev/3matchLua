local syntaxCorrect = require("match3.lib.syntaxCorrect")

local split = require("match3.lib.split")

local gameInput = {}

---- модуль для считывания команд и их валидации вводимых параметров ----
function gameInput.input()

    while true do

        local line = io.read()
        if line == "mix" then 
        
            local answer = {}
            answer.comand = "mix"

            return answer
        
        end

        if line == "q" then 
        
            local answer = {}
            answer.comand = "q"

            return answer
        
        end

        if syntaxCorrect.moveIsCorrect(line) then 

            local allowedValues = {[1] = true, [2] = true, [3] = true, [4] = true, [5] = true, [6] = true, [7] = true, [8] = true, [9] = true, [10] = true}

            local answer = {}
            answer.comand = "move"

            local tokens = split(line, " ")

            answer.from = {
                row = tonumber(tokens[2]) + 1,
                col = tonumber(tokens[3]) + 1
            }

            answer.to = {
                row = tokens[4] == "u" and answer.from.row - 1 or (tokens[4] == "d" and answer.from.row + 1 or answer.from.row),
                col = tokens[4] == "l" and answer.from.col - 1 or (tokens[4] == "r" and answer.from.col + 1 or answer.from.col)
            }

            if allowedValues[answer.to.row] and allowedValues[answer.to.col] then
                return answer
            end

        end

        print("> is not correct" )

    end

end

return gameInput