local b = {}

b.__index = b

b.default = {
    name = nil,
    x = 0,
    y = 0,
    w = 0,
    h = 0,
    bgColor = {1,1,1},
    fgColor = {0,0,0},
    hbgColor = {0,0,0},
    hfgColor = {1,1,1},
    action = function() end,
    text = "Button"
}

function b:new(data) 

    local button = {
        name = data.name or "Name",
        text = data.text or "Button",
        x = data.x or 0,
        y = data.y or 0,
        w = data.w or 0,
        h = data.h or 0,
        bgColor = data.bgColor or {1,1,1},
        fgColor = data.fgColor or {0,0,0},
        hbgColor = data.hbgColor or {0,0,0},
        hfgColor = data.hfgColor or {1,1,1},
        borderColor = data.borderColor or {1,0,0},
        action = data.action or function() end,
        font = data.font or love.graphics.getFont(),
        isHover = false

    }

    return setmetatable(button, b)
end

function b:draw()
   
    local middleX = (self.x+self.w)/2
    local middleY = (self.y+self.h)/2
 
    
    -- Rectangle
    love.graphics.setColor(self.bgColor)    
    love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)

    --Border
    love.graphics.setColor(self.borderColor)
    love.graphics.rectangle("line", self.x, self.y, self.w, self.h)

    --Text
    love.graphics.setFont(self.font)

    local font = love.graphics.getFont()
    love.graphics.setColor(self.fgColor)
    love.graphics.print(self.text, middleX - font:getWidth(self.text) / 2, middleY - font:getHeight(self.text)/2)

    love.graphics.setColor(1,1,1)
end


return b