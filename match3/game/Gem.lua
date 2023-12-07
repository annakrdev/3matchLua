local gemMaker = {}

local allowedColors = {"A", "B", "C", "D", "E", "F"}
local emptyColor = "0"
local emptyType = "empty"

local metatable = {}

--- модуль для управления гемами ----
function metatable.__eq(g1, g2)
    return g1.color == g2.color
end

function gemMaker.createGem(type, color) 
    local gem = {

        type = type or "usual",
        color = color or allowedColors[math.random(1, #allowedColors)]

    }
    setmetatable(gem, metatable)
    return gem
end

function gemMaker.getEmptyColor()
    return emptyColor
end

function gemMaker.getEmptyType()
    return emptyType
end

function gemMaker.convertToEmpty(gem)

    gem.type = emptyType
    gem.color = emptyColor

end

function gemMaker.isEmpty(gem)
    return gem.type == emptyType
end


return gemMaker