Button = Class{}

BUTTON_PADDING_X = 10
BUTTON_PADDING_Y = 10


BUTTON_FG_COLOR     = {155/255, 41/255, 72/255}
BUTTON_BG_COLOR     = {1, 1, 1}
BUTTON_BG_COLOR2    = {0.5, 0.5, 0.5}

function Button:init(value, x, y, width, height)
   
    self.x = x
    self.y = y
    self.width = width
    self.height = height
    self.value = value
    self.clicked = false
    self.button_font = love.graphics.newFont("font.ttf", math.floor(math.min(width, height) - 10))

end

function Button:check_clicked(x, y)
    return self.x <= x and x <= self.x + self.width and self.y <= y and y <= self.y + self.height
end

function Button:draw()
    
    -- shadow
    love.graphics.setColor(BUTTON_BG_COLOR2)
    love.graphics.rectangle("fill", self.x+5, self.y+5, self.width, self.height)

    local dx = self.clicked and 5 or 0

    -- main
    love.graphics.setColor(BUTTON_BG_COLOR)
    love.graphics.rectangle("fill", self.x + dx, self.y + dx, self.width, self.height)
    
    love.graphics.setColor(BUTTON_FG_COLOR)
    love.graphics.setFont(self.button_font)
    love.graphics.printf(tostring(self.value), self.x + dx, self.y + self.height/2 - love.graphics.getFont():getHeight()/2 + dx, self.width, "center")
end