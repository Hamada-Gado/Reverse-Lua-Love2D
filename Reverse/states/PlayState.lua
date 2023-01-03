PlayState = Class{__includes = BaseState}

-- constants

local NUMBERS_LIST_COLOR = {1, 1, 1}

local MAX_NUMBERS_LIST_FONT = math.floor(MAX_SCREEN_WIDTH / 10)

function PlayState:init()
    self:create_shuffled_list()
    self:create_buttons()
    self.number_trials = 0
    NUMBERS_LIST_FONT = love.graphics.newFont("font.ttf", math.min( math.floor((love.graphics.getWidth()) / 10), MAX_NUMBERS_LIST_FONT))
    
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

    self.numbers_list = {2,1,3,4,5,6,7,8,9}
end

function PlayState:create_buttons()
    self.buttons = {}

    local width     = math.floor( (love.graphics.getWidth() - BUTTON_PADDING_X*4) / 3)
    local height    = math.floor( (love.graphics.getHeight()/2 - BUTTON_PADDING_Y*4) / 4)
    
    local j = 1
    local x, y = 0, love.graphics.getHeight()/3 + height*(j-1) + BUTTON_PADDING_Y*(j-1)
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
            y = (love.graphics.getHeight()/3 + height*(j-1) + BUTTON_PADDING_Y*(j-1))
        end
    end

    self.buttons[10] = Button(0, (love.graphics.getWidth() - width)/2, y, width, height)
    self.buttons[11] = Button("BACK", (BUTTON_PADDING_X*1.5), love.graphics.getHeight()*0.9, width*2.5, height)
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
    
    if self:check_win() then
       _G.StateMachine:change('score', self.number_trials)
       love.mouse.mousePressed = false
       return
    end

    if love.mouse.mousePressed then
        for _, button in ipairs(self.buttons) do
            button.clicked = button:check_clicked(love.mouse.mousePressed.x, love.mouse.mousePressed.y)
        end

        love.mouse.mousePressed = false
    end

    if love.mouse.mouseReleased then
        for _, button in ipairs(self.buttons) do
            if button:check_clicked(love.mouse.mouseReleased.x, love.mouse.mouseReleased.y) then
                if button.value == "BACK" then
                    _G.StateMachine:change("title")
                elseif button.value == 0 then
                    self:reset()
                else
                    self:reverse(button.value)
                    self.number_trials = self.number_trials + 1
                end
            end

            button.clicked = false
        end

        love.mouse.mouseReleased = false
    end

    
end

function PlayState:render()
    love.graphics.setBackgroundColor(BACKGROUND_COLOR)
    love.graphics.setColor(NUMBERS_LIST_COLOR)
    love.graphics.setFont(NUMBERS_LIST_FONT)
    love.graphics.printf(" " .. table.concat(self.numbers_list, " ") .. " ", -10, love.graphics.getHeight()/6, love.graphics.getWidth(), "center") -- -10 is a number found by trial to make the numbers list look exactly centered
    for _, button in ipairs(self.buttons) do
        button:draw()
    end
    
end