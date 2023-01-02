Button = Class{}

-- formula used (num - 5*4) / 3
MIN_BUTTON_WIDTH    = 73  -- smallest width = 240
MAX_BUTTON_WIDTH    = 236 -- largest width = 730
-- formula use (num - 5/4) / 4
MIN_BUTTON_HEIGHT   = 35  -- smallest height = 320, used 160 
MAX_BUTTON_HEIGHT   = 170 -- largest height = 1400, used 700

BUTTON_PADDING_X = 5
BUTTON_PADDING_Y = 5

BUTTON_FG_COLOR = {155/255, 41/255, 72/255}
BUTTON_BG_COLOR = {1, 1, 1}

function Button:init(value, x, y, width, height)
    self.x = x
    self.y = y
    self.width = width
    self.height = height
    self.value = value
    BUTTON_FONT = love.graphics.newFont("font.ttf", math.floor(math.min(width, height) - 10))

end

function Button:check_clicked(x, y)
    return self.x <= x and x <= self.x + self.width and self.y <= y and y <= self.y + self.height
end

function Button:draw()
    love.graphics.setColor(BUTTON_BG_COLOR)
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
    love.graphics.setFont(BUTTON_FONT)
    love.graphics.setColor(BUTTON_FG_COLOR)
    love.graphics.printf(tostring(self.value), self.x, self.y + self.height/2 - love.graphics.getFont():getHeight()/2, self.width, "center")
end

function Button:print()
    local str = tostring(self.value) .. " " .. tostring(self.x) .. ", " .. tostring(self.y) .. " : " .. tostring(self.size)
    print(str)
    
end