local t = {}

t.__index =t



function t:new(data)

    local data = data or {}

    local txt = {
        name = data.name or '',
        font = data.font or love.graphics.getFont() ,
        x = data.x,
        y = data.y,
        content = data.content
    }
    return setmetatable(txt, t)

end

return t