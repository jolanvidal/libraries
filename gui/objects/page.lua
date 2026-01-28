local Text = require('gui.objects.text')
local Image = require('gui.objects.image')
local Button = require("gui.objects.button")


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
        type = data.type or error('No type given for new page.'),
        name = data.name,
        elements = {},
        activeElements = {},
        x = data.x or p.default.x,
        y = data.y or p.default.y,
        w = data.w or p.default.w,
        h = data.h or p.default.h        
    }
    page.centerX = (page.x + page.w) / 2
    page.centerY = (page.y + page.h) / 2

    return setmetatable(page, p)
end
function p:add(type, data)
    local data = data or {}
    if not type then return error("No type given for new object.")
    elseif not data then return error("No data given for new object.")
    elseif self:elementExists(data.name) then return error("Object named ".. data.name .. "already exists in this page.")
    end

    local obj
    
    if type == "text" then
        obj = Text:new(data)    
    elseif type == "image" then
        obj = Image:new(data)       
    elseif type == "button" then
        obj = Button:new(data)
    end
    self.elements[data.name] = obj
    table.insert(self.activeElements, data.name)
end

function p:remove(name)
    if self:elementExists(name) then
        self.elements[name] = nil

        for i, e in pairs(self.activeElements) do
            if e == name then
                table.remove(self.activeElements, i)
                break
            end
        end
    end
end

function p:modify(elementName, data)
    if self:elementExists(elementName) then
        self.elements[elementName]:modify(data)
    end
end


function p:draw()     
    for _, obj in pairs(self.activeElements) do       
        self.elements[obj]:draw(self)
    end 
end

-- Utilities

function p:elementExists(name)
    if self.elements[name] then return true end return false
end

function p:click(x,y)

    for k, v in pairs(self.elements) do
        if v.type and v.type == 'button' then   
            self.elements[k]:click(x,y)
        end
    end 
end


function p:update(x,y)
    for k, v in pairs(self.elements) do
        if v.type and v.type == 'button' then
            self.elements[k]:update(x, y)
        end
    end 
end

function p:print()
    for k, v in pairs(self.elements) do
        print(k,v)
    end
end




return p