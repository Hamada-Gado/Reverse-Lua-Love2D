Button = Class{}

MIN_BUTTON_SIZE = 145
MAX_BUTTON_SIZE = 215
BUTTON_PADDING_X = 5
BUTTON_PADDING_Y = 5
BUTTON_FG_COLOR = {155/255, 41/255, 72/255}

function Button:init(value, x, y, size)
    self.x = x
    self.y = y
    self.size = size
    self.width = size
    self.height = size
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

function Button:print()
    local str = tostring(self.value) .. " " .. tostring(self.x) .. ", " .. tostring(self.y) .. " : " .. tostring(self.size)
    print(str)
    
end