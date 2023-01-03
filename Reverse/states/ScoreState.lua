ScoreState = Class{__includes= BaseState}

function ScoreState:init()
    FINAL_SCORE_FONT = love.graphics.newFont("font.ttf", TITLE_FONT:getHeight()*0.7)
    self.final_score = "You win!!\nNumber of tries: "
    self.play_again_button  = Button("PLAY AGAIN", (love.graphics.getWidth() - BUTTON_WIDTH)/2, love.graphics.getHeight()/2, BUTTON_WIDTH, BUTTON_HEIGHT)
    self.main_menu_button   = Button("MAIN MENU", (love.graphics.getWidth() - BUTTON_WIDTH)/2, love.graphics.getHeight()/2 + BUTTON_HEIGHT + BUTTON_PADDING_Y, BUTTON_WIDTH, BUTTON_HEIGHT)

    
end

function ScoreState:update(dt)
    if love.mouse.mousePressed then
        self.play_again_button.clicked = self.play_again_button:check_clicked(love.mouse.mousePressed.x, love.mouse.mousePressed.y)
        self.main_menu_button.clicked = self.main_menu_button:check_clicked(love.mouse.mousePressed.x, love.mouse.mousePressed.y)

        love.mouse.mousePressed = false
    end

    if love.mouse.mouseReleased then
        if self.play_again_button:check_clicked(love.mouse.mouseReleased.x, love.mouse.mouseReleased.y) then
            _G.StateMachine:change('play')
        elseif self.main_menu_button:check_clicked(love.mouse.mouseReleased.x, love.mouse.mouseReleased.y) then
            _G.StateMachine:change('title')
        end
        
        self.play_again_button.clicked = false
        self.main_menu_button.clicked = false
        love.mouse.mouseReleased = false
    end
    
end

function ScoreState:render()
    love.graphics.setFont(FINAL_SCORE_FONT)
    love.graphics.printf(self.final_score, 0, 10, love.graphics.getWidth(), "center")
    
    self.play_again_button:draw()
    self.main_menu_button:draw()

end

function ScoreState:enter(number_trials)
    self.final_score = self.final_score .. tostring(number_trials)
    
end