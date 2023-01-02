
PlayState = Class{__includes = BaseState}

function PlayState:init()
    self:create_shuffled_list()
    self.number_trials = 0
    self.buttons = {}
    self.buttonsPressed = {}
    
    for i = 1, 9 do
        self.buttons[i] = Button(i, (i-1) * BUTTON_WIDTH + love.graphics.getWidth()/2 - BUTTON_WIDTH/2 * 9, love.graphics.getHeight()/2)
    end
end

function PlayState:create_shuffled_list()
    self.game_list = {1,2,3,4,5,6,7,8,9}
    for _ = 1, #self.game_list do
        
        local i = math.random(9)
        local j = math.random(9)
        local temp = self.game_list[i]
        self.game_list[i] = self.game_list[j]
        self.game_list[j] = temp
        i = i + 1
        j = j - 1
    end
end

function PlayState:reverse(number)
    local i = 1
    local j = number
    local k = number%2 == 0 and (number)/2 or (number-1)/2
    while i <= k do
        local temp = self.game_list[i]
        self.game_list[i] = self.game_list[j]
        self.game_list[j] = temp
        i = i + 1
        j = j - 1
    end
end

function PlayState:check_win()
    return table.concat(self.game_list) == "123456789"
end

function PlayState:update(dt)
    local x, y = love.mouse.getPosition()

    for idx, button in ipairs(self.buttons) do
        if love.mouse.mousePressed and button:check_clicked(x, y) then
            self.buttonsPressed[idx] = true
        end
    end

    if not self:check_win() then    
        for idx, button in ipairs(self.buttons) do
            if self.buttonsPressed[idx] then
                self:reverse(button.value)
                self.number_trials = self.number_trials + 1
                break
            end
        end
    end
    
    self.buttonsPressed = {}
    
end

function PlayState:render()
    love.graphics.setColor(_G.WHITE_COLOR)
    if self:check_win() then
        love.graphics.printf("You win!!\nNumber of tries: " .. tostring(self.number_trials), 0, love.graphics.getHeight()/2, love.graphics.getWidth(), "center")
    else
        love.graphics.printf(table.concat(self.game_list, " "), 0, love.graphics.getHeight()/4, love.graphics.getWidth(), "center")    
        for _, button in ipairs(self.buttons) do
            button:draw()
        end
    end
    
end