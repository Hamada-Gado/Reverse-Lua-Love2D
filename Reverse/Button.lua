Button = Class{}

BUTTON_WIDTH = 30
BUTTON_HEIGHT = 50

BUTTON_FG_COLOR = {155/255, 41/255, 72/255}

function Button:init(value, x, y)
    self.x = x
    self.y = y
    self.width = BUTTON_WIDTH
    self.height = BUTTON_HEIGHT
    self.value = value

end

function Button:check_clicked(x, y)
    return self.x <= x and x <= self.x + self.width and self.y <= y and y <= self.y + self.height
end

function Button:draw()
    love.graphics.setColor(WHITE_COLOR)
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
    love.graphics.setColor(BUTTON_FG_COLOR)
    love.graphics.printf(tostring(self.value), self.x, self.y + self.height/2 - love.graphics.getFont():getHeight()/2, self.width, "center")
end