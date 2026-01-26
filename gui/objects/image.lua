local i = {}

i.__index = i

function i:new(data)
    local data = data or {}
    local img = {
        type = data.type or error('No type given for new image.'),
        img = data.img,
        name = data.name,
        x = data.x,
        y = data.y,
        rotation = data.rotation or nil
    }

    if data.targetW and data.targetH then
        local dimX, dimY = data.img:getDimensions()
        img.scaleX = data.targetW / dimX
        img.scaleY = data.targetH / dimY
    else
        img.scaleX = nil
        img.scaleY = nil
    end


    return setmetatable(img, i)
end

function i:draw()
    love.graphics.draw(self.img, self.x, self.y, self.rotation, self.scaleX, self.scaleY)
end

function i:modify(data)   
    self.img = data.img or self.img
    self.x = data.x or self.x
    self.y = data.y or self.y
    self.rotation = data.rotation or self.rotation
    self.targetW = data.targetW or self.targetW
    self.targetH = data.targetH or self.targetH

    if data.targetW and data.targetH then
        local dimX, dimY = data.img:getDimensions()
        self.scaleX = self.targetW / dimX
        self.scaleY = self.targetH / dimY
    end    
end


return i