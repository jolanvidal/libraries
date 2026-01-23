local t = {}

t.__index =t


t.default = {
    name = "default",
    font = love.graphics.getFont(),
    x = 100,
    y = 100,
    content = "Hello world!",
    color = {1,1,1},
    no = false,
    yes = true
}

function t:new(data)
    local txt = {
        name = data.name or t.default.name,
        font = data.font or t.default.font ,
        x = data.x or t.default.x,
        y = data.y or t.default.y,
        content = data.content or t.default.content,
        color = data.color or t.default.color,
        isCentered = data.isCentered or t.default.no,
        isCenterX = data.isCenterX or t.default.no,
        isCenterY = data.isCenterY or t.default.no

    }
    return setmetatable(txt, t)
end



function t:draw(page)
    love.graphics.setFont(self.font)
    love.graphics.setColor(self.color)

    local font = love.graphics.getFont()
    if self.isCentered then
        love.graphics.print(self.content, page.centerX - font:getWidth(self.content) / 2 , page.centerY - font:getHeight() / 2)
    elseif self.isCenterX then
        love.graphics.print(self.content, page.centerX - font:getWidth(self.content) / 2 , self.y)
    elseif self.isCenterY then
        love.graphics.print(self.content, self.x, page.centerY - font:getHeight() / 2)
    
    else
        love.graphics.print(self.content, self.x, self.y)       
    end
    
    love.graphics.setColor(1,1,1)


   
end

function t:modify(data)   
    if data.content then
        self.content = data.content
    end
    if data.color then
        self.color = data.color        
    end
    
end

return t