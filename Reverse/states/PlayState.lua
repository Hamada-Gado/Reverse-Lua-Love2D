-- constants
BACKGROUND_COLOR = {255/255, 202/255, 123/255}
NUMBERS_LIST_COLOR = {1, 1, 1}

PlayState = Class{__includes = BaseState}

function PlayState:init()
    self:create_shuffled_list()
    self:create_buttons()
    self.number_trials = 0
    self.buttonsPressed = {}
    NUMBERS_LIST_FONT = love.graphics.newFont("font.ttf", math.floor((love.graphics.getWidth() - 11) / 9) - 10)
    
end

function PlayState:reset()
    self:create_shuffled_list()
    self.number_trials = 0
    self.buttonsPressed = {}
end

function PlayState:create_shuffled_list()
    self.numbers_list = {1,2,3,4,5,6,7,8,9}
    local i, j
    for _ = 1, #self.numbers_list do
        i = math.random(9)
        j = math.random(9)
        self.numbers_list[i], self.numbers_list[j] = self.numbers_list[j], self.numbers_list[i]
    end
end

function PlayState:create_buttons()
    self.buttons = {}

    local width = math.floor((love.graphics.getWidth() - BUTTON_PADDING_X*4) / 3)
    local height = math.floor((love.graphics.getHeight()/2 - BUTTON_PADDING_Y*4) / 4)
    
    if width < MIN_BUTTON_WIDTH then width = MIN_BUTTON_WIDTH
    elseif width > MAX_BUTTON_WIDTH then width = MAX_BUTTON_WIDTH end 
    
    if height < MIN_BUTTON_HEIGHT then height = MIN_BUTTON_HEIGHT
    elseif height > MAX_BUTTON_HEIGHT then height = MAX_BUTTON_HEIGHT end

    local j = 1
    local x, y = 0, love.graphics.getHeight()/2 + height*(j-1) + BUTTON_PADDING_Y*(j-1)
    for i = 1, 9 do
        if i%3 == 1 then 
            x = (love.graphics.getWidth() - 3*width) / 2 - BUTTON_PADDING_X
        elseif i%3 == 2 then
            x = (love.graphics.getWidth() - width) / 2
        else
            x = (love.graphics.getWidth() + width) / 2 + BUTTON_PADDING_X
        end
    
        self.buttons[i] = Button(i, x, y, width, height)
        if i % 3 == 0 then
            j = j + 1
            y = (love.graphics.getHeight()/2 + height*(j-1) + BUTTON_PADDING_Y*(j-1))
        end
    end

    self.buttons[10] = Button(0, (love.graphics.getWidth() - width)/2, y, width, height)
end

function PlayState:reverse(number)
    local i = 1
    local j = number
    local k = number%2 == 0 and (number)/2 or (number-1)/2
    while i <= k do
        self.numbers_list[i], self.numbers_list[j] = self.numbers_list[j], self.numbers_list[i]
        i = i + 1
        j = j - 1
    end
end

function PlayState:check_win()
    return table.concat(self.numbers_list) == "123456789"
end

function PlayState:update(dt)
    local x, y = love.mouse.getPosition()
    
    if not self:check_win() then    
        for idx, button in ipairs(self.buttons) do
            if love.mouse.mousePressed and button:check_clicked(x, y) then
                self.buttonsPressed[idx] = true
            end
        end
            
        for idx, button in ipairs(self.buttons) do
            if self.buttonsPressed[idx] then
                if button.value == 0 then
                    love.event.quit()
                else
                    self:reverse(button.value)
                    self.number_trials = self.number_trials + 1
                end
            end
        end
    else
        if love.mouse.mousePressed then
            self:reset()
        end
    end
    
    self.buttonsPressed = {}
    
end

function PlayState:render()
    love.graphics.setBackgroundColor(BACKGROUND_COLOR)
    love.graphics.setColor(NUMBERS_LIST_COLOR)
    if self:check_win() then
        love.graphics.printf("You win!!\nNumber of tries: " .. tostring(self.number_trials), 0, love.graphics.getHeight()/2, love.graphics.getWidth(), "center")
    else
        love.graphics.setFont(NUMBERS_LIST_FONT)
        love.graphics.printf(" " .. table.concat(self.numbers_list, " ") .. " ", 0, love.graphics.getHeight()/3, love.graphics.getWidth(), "center")
        for _, button in ipairs(self.buttons) do
            button:draw()
        end
    end
    
end