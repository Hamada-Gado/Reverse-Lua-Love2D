Class = require("class")

require("Button")

require("StateMachine")
require('states/BaseState')
require('states/PlayState')

-- constants
_G.BACKGROUND_COLOR = {255/255, 202/255, 123/255}
_G.WHITE_COLOR = {1, 1, 1}

function love.load()
    math.randomseed(os.time())
    
    _G.main_font = love.graphics.newFont('font.ttf', 32)
    
    _G.StateMachine = StateMachine {
        -- ['title'] = function() return TitleScreenState() end,
        ['play'] = function() return PlayState() end,
        -- ['score'] = function() return ScoreState() end,
    }

    _G.StateMachine:change('play')
    
    love.graphics.setBackgroundColor(BACKGROUND_COLOR)
    love.graphics.setFont(main_font)

    love.mouse.mousePressed = false
end

function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    end
    
end

function love.mousepressed(x, y, button, istouch, presses)
    love.mouse.mousePressed = true    
end

function love.update(dt)
    _G.StateMachine:update(dt)

    love.mouse.mousePressed = false
end

function love.draw()
    love.graphics.clear(BACKGROUND_COLOR)
    _G.StateMachine:render()
    
end