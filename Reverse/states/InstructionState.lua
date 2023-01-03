InstructionState = Class{__includes= BaseState}

INSTRUCTIONS    = [[
THIS IS THE GAME OF 'REVERSE'.

TO WIN, ALL YOU HAVE
TO DO IS ARRANGE A LIST OF NUMBERS (1 THROUGH 9)
IN NUMERICAL ORDER FROM LEFT TO RIGHT.  TO MOVE, YOU
TELL ME HOW MANY NUMBERS (COUNTING FROM THE LEFT) TO
REVERSE.  FOR EXAMPLE, IF THE CURRENT LIST IS:
2 3 4 5 1 6 7 8 9
AND YOU REVERSE 4, THE RESULT WILL BE:
5 4 3 2 1 6 7 8 9
NOW IF YOU REVERSE 5, YOU WIN!
1 2 3 4 5 6 7 8 9
NO DOUBT YOU WILL LIKE THIS GAME, AND
IF YOU WANT TO RESET THE LIST OF NUMBERS, REVERSE 0 (ZERO).
]]

function InstructionState:init()
    self.font = love.graphics.newFont("font.ttf", love.graphics.getHeight()/30)
    self.back_button = Button("BACK", (BUTTON_PADDING_X*1.5), love.graphics.getHeight()*0.9, BUTTON_WIDTH, BUTTON_HEIGHT)
    
end

function InstructionState:update(dt)
    if love.mouse.mousePressed then
        self.back_button.clicked = self.back_button:check_clicked(love.mouse.mousePressed.x, love.mouse.mousePressed.y)

        love.mouse.mousePressed = false
    end

    if love.mouse.mouseReleased then
        if self.back_button:check_clicked(love.mouse.mouseReleased.x, love.mouse.mouseReleased.y) then
            _G.StateMachine:change('title')
        end
        
        self.back_button.clicked = false
        love.mouse.mouseReleased = false
    end
    
end

function InstructionState:render()
    love.graphics.setColor(TITLE_FG_COLOR)
    love.graphics.setFont(self.font)
    love.graphics.printf(INSTRUCTIONS, 0, 10, love.graphics.getWidth(), "center")

    self.back_button:draw()
    
end