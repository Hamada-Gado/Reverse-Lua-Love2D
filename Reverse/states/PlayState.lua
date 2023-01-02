
PlayState = Class{__includes = BaseState}

function PlayState:init()
    self:create_shuffled_list()
    self:create_buttons()
    self.number_trials = 0
    self.buttonsPressed = {}
    
    
end

function PlayState:create_shuffled_list()
    self.game_list = {1,2,3,4,5,6,7,8,9}
    local i, j
    for _ = 1, #self.game_list do
        i = math.random(9)
        j = math.random(9)
        self.game_list[i], self.game_list[j] = self.game_list[j], self.game_list[i]
    end
end

function PlayState:create_buttons()
    self.buttons = {}

    local size = math.floor((love.graphics.getWidth() - BUTTON_PADDING_X*3) / 3)
    if size < MIN_BUTTON_SIZE then size = MIN_BUTTON_SIZE
    elseif size > MAX_BUTTON_SIZE then size = MAX_BUTTON_SIZE end 

    local j = 1
    local x, y = 0, love.graphics.getHeight()/3 + size*(j+1) + BUTTON_PADDING_Y*(j-1)
    for i = 1, 9 do
        if i%3 == 1 then 
            x = (love.graphics.getWidth() - 3*size) / 2 - BUTTON_PADDING_X
        elseif i%3 == 2 then
            x = (love.graphics.getWidth() - size) / 2
        else
            x = (love.graphics.getWidth() + size) / 2 + BUTTON_PADDING_X
        end
    
        self.buttons[i] = Button(i, x, y, size)
        if i % 3 == 0 then
            j = j + 1
            y = love.graphics.getHeight()/3 + size*(j+1) + BUTTON_PADDING_Y*(j-1)
        end
    end

    self.buttons[0] = Button(0, (love.graphics.getWidth() - size)/2, y, size)
end

function PlayState:reverse(number)
    local i = 1
    local j = number
    local k = number%2 == 0 and (number)/2 or (number-1)/2
    while i <= k do
        self.game_list[i], self.game_list[j] = self.game_list[j], self.game_list[i]
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
        love.graphics.printf(table.concat(self.game_list, " "), 0, love.graphics.getHeight()/3, love.graphics.getWidth(), "center")    
        for _, button in ipairs(self.buttons) do
            button:draw()
        end
    end
    
end