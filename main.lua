push = require('imports.push')
Class = require('imports.class')

require('helpers.constants')
require('helpers.utils')

require('classes.folder')
require('classes.window')

function love.load()
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        vsync = true,
        fullscreen = false,
        resizable = true
    })

    scale_x = VIRTUAL_WIDTH/WINDOW_WIDTH
    scale_y = VIRTUAL_HEIGHT/WINDOW_HEIGHT

    last_mouse_click = {time=0, x=0, y=0} -- time, x, y

    test_folder = Folder(10, 10, 100, 50, "test")

    windows = {}
end

function love.resize(w,h)
    scale_x = VIRTUAL_WIDTH/w
    scale_y = VIRTUAL_HEIGHT/h
    push:resize(w,h)
end

function love.draw()
    test_folder:render()

    for _, window in pairs(windows) do 
        window:render()
    end
end

function love.mousepressed() --  double click
    local mouse = utils_get_mouse_data(scale_x, scale_y)
	local time = os.time()

    local plus_minus_x = mouse.x < last_mouse_click.x + 10 and mouse.x > last_mouse_click.x - 10 
    local plus_minus_y = mouse.y < last_mouse_click.y + 10 and mouse.y > last_mouse_click.y - 10 

    if time <= last_mouse_click.time + DOUBLE_CLICK_THRESHOLD and plus_minus_x and plus_minus_y  then
        if utils_collision(test_folder, mouse) then
            table.insert(windows, Window(50, 50, VIRTUAL_WIDTH-100, VIRTUAL_HEIGHT-100, "window"))
        end
    else
        last_mouse_click.time = time
        last_mouse_click.x = mouse.x
        last_mouse_click.y = mouse.y
    end
end

function love.update()
    local mouse = utils_get_mouse_data(scale_x, scale_y) -- returns {button_1, button_2, x, y, w=1, h=1}

    test_folder:set_state(mouse, last_mouse_click)
    test_folder:update(mouse)
    
    for key, window in pairs(windows) do
        window:set_state(mouse, last_mouse_click)
        window:update(mouse)

        if window:close(mouse) then
            table.remove(windows, key)
        end
    end
end