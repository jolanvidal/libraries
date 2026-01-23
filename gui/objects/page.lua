local Text = require('gui.objects.text')


local p = {}

p.__index = p


-- Default value for new()
p.default = {
    x = 0,
    y = 0,
    w = love.graphics.getWidth(),
    h = love.graphics.getHeight(),
    elements = {},
    activeElements = {},
}
p.default.centerX = p.default.w / 2
p.default.centerY = p.default.h / 2


function p:new(data)
    local data = data or {}

    local page = {
        name = data.name,
        elements = {},
        activeElements = {},
        x = data.x or p.default.x,
        y = data.y or p.default.y,
        w = data.w or p.default.w,
        h = data.h or p.default.h,
        centerX = p.default.centerX,
        centerY = p.default.centerY,
    }
    return setmetatable(page, p)
end

function p:addText(data, replace)
    if not data or #data == 0 then return error('GUI Error: No data passed for new element', 2)       
    elseif data.name == nil then return error('GUI Error: No name passed for new element', 2)        
    end

    if not self:elementExists(data.name) or replace then
        local element = Text:new(data)
        self.elements[data.name] = element
        table.insert(self.activeElements, element.name)
    else
        return error("GUI Error: Element '"..element.name.."' already exists.")
    end
end


function p:draw() 
    for _, obj in pairs(self.activeElements) do
        self.elements[obj.name]:draw()
    end 
end

-- Utilities

function p:elementExists(name)
    if self.elements[name] then return true end return false
end

function p:print()
    for k, v in pairs(self.elements) do
        print(k,v)
    end
end



return p