_G.Class = require("class")

require("Button")

_G.buttons = {}
_G.buttonsPressed = {}

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
        local temp = _G.game_list[i]
        _G.game_list[i] = _G.game_list[j]
        _G.game_list[j] = temp
        i = i + 1
        j = j - 1
    end
end

local function check_win()
    return table.concat(_G.game_list) == "123456789"
end


function love.load()
    math.randomseed(os.time())
    
    _G.main_font = love.graphics.newFont('font.ttf', 32)
    _G.game_list = shuffled_list()
    _G.number_trials = 0

    for i = 1, 9 do
        _G.buttons[i] = Button(i, (i-1) * Button.WIDTH + love.graphics.getWidth()/2 - Button.WIDTH/2 * 9, love.graphics.getHeight()/2)
    end
    
    love.graphics.setBackgroundColor(BACKGROUND_COLOR)
    love.graphics.setFont(_G.main_font)

    _G.buttonsPressed = {}
end

function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    end
    
end

function love.mousepressed(x, y, button, istouch, presses)
    for idx, button in ipairs(_G.buttons) do
        if button:clicked(x, y) then
            _G.buttonsPressed[idx] = true
        end
    end
    
end

function love.update(dt)
    if check_win() then    
        for idx, button in ipairs(_G.buttons) do
            if _G.buttonsPressed[idx] then
                reverse(button.value)
                _G.number_trials = _G.number_trials + 1
                break
            end
        end
    end
    
    _G.buttonsPressed = {}
end

function love.draw()
    love.graphics.clear(_G.BACKGROUND_COLOR)
    
    if check_win() then
        -- print("win")
        love.graphics.setColor(_G.WHITE_COLOR)
        love.graphics.printf("You win!!\nNumber of tries:" .. tostring(number_trials), 0, love.graphics.getHeight()/2, love.graphics.getWidth(), "center")
    else
        -- print("not yet")
        love.graphics.setColor(WHITE_COLOR)
        love.graphics.printf(table.concat(_G.game_list, " "), 0, love.graphics.getHeight()/4, love.graphics.getWidth(), "center")    
        for _, button in ipairs(_G.buttons) do
            button:draw()
        end
    end
end