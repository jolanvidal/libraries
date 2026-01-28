-- TEST FILE FOR GUI LIBRARY
local gui = require('gui')



local fonts = {    
    headers = love.graphics.newFont(40),
    buttons = love.graphics.newFont(25)
}



function love.load()  
    i = 0
    gui:newPage({name = 'main', type = 'page'})


    gui:addImage("main", {
        type = "img",
        img = love.graphics.newImage("gui/img/noix.png"),
        x = 100,
        y = 100,
        -- rotation = 0,
        --targetW = 800,     
        --targetH = 600,
        name = "background"
    })

    gui:addText("main", {
        font = fonts.headers,
        x = 60,
        y = 20,
        content = "Hello world",
        name = "mainText",
        --isCentered = false,
        isCenterX = true,
        --isCenterY = false
        color = {1,0,0},
        type = 'text'
    })   
    
        gui:addButton("main", {
        x = 0,
        y = 0,
        w = 100,
        h = 50,
        name = "mainButton",
        text = "btn",
        font = fonts.buttons,
        action = function() gui:modify("main", "background", {x = 0, y = 0, targetX = 800, targetY = 600}) end,
        borderColor = {1,0,1},
        bgColor = {1,1,1},
        fgColor = {0.577,0.123,0.123},
        hfgColor = nil,
        hbgColor = nil,
        type = 'button'
    })

    


end

function love.update(dt)   
    local x, y = love.mouse.getPosition()
    gui:update(x,y)
end

function love.draw()
    gui:show()
end

function love.mousepressed(x,y)
    gui:click(x,y)
end