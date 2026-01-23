-- TEST FILE FOR GUI LIBRARY
local gui = require('gui')



local fonts = {    
    headers = love.graphics.newFont(40),
    buttons = love.graphics.newFont(25)
}



function love.load()  
    i = 0
    gui:newPage({name = 'main'})


    gui:addImage("main", {
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
        color = {1,0,0}
    })   
    
    gui:addButton("main", {
        x = 0,
        y = 0,
        w = 100,
        h = 50,
        name = "mainButton",
        text = "btn",
        font = fonts.buttons,
        action = function() error("CLICK", 2) end,
        borderColor = {0,0,1},
        bgColor = {1,1,1},
        fgColor = {0,0,0},
        hfgColor = nil,
        hbgColor = nil
    })

    
    

    --gui:modify("main", "background", {x = 0, y = 0, targetX = 800, targetY = 600})


end

function love.update(dt)   

end

function love.draw()
    gui:show()

 
end




