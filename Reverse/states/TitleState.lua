TitleState = Class{__includes= BaseState}

-- constants
local TITLE_FONT

function TitleState:init()

    TITLE_FONT      = love.graphics.newFont("font.ttf", love.graphics.getWidth()/5)

    self:create_buttons()
    
end

function TitleState:create_buttons()

    local y = love.graphics.getHeight()/3
    
    local width     = math.floor( (love.graphics.getWidth() - BUTTON_PADDING_X*3))
    local height    = math.floor( (love.graphics.getHeight()/2 - BUTTON_PADDING_Y*4) / 4)

    self.buttons = {

        ["PLAY"]            = Button("PLAY", (love.graphics.getWidth() - width)/2, y, width, height),
        ["HISTORY"]         = Button("HISTORY", (love.graphics.getWidth() - width)/2, y + (height + BUTTON_PADDING_Y), width, height),
        ["INSTRUCTIONS"]    = Button("INSTRUCTIONS", (love.graphics.getWidth() - width)/2, y + (height + BUTTON_PADDING_Y) * 2, width, height),
        ["QUIT"]            = Button("QUIT", (love.graphics.getWidth() - width)/2, y + (height + BUTTON_PADDING_Y) * 3, width, height),
    }


end

function TitleState:update(dt)

    if love.mouse.mousePressed then
        for _, button in pairs(self.buttons) do
            button.clicked = button:check_clicked(love.mouse.mousePressed.x, love.mouse.mousePressed.y)
        end

        love.mouse.mousePressed = false
        
    end

    if love.mouse.mouseReleased then
        if self.buttons["PLAY"]:check_clicked(love.mouse.mouseReleased.x, love.mouse.mouseReleased.y) then
            _G.StateMachine:change('play')
        elseif self.buttons["HISTORY"]:check_clicked(love.mouse.mouseReleased.x, love.mouse.mouseReleased.y) then
            -- TODO make a history system to save the intial patterns
        elseif self.buttons["INSTRUCTIONS"]:check_clicked(love.mouse.mouseReleased.x, love.mouse.mouseReleased.y) then
            -- TODO wirte the instruction of the game
        elseif self.buttons["QUIT"]:check_clicked(love.mouse.mouseReleased.x, love.mouse.mouseReleased.y) then
            love.event.quit()
        end
        
        for _, button in pairs(self.buttons) do button.clicked = false end

        love.mouse.mouseReleased = false
    end
    
end

function TitleState:render()

    love.graphics.setFont(TITLE_FONT)
    love.graphics.printf("REVERSE", 0, love.graphics.getHeight()/8, love.graphics.getWidth(), "center")

    for _, button in pairs(self.buttons) do
        button:draw()
    end
    
end