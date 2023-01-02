mydebug = {}

function mydebug.draw(...)

    love.graphics.print(table.concat({...}, " - "), 10, 10)
end

return mydebug