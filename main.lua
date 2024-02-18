push = require('imports.push')
Class = require('imports.class')

require('helpers.constants')
require('helpers.utils')

require('classes.icon')
require('classes.window')
require('classes.button')

function love.load() -- happens when the game starts
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        vsync = true,
        fullscreen = false,
        resizable = true
    })

    scale_x = VIRTUAL_WIDTH/WINDOW_WIDTH
    scale_y = VIRTUAL_HEIGHT/WINDOW_HEIGHT

    last_mouse_click = {time=0, x=0, y=0} -- time, x, y

    applications = {}

    -- application for folder and file explorer
    applications["folder"] = {
        icon=Icon(10, 10, FOLDER_ICON_W, FOLDER_ICON_H, "test", love.graphics.newImage("assets/folder.png")),
        window=Window(50, 50, VIRTUAL_WIDTH-100, VIRTUAL_HEIGHT-100, "window", love.graphics.newImage("assets/file_explorer.png"), 
            {love.graphics.newImage("assets/file_explorer_screen.png")}, -- list of screens
            {Button(75, 75, 50, 20, "test button", love.graphics.newImage("assets/file_explorer_button.png"))} -- list of buttons
        )
    }
end

function love.resize(w,h)
    scale_x = VIRTUAL_WIDTH/w
    scale_y = VIRTUAL_HEIGHT/h
    push:resize(w,h)
end

function love.draw() -- render objects on screen
    push:start()

    for _, application in pairs(applications) do
        application.icon:render()
        application.window:render()
    end

    push:finish()
end

function handle_mouse_click_icon(mouse)
    local time = os.time()

    local plus_minus_x = mouse.x < last_mouse_click.x + 10 and mouse.x > last_mouse_click.x - 10 
    local plus_minus_y = mouse.y < last_mouse_click.y + 10 and mouse.y > last_mouse_click.y - 10 

    if time <= last_mouse_click.time + DOUBLE_CLICK_THRESHOLD and plus_minus_x and plus_minus_y  then
        for _, application in pairs(applications) do
            if utils_collision(application.icon, mouse) then
                application.window.visible = true
            end
        end
    else
        last_mouse_click.time = time
        last_mouse_click.x = mouse.x
        last_mouse_click.y = mouse.y
    end
end

function handle_screen_button_click(mouse)
    for application_name, application in pairs(applications) do
        for _, button in pairs(application.window.buttons) do
            if utils_collision(button, mouse) then
                button:clicked(application_name)
            end 
        end
    end
end

function love.mousepressed() --  double click
    local mouse = utils_get_mouse_data(scale_x, scale_y)
	
    handle_mouse_click_icon(mouse)
    handle_screen_button_click(mouse)
end

function love.update() -- runs every frame
    local mouse = utils_get_mouse_data(scale_x, scale_y) -- returns {button_1, button_2, x, y, w=1, h=1}

    for _, application in pairs(applications) do
        application.icon:set_state(mouse, last_mouse_click)
        application.icon:update(mouse)

        if application.window:close(mouse) then
            application.window.visible = false
        end
    end
    
end