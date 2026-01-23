local Page = require("gui.objects.page")
local Text = require('gui.objects.text')


local g = {
    pages = {},
    activePages = {},
}
function g:init()
    self.pages = {}
    self.activePages = {}
    
end

-- About Page
function g:newPage(data, replace)
    if not data or #data == 0 == nil then return error('GUI Error: No data passed for new page', 2)          
    elseif data.name == nil then return error('GUI Error: No name passed for new page', 2)        
    end

    if not self:pageExists(data.name) or replace then
        local page = Page:new(data)
        self.pages[data.name] = page        
        table.insert(self.activePages, page.name)
    else
        return error('GUI Error: Page "' .. data.name .. '" already exists.', 2)
    end
end

function g:removePage(pageName)

    if self.pageExists(pageName) then
        self.pages[pageName].elements = nil
        self.pages[pageName] = nil
        
        for i, n in ipairs(self.activePages) do
            if n == pageName then
                table.remove(self.activePages, i)
            end
        end
    else 
        return error('GUI Error: Page "' .. pageName .. '" doesn\'t exists.', 2)
    end
end

-- About Text
function g:addText(pageName, data)
    if not pageName or not data then
        return error("GUI Error: No name nor data passed as arguments.", 2)
    elseif self:pageExists(pageName) then
        self.pages[pageName]:addText(data.name, data)
    else
        error("GUI Error: Page " .. pageName .. " doesn\'t exists", 2)
    end
end


-- Visualize
function g:show()
    for _, n in ipairs(self.activePages) do
        self.pages[n]:draw()     
    end
end


-- Utilities
function g:pageExists(pageName)
    if not self.pages[pageName] then
        return false
    end
    return true
end

return g