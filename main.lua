push = require('imports.push')
Class = require('imports.class')

require('helpers.constants')
require('helpers.utils')
require('helpers.dialog_list')

require('classes.icon')
require('classes.window')
require('classes.button')
require('classes.text_box')
require('classes.dialog')
require('classes.logout')

function love.load() -- happens when the game starts
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        vsync = true,
        fullscreen = false,
        resizable = true
    })

    scale_x = VIRTUAL_WIDTH/WINDOW_WIDTH
    scale_y = VIRTUAL_HEIGHT/WINDOW_HEIGHT

    last_mouse_click = {time=0, x=0, y=0} -- time, x, y

    dialog = Dialog(VIRTUAL_WIDTH/2 - 1100/2, 555, 1100, 100)

    current_day = 1
    applications = {}

    background = love.graphics.newImage("assets/background.jpg")

    -- application for folder and file explorer
    applications["folder"] = {
        icon=Icon(10, 10, FOLDER_ICON_W, FOLDER_ICON_H, "Folder", love.graphics.newImage("assets/file_explorer/folder.png")),
        window=Window(50, 50, VIRTUAL_WIDTH-100, VIRTUAL_HEIGHT-100, "Shared Folder", love.graphics.newImage("assets/file_explorer/file_explorer.png"), 
            {love.graphics.newImage("assets/file_explorer/file_explorer_screen.png")}, -- list of screens

            {Button(1190, 55, 20, 20, "file_explorer_close")}, -- list of buttons
            
            {} -- list of text boxes
        )
    }

    -- application for email and email window(?)
    applications["email"] = {
        icon=Icon(10, 70, EMAIL_ICON_W, EMAIL_ICON_H, "Email", love.graphics.newImage("assets/email/email.png")),
        window=Window(50, 50, VIRTUAL_WIDTH-100, VIRTUAL_HEIGHT-100, "Email", love.graphics.newImage("assets/email/email_window.png"), 
            {}, 

            {Button(70, 95, 92, 20, "email_button_inbox"), -- list of buttons
             Button(198, 95, 92, 20, "email_button_outbox"),
             Button(1190, 55, 20, 20, "email_close")} ,

            {} -- list of text boxes
        )
    } 

    -- -- application for web browser (name pending) 
    applications["web"] = {
       icon=Icon(10, 160, WEB_ICON_W, WEB_ICON_H, "Web", love.graphics.newImage("assets/web/web_icon.png")),
       window=Window(50, 50, VIRTUAL_WIDTH-100, VIRTUAL_HEIGHT-100, "Web", love.graphics.newImage("assets/web/web_window.png"),
           {love.graphics.newImage("assets/web/web_screen.png"),
            love.graphics.newImage("assets/web/web_screen_dark.png"),
            love.graphics.newImage("assets/web/web_data_portal.png"), love.graphics.newImage("assets/web/web_data_portal_dark.png")}, -- list of screens

           {Button(1150, 90, 62, 19, "web_light_mode", love.graphics.newImage("assets/web/web_button_light_mode.png")),
            Button(1150, 90, 62, 19, "web_dark_mode", love.graphics.newImage("assets/web/web_button_dark_mode.png")),
            Button(1190, 55, 20, 20, "web_close"),
            Button(1004, 88, 14, 20, "web_bookmark")}, -- list of buttons

           {TextBox(90, 88, 890, 20, "editable"), -- list of text boxes
            TextBox(1024, 91, 0, 0, "static", "Data Portal"),
            TextBox(67, 62, 0, 0, "static", "Enterprise Safe Browser")} 
       )
    }

    game_state = "dialog"
    
    logout = Logout(0, 695, 99, 26, "logging_out", love.graphics.newImage("assets/logout_button/WhiteLogoutButton.png"))

    music = love.audio.newSource("assets/music/Song_2.wav", "stream")
    music:setLooping(true)
    music:play()
end

function love.resize(w,h)
    scale_x = VIRTUAL_WIDTH/w
    scale_y = VIRTUAL_HEIGHT/h
    push:resize(w,h)
end

function love.textinput(t)
    for _, application in pairs(applications) do
        for _, text_box in pairs(application.window.text_boxes) do
            if text_box.active and text_box.type == "editable" then
                text_box.text = text_box.text..t
            end
        end
    end
end

function love.keypressed(key)
    if dialog.active then
        if dialog.line_index == #dialog_prompts[dialog.prompt_index] then
            dialog.line_index = 1
            dialog.prompt_index = dialog.prompt_index + 1
            dialog.active = false
            game_state = "play"
        else
            dialog.line_index = dialog.line_index + 1
        end
    elseif key == "backspace" or key == "return" then
        for application_name, application in pairs(applications) do
            for _, text_box in pairs(application.window.text_boxes) do
                if text_box.active and key == "backspace" then
                    text_box.text = string.sub(text_box.text,1,#text_box.text-1)
                elseif text_box.active and key == "return" then
                    text_box:submit(application_name, application)
                end
            end
        end
    end
end

function love.draw() -- render objects on scre n
    push:start()

    love.graphics.draw(background, 0, 0, 0, 0.75)
    
    for _, application in pairs(applications) do
        application.icon:render()
    end
    
    for _, application in pairs(applications) do
        application.window:render()
    end

    dialog:render()

    logout:render()

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
        last_mouse_click.time = time
    else
        last_mouse_click.time = time
        last_mouse_click.x = mouse.x
        last_mouse_click.y = mouse.y
    end
end

function handle_mouse_click_window(mouse)
    for application_name, application in pairs(applications) do
        for _, button in pairs(application.window.buttons) do
            if utils_collision(button, mouse) then
                button:clicked(application_name, application)
            end 
        end

        for _, text_box in pairs(application.window.text_boxes) do
            if utils_collision(text_box, mouse) then
                text_box:clicked(application_name, application)
            else 
                text_box.active = false 
            end
        end
    end
end

function handle_mouse_click_logout(mouse)
    if utils_collision(logout, mouse) then
        -- love.event.quit()
        print("logout button clicked")
    end
end

function love.mousepressed() --  double click
    if game_state == "play" then
        local mouse = utils_get_mouse_data(scale_x, scale_y)
        print(mouse.x, mouse.y)
        
        handle_mouse_click_icon(mouse)
        handle_mouse_click_window(mouse)
        handle_mouse_click_logout(mouse)
    end
end

function love.update(dt) -- runs every frame
    if dialog.active then game_state = "dialog" end

    local mouse = utils_get_mouse_data(scale_x, scale_y) -- returns {button_1, button_2, x, y, w=1, h=1}

    for _, application in pairs(applications) do
        application.icon:set_state(mouse, last_mouse_click)
        application.icon:update(mouse)
    end

    dialog:check_and_set_active(current_day, applications)
end