local sleep = require("match3.lib.sleep")
local clear = require("match3.lib.clear")

local timeout = 0.7

local gameRender = {}

--- модуль для отрисовки игры ----
function gameRender.render(board)

    clear()

    print("  0 1 2 3 4 5 6 7 8 9" )
    print("  -------------------" )


    local paint = {
        ["0"] = "\27[m0 \27[0m",
        A = "\27[41mA \27[0m",
        B = "\27[42mB \27[0m",
        C = "\27[43mC \27[0m",
        D = "\27[44mD \27[0m",
        E = "\27[45mE \27[0m",
        F = "\27[46mF \27[0m"
    }

    for r = 1, #board, 1 do

        local line = r - 1 .. "|"
        for c = 1, #board[r], 1 do
            line = line .. paint[board[r][c].color]
        end
        print(line)

    end

    sleep(timeout)

end

function gameRender.endGame()
    clear()
    print("The End" )
end

return gameRender