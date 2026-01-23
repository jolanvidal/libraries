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
        name = data.name or b.default.name,
        text = data.text or b.default.text,
        x = data.x or b.default.x,
        y = data.y or b.default.y,
        w = data.w or b.default.w,
        h = data.h or b.default.h,
        bgColor = data.bgColor or b.default.bgColor,
        fgColor = data.fgColor or b.default.fgColor,
        hbgColor = data.hbgColor or b.default.hbgColor,
        hfgColor = data.hfgColor or b.default.hfgColor,
        action = data.action or b.default.action,
        font = data.font or love.graphics.getFont(),
        isHover = false

    }

    return setmetatable(button, b)
end

function b:draw()
    print(self.text)
    love.graphics.setColor(self.bgColor)
    error(self.x..self.x..self.w..self.h, 2)
    love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)
    love.graphics.setColor(1,1,1)
end


return b