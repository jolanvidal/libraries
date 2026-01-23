local Page = require("gui.objects.page")




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

-- Delete page
function g:delete(pageName)

    if g.pageExists(pageName) then
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

-- Add Text
function g:addText(pageName, data)

    if not pageName or not data then
        return error("GUI Error: No name nor data passed as arguments.", 2)
    elseif self:pageExists(pageName) then        
        self.pages[pageName]:add("text", data)
    else
        error("GUI Error: Page " .. pageName .. " doesn\'t exists", 2)
    end
end
-- Add Image
function g:addImage(pageName, data) 
    if not pageName or not data then
        return error("GUI Error: Page name or data not passed as arguments for new image.", 2)
    elseif self:pageExists(pageName) then
        self.pages[pageName]:add("image", data)    
    end        
end

-- Add Button
function g:addButton(pageName, data)
    if not pageName or not data then
        return error("GUI Error: Page name or data not passed as arguments for new button.", 2)
    elseif self:pageExists(pageName) then
        self.pages[pageName]:add("button", data)
    end
end


-- Remove elements
function g:remove(pageName, name)
    if not pageName or not name then
        return error("GUI Error: Page name or name not passed.", 2)
    elseif not g:pageExists(pageName) then       
        return error("GUI Error: Page " .. pageName .. "doesn't exists.")
    else        
        self.pages[pageName]:remove(name)
    end

end


-- Modify element from page
function g:modify(pageName, elementName, data)

    if not pageName or not elementName or not data then
        return error("GUI Error: Missing 'Page name, element name or data' isn't passed.", 2)
    elseif self:pageExists(pageName) then
        self.pages[pageName]:modify(elementName, data)
    end
end


-- Delete a whole page
function g:delete(pageName) 
    if g:pageExists(pageName) then
        self.pages[pageName].elements = nil
        self.pages[pageName] = nil
        for i, n in pairs(self.activePages) do
            if n == pageName then
                table.remove(self.activePages, i)
            end
        end
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