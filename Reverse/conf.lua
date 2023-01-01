-- Constants
_G.BACKGROUND_COLOR = {255/255, 202/255, 123/255}
_G.BUTTON_FG_COLOR = {155/255, 41/255, 72/255}
_G.WHITE_COLOR = {1, 1, 1}

function love.conf(t)
    t.console = true
    t.modules.joystick = false
    t.externalstorage = true
    t.window.resizable = false
    t.window.fullscreen = true
    t.window.vsync = true

end