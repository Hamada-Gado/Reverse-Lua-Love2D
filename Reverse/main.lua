Class = require("class")

require("Button")

local main_font
local game_list = {}
local buttons = {}
local buttonsPressed = {}

local function shuffled_list()
    local list = {1,2,3,4,5,6,7,8,9}
    for _ = 1, #list do
        
        local i = math.random(9)
        local j = math.random(9)
        local temp = list[i]
        list[i] = list[j]
        list[j] = temp
        i = i + 1
        j = j - 1
    end
    return list
end

local function reverse(number)
    local i = 1
    local j = number
    local k = number%2 == 0 and (number)/2 or (number-1)/2
    while i <= k do
        local temp = game_list[i]
        game_list[i] = game_list[j]
        game_list[j] = temp
        i = i + 1
        j = j - 1
    end
end


function love.load()
    math.random(os.time())
    
    main_font = love.graphics.newFont('font.ttf', 32)
    game_list = shuffled_list()

    for i = 1, 9 do
        buttons[i] = Button(i, (i-1) * Button.WIDTH + love.graphics.getWidth()/2 - Button.WIDTH/2 * 9, love.graphics.getHeight()/2)
    end
    
    love.graphics.setBackgroundColor(BACKGROUND_COLOR)
    love.graphics.setFont(main_font)

    buttonsPressed = {}
end

function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    end
    
end

function love.mousepressed(x, y, button, istouch, presses)
    for idx, button in ipairs(buttons) do
        if button:clicked(x, y) then
            buttonsPressed[idx] = true
        end
    end
    
end

function love.update(dt)
    for idx, button in ipairs(buttons) do
        if buttonsPressed[idx] then
            reverse(button.value)
            break
        end
    end
    
    buttonsPressed = {}
end

function love.draw()
    love.graphics.setColor(WHITE_COLOR)
    love.graphics.printf(table.concat(game_list, " "), 0, love.graphics.getHeight()/4, love.graphics.getWidth(), "center")    
    for _, button in ipairs(buttons) do
        button:draw()
    end
end