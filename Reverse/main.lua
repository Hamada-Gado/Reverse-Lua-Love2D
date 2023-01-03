BACKGROUND_COLOR = {255/255, 202/255, 123/255}

MAX_SCREEN_WIDTH   = 730
MAX_SCREEN_HEIGHT  = 1400

Class = require("class")

require("Button")

require("StateMachine")
require("states/BaseState")
require("states/TitleState")
require("states/InstructionState")
require("states/PlayState")
require("states/ScoreState")

function love.load()
    love.window.setFullscreen(true)
    love.window.setMode(math.min(MAX_SCREEN_WIDTH, love.graphics.getWidth()), math.min(MAX_SCREEN_HEIGHT, love.graphics.getHeight()))
    
    BUTTON_WIDTH    = math.floor( (love.graphics.getWidth() - BUTTON_PADDING_X*3))
    BUTTON_HEIGHT   = math.floor( (love.graphics.getHeight()/2 - BUTTON_PADDING_Y*4) / 4)

    math.randomseed(os.time())

    _G.main_font = love.graphics.newFont('font.ttf', 32)
    
    _G.StateMachine = StateMachine {
        ['title'] = function() return TitleState() end,
        ['instruction'] = function() return InstructionState() end,
        ['play'] = function() return PlayState() end,
        ['score'] = function() return ScoreState() end,
    }

    _G.StateMachine:change('title')
    

    love.mouse.mousePressed = false
    love.mouse.mouseReleased = false
end

function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    end
    
end

function love.mousepressed(x, y, button, istouch, presses)
    love.mouse.mousePressed = {x = x, y = y, button = button, istouch = istouch, presses = presses}   
end


function  love.mousereleased(x, y, button, istouch, presses)
    love.mouse.mouseReleased = {x = x, y = y, button = button, istouch = istouch, presses = presses}
end

function love.update(dt)
    _G.StateMachine:update(dt)

    love.mouse.mousePressed = false
end

function love.draw()
    love.graphics.clear(BACKGROUND_COLOR)
    _G.StateMachine:render()   
end