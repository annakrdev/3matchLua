local split = require("match3.lib.split")
local syntaxCorrect = {}

---- модуль для проверки синтаксиса ----
function syntaxCorrect.moveIsCorrect(comand)

    local allowedSymbols = {l = true, u = true, d = true, r = true}
    local allowedNumber = {["0"] = true, ["1"] = true, ["2"] = true, ["3"] = true, ["4"] = true, ["5"] = true, ["6"] = true, ["7"] = true, ["8"] = true, ["9"] = true }

    if type(comand) ~= "string" then return false end
    if #comand ~= 7 then return false end

    if not string.find(comand, " " ) then return false end
    local tokens = split(comand, " ")

    if #tokens ~= 4 then return false end
    if tokens[1] ~= "m" then return false end
    if not allowedNumber[tokens[2]] then return false end
    if not allowedNumber[tokens[3]] then return false end
    if not allowedSymbols[tokens[4]] then return false end

    return true
end

return syntaxCorrect