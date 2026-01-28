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
        type = data.type or error('No type given for new button.'),
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

function b:click(x,y)   
    if self.isHover then
        self:action()
    end
end
function b:update(x,y)
    if self:isHovered(x,y) then
        self.isHover = true
    else
        self.isHover = false    
    end
end

function b:draw()
   
    local middleX = (self.x+self.w)/2
    local middleY = (self.y+self.h)/2
    --Text
    love.graphics.setFont(self.font)
    local font = love.graphics.getFont()
 
    if self.isHover then
        love.graphics.setColor(self.hbgColor)
        love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)
        --Border
        love.graphics.setColor(self.borderColor)
        love.graphics.rectangle("line", self.x, self.y, self.w, self.h)

        love.graphics.setColor(self.hfgColor)
        love.graphics.print(self.text, middleX - font:getWidth(self.text) / 2, middleY - font:getHeight(self.text)/2)

    else 
        -- Rectangle
        love.graphics.setColor(self.bgColor)    
        love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)

        --Border
        love.graphics.setColor(self.borderColor)
        love.graphics.rectangle("line", self.x, self.y, self.w, self.h)

        love.graphics.setColor(self.fgColor)
        love.graphics.print(self.text, middleX - font:getWidth(self.text) / 2, middleY - font:getHeight(self.text)/2)

 


    
    end   
    

    love.graphics.setColor(1,1,1)
end

-- Utilities

function b:isHovered(x,y)
    return x > self.x and x < self.x + self.w
        and y > self.y and y < self.y + self.h
end


return b