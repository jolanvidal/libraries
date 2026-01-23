-- TEST FILE FOR GUI LIBRARY
local gui = require('gui')



local fonts = {    
    headers = love.graphics.newFont(40)
}


function love.load()
    gui:newPage({name = 'background'})
    --[[
    gui:addRect('background', {
        type='rect',
        mode = 'fill',
        color = {1,0,0},
        x = 0,
        y = 0,
        w = 100,
        h = 100
    })
    ]]

    gui:addText('background', {
        font = fonts.headers,
        x = 100, y = 100, content = "Hello world!",
        name = 'HW'
    })

end

function love.update(dt)
end

function love.draw()
    --gui:show()

     gui.pages["background"]:draw()
end




