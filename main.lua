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

local mouse_highlight_x = -1
local mouse_highlight_y = -1

local mouse_highlight_x2 = -1
local mouse_highlight_y2 = -1

function love.load() -- happens when the game starts
    love.window.setTitle('Corporate Days')
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        vsync = true,
        fullscreen = false,
        resizable = false
    })

    font = love.graphics.newFont(16)
    love.graphics.setFont(font)

    scale_x = VIRTUAL_WIDTH/WINDOW_WIDTH
    scale_y = VIRTUAL_HEIGHT/WINDOW_HEIGHT

    last_mouse_click = {time=0, x=0, y=0} -- time, x, y

    dialog = Dialog(VIRTUAL_WIDTH/2 - 1100/2, 555, 1100, 100)

    current_day = 1
    show_current_day = true
    show_current_day_timer = 0
    applications = {}

    background = love.graphics.newImage("assets/background.png")

    -- application for folder and file explorer
    applications["folder"] = {
        icon=Icon(10, 10, FOLDER_ICON_W, FOLDER_ICON_H, "Folder", love.graphics.newImage("assets/file_explorer/folder.png")),
        window=Window(50, 50, VIRTUAL_WIDTH-100, VIRTUAL_HEIGHT-100, "Shared Folder", love.graphics.newImage("assets/file_explorer/file_explorer.png"), 
            {}, -- list of screens

            {file_explorer_close=Button(1190, 55, 20, 20, "file_explorer_close"),
             training=Button(275, 129, 33, 45, "training", love.graphics.newImage("assets/file_explorer/document_button.png")),
             data_entry=Button(391, 129, 33, 45, "data_entry", love.graphics.newImage("assets/file_explorer/document_button.png")),
             jan_report=Button(523, 129, 33, 45, "jan_report", love.graphics.newImage("assets/file_explorer/document_button.png")),
             feb_report=Button(642, 129, 33, 45, "feb_report", love.graphics.newImage("assets/file_explorer/document_button.png")),
             mar_report=Button(767, 129, 33, 45, "mar_report", love.graphics.newImage("assets/file_explorer/document_button.png")),
             apr_report=Button(884, 129, 33, 45, "apr_report", love.graphics.newImage("assets/file_explorer/document_button.png")),
             apr_report=Button(884, 129, 33, 45, "apr_report", love.graphics.newImage("assets/file_explorer/document_button.png")),
             mystery=Button(1015, 129, 33, 45, "mystery", love.graphics.newImage("assets/file_explorer/document_button.png"))}, -- list of buttons
            
            {TextBox(62, 145, 0, 0, "static", "Welcome to the\nCorporate Enterprise\nShared Drive!\n\n\nHere you can access\npublic and private\ncompany documents.\n\nRemember all files\nare confidential.\nUnauthorized use or\ndistribution of any\nshared files\nis strictly prohibited.", "white"),
             TextBox(318, 86, 0, 0, "static", "B:/User/SamJones/CorpEnterprise/SharedFolder", "white"),
             TextBox(263, 180, 0, 0, "static", "Training", "white"),
             TextBox(373, 180, 0, 0, "static", "Data Entry", "white"),
             TextBox(493, 180, 0, 0, "static", "Jan Report", "white"),
             TextBox(613, 180, 0, 0, "static", "Feb Report", "white"),
             TextBox(733, 180, 0, 0, "static", "Mar Report", "white"),
             TextBox(853, 180, 0, 0, "static", "Apr Report", "white"),
             TextBox(993, 180, 0, 0, "static", "yfnkaoxifa", "white")} -- list of text boxes
        )
    }

    -- application for email and email window(?)
    applications["email"] = {
        icon=Icon(10, 70, EMAIL_ICON_W, EMAIL_ICON_H, "Email", love.graphics.newImage("assets/email/email.png")),
        window=Window(50, 50, VIRTUAL_WIDTH-100, VIRTUAL_HEIGHT-100, "Email", love.graphics.newImage("assets/email/email_window.png"), 
            {love.graphics.newImage("assets/email/email_empty_screen.png")}, -- list of screens

            {email_button_inbox=Button(70, 95, 92, 20, "email_button_inbox"), -- list of buttons
             email_button_outbox=Button(198, 95, 92, 20, "email_button_outbox"),
             email_close=Button(1190, 55, 20, 20, "email_close"),
             
             email_message_one=Button(54, 138, 438, 84, "email_message_one"),
             email_message_two=Button(54, 138+80, 438, 84, "email_message_two"),
             email_message_three=Button(54, 138+80*2, 438, 84, "email_message_three")},

            {TextBox(79, 94, 0, 0, "static", "Inbox"),
             TextBox(209, 94, 0, 0, "static", "Outbox")} -- list of text boxes
        )
    } 

    email_tab = "inbox"
    email_message = 1

    -- -- application for web browser (name pending) 
    applications["web"] = {
       icon=Icon(10, 160, WEB_ICON_W, WEB_ICON_H, "Web", love.graphics.newImage("assets/web/web_icon.png")),
       window=Window(50, 50, VIRTUAL_WIDTH-100, VIRTUAL_HEIGHT-100, "Web", love.graphics.newImage("assets/web/web_window.png"),
           {love.graphics.newImage("assets/web/web_screen.png"),
            love.graphics.newImage("assets/web/web_screen_dark.png"),
            love.graphics.newImage("assets/web/web_data_portal.png"), love.graphics.newImage("assets/web/web_data_portal_dark.png"),
            love.graphics.newImage("assets/web/mystery_light.png"), love.graphics.newImage("assets/web/mystery_dark.png")}, -- list of screens

           {web_light_mode=Button(1150, 90, 62, 19, "web_light_mode", love.graphics.newImage("assets/web/web_button_light_mode.png")),
            web_dark_mode=Button(1150, 90, 62, 19, "web_dark_mode", love.graphics.newImage("assets/web/web_button_dark_mode.png")),
            web_close=Button(1190, 55, 20, 20, "web_close"),
            web_bookmark=Button(1004, 88, 14, 20, "web_bookmark")}, -- list of buttons

           {TextBox(90, 88, 890, 20, "editable", "", "white"), -- list of text boxes
            TextBox(1024, 91, 0, 0, "static", "Data Portal", "white"),
            TextBox(67, 62, 0, 0, "static", "Enterprise Safe Browser", "white"),
            TextBox(221, 227, 0, 0, "static", "There is data in the clouds. Those who highlight will know the true values.", "white")} 
       )
    }

    applications["notepad"] = {
        window=Window(VIRTUAL_WIDTH/2-200, VIRTUAL_HEIGHT/2-250, 400, 500, "Web", love.graphics.newImage("assets/notepad/notepad.png"),
            {}, -- list of screens
 
            {notepad_close=Button(823, 117, 11, 12, "notepad_close")}, -- list of buttons
 
            {TextBox(446, 134, 390, 460, "editable", "", "black"),
             TextBox(447, 113, 0, 0, "static", "Notepad", "white"),} 
        )
     }

     applications["notepad_desktop"] = {
        icon=Icon(8, 225, 37, 36, "Notepad", love.graphics.newImage("assets/notepad/notepad_icon.png")),
        window=Window(VIRTUAL_WIDTH/2-200, VIRTUAL_HEIGHT/2-250, 400, 500, "Web", love.graphics.newImage("assets/notepad/notepad.png"),
            {}, -- list of screens
 
            {notepad_close=Button(823, 117, 11, 12, "notepad_close")}, -- list of buttons
 
            {TextBox(446, 134, 390, 460, "editable", "", "black"),
             TextBox(447, 113, 0, 0, "static", "Notepad", "white"),} 
        )
     }

     applications["notepad_readonly"] = {
        window=Window(VIRTUAL_WIDTH/2-200, VIRTUAL_HEIGHT/2-250, 400, 500, "Web", love.graphics.newImage("assets/notepad/notepad.png"),
            {}, -- list of screens
 
            {notepad_close=Button(823, 117, 11, 12, "notepad_close")}, -- list of buttons
 
            {TextBox(447, 113, 0, 0, "static", "Notepad - Locked File", "white"),} 
        )
     }

    applications["login"] = {
        window=Window(VIRTUAL_WIDTH/2-250, VIRTUAL_HEIGHT/2-250, 500, 500, "Login", love.graphics.newImage("assets/logout/login_screen.png"), 
            {}, -- list of screens

            {login=Button(521, 391, 248, 55, "login")}, -- list of buttons
            
            {TextBox(418, 252, 440, 50, "editable", "", "black", "user"),
             TextBox(418, 319, 440, 50, "editable", "", "black", "pass")} -- list of text boxes
        )
    }

    applications["slides"] = {
        window=Window(50, 50, VIRTUAL_WIDTH-100, VIRTUAL_HEIGHT-100, "Slides", love.graphics.newImage("assets/slide_show/slide_1.png"), 
            {}, -- list of screens

            {Button(66,625,145,33,"prev_slide"),
             Button(1041,626,145,33,"next_slide"),
             Button(1164,61,20,20,"close_slides")}, -- list of buttons
            
            {} -- list of text boxes
        )
    }

    current_slide = 1
    completed_slides = false

    game_state = "dialog"
    applications["login"].window.visible = true;
    
    logout = Logout(0, 692, 99, 26, "logging_out", love.graphics.newImage("assets/logout/WhiteLogoutButton.png"))
    
    day_one = love.audio.newSource("assets/music/day_one.wav", "stream")
    day_two = love.audio.newSource("assets/music/day_two.mp3", "stream")
    end_song = love.audio.newSource("assets/music/end.mp3", "stream")
    music = day_one
    music:setLooping(true)
    -- music:play()

    secret_message = TextBox(922, 440, 0, 0, "static", "They were alive.\nThey were alive.\nThey were alive", "black")
    show_secret_message = false

    end_screen = newAnimation(love.graphics.newImage("assets/game_end.png"), 320, 180, 13)
    show_end_screen = false
    show_end_screen_timer = 0

end

function love.resize(w,h)
    scale_x = VIRTUAL_WIDTH/w
    scale_y = VIRTUAL_HEIGHT/h
    push:resize(w,h)
end

function love.textinput(t)
    for _, application in pairs(applications) do
        for _, text_box in pairs(application.window.text_boxes) do
            if text_box.active and text_box.type == "editable" and application.window.visible then
                text_box.text = text_box.text..t
                text_box.current_line = text_box.current_line..t
            end
        end
    end
end

function newAnimation(image, width, height, duration)
    local animation = {}
    animation.spriteSheet = image;
    animation.quads = {};

    for y = 0, image:getHeight() - height, height do
        for x = 0, image:getWidth() - width, width do
            table.insert(animation.quads, love.graphics.newQuad(x, y, width, height, image:getDimensions()))
        end
    end

    animation.duration = duration or 1
    animation.currentTime = 0

    return animation
end

function love.keypressed(key)
    if dialog.active then
        if show_current_day == false then
            if dialog.line_index == #dialog_prompts[dialog.prompt_index] then
                dialog.line_index = 1
                dialog.prompt_index = dialog.prompt_index + 1
                dialog.active = false
                game_state = "play"
            else
                dialog.line_index = dialog.line_index + 1
            end
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
    love.graphics.draw(background, 0, 0, 0, 1)
    
    for _, application in pairs(applications) do
        if application.icon then
            application.icon:render()
        end
    end
    
    for _, application in pairs(applications) do
        application.window:render(current_day)
    end

    applications["slides"].window:render(current_day)
    applications["notepad"].window:render(current_day)
    applications["notepad_readonly"].window:render(current_day)

    dialog:render()

    logout:render()

    if show_current_day then
        love.graphics.setColor(0, 0, 0)
        love.graphics.rectangle("fill", 0, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)
        love.graphics.setColor(1, 1, 1)
        love.graphics.print("Day "..current_day, VIRTUAL_WIDTH/2-30, VIRTUAL_HEIGHT/2-10)
    end

    local openApplication = false

    for _, application in pairs(applications) do
        if application.window.visible then
            openApplication = true
        end
    end

    if mouse_highlight_x > -1 and mouse_highlight_y > -1 and mouse_highlight_x2 > -1 and mouse_highlight_y2 > -1 and openApplication == false then
        local w = mouse_highlight_x2 - mouse_highlight_x
        local h = mouse_highlight_y2 - mouse_highlight_y
        love.graphics.setColor(1, 1, 1, 0.4)
        love.graphics.rectangle("fill", mouse_highlight_x, mouse_highlight_y, w, h)
        love.graphics.setColor(1, 1, 1)
    end

    if show_secret_message == true then
        secret_message:render()
    end

    if show_end_screen == true then
        local spriteNum = math.floor(end_screen.currentTime / end_screen.duration * #end_screen.quads) + 1
        love.graphics.draw(end_screen.spriteSheet, end_screen.quads[spriteNum], 0, 0, 0, 4)
    end

    push:finish()
end

function handle_mouse_click_icon(mouse)
    local openApplication = false

    for _, application in pairs(applications) do
        if application.window.visible then
            openApplication = true
        end
    end

    if openApplication == false then
        local time = os.time()

        local plus_minus_x = mouse.x < last_mouse_click.x + 10 and mouse.x > last_mouse_click.x - 10 
        local plus_minus_y = mouse.y < last_mouse_click.y + 10 and mouse.y > last_mouse_click.y - 10 

        if time <= last_mouse_click.time + DOUBLE_CLICK_THRESHOLD and plus_minus_x and plus_minus_y  then
            for _, application in pairs(applications) do
                if application.icon then 
                    if utils_collision(application.icon, mouse) then
                        application.window.visible = true
                    end
                end
            end
            last_mouse_click.time = time
        else
            last_mouse_click.time = time
            last_mouse_click.x = mouse.x
            last_mouse_click.y = mouse.y
        end
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
                text_box:clicked()
            else 
                text_box.active = false 
            end
        end
    end
end

function handle_mouse_click_logout(mouse)
    if utils_collision(logout, mouse) then
        -- love.event.quit()
        if dialog.prompt_index == 9 and current_day == 1 then
            for _, application in pairs(applications) do
                application.window.visible = false
            end
            dialog.prompt_index = 9
            current_day = current_day + 1
            love.audio.stop(music)
            music = day_two
            music:setLooping(true)
            show_current_day = true
            applications["login"].window.visible = true
            applications["login"].window.text_boxes[1].text = ""
            applications["login"].window.text_boxes[2].text = ""

            applications['email'].window.image = love.graphics.newImage("assets/email/email_window.png")
            email_message = 1
            email_tab = "inbox"
        end
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
    local openApplication = false

    for _, application in pairs(applications) do
        if application.window.visible then
            openApplication = true
        end
    end

    if love.mouse.isDown(1) and openApplication == false and mouse_highlight_x == -1 then
        mouse_highlight_x = utils_get_mouse_data(scale_x, scale_y).x
        mouse_highlight_y = utils_get_mouse_data(scale_x, scale_y).y
    elseif love.mouse.isDown(1) and openApplication == false and mouse_highlight_x > -1 then
        mouse_highlight_x2 = utils_get_mouse_data(scale_x, scale_y).x
        mouse_highlight_y2 = utils_get_mouse_data(scale_x, scale_y).y
    elseif not(love.mouse.isDown(1)) then
        mouse_highlight_x = -1
        mouse_highlight_y = -1

        mouse_highlight_x2 = -1
        mouse_highlight_y2 = -1
    end

    
    local x_min = math.min(mouse_highlight_x, mouse_highlight_x2)
    local y_min = math.min(mouse_highlight_y, mouse_highlight_y2)
    local x_max = math.max(mouse_highlight_x, mouse_highlight_x2)
    local y_max = math.max(mouse_highlight_y, mouse_highlight_y2)
    
    local w = x_max - x_min
    local h = y_max - y_min
    if utils_inside({x=x_min, y=y_min, w=w, h=h}, secret_message) and dialog.prompt_index > 18 then
        show_secret_message = true
        show_end_screen_timer = show_end_screen_timer + dt
    else
        show_secret_message = false
    end

    if show_end_screen_timer > 0 then
        show_end_screen_timer = show_end_screen_timer + dt
        if show_end_screen_timer > 3 and show_end_screen_timer < 4 then
            show_end_screen = true
            love.audio.stop(music)
            music = end_song
            music:play()
            music:setLooping(true)
        end
    end

    if show_end_screen == true then
        end_screen.currentTime = end_screen.currentTime + dt
        if end_screen.currentTime >= end_screen.duration then
            end_screen.currentTime = end_screen.currentTime - end_screen.duration
        end
    end

    if dialog.active then game_state = "dialog" end

    local mouse = utils_get_mouse_data(scale_x, scale_y) -- returns {button_1, button_2, x, y, w=1, h=1}

    for _, application in pairs(applications) do
        if application.icon then
            application.icon:set_state(mouse, last_mouse_click)
            application.icon:update(mouse)
        end
    end

    dialog:check_and_set_active(current_day, applications)

    if show_current_day == true then
        show_current_day_timer = show_current_day_timer + dt
        if show_current_day_timer > 2 then
            show_current_day = false
            show_current_day_timer = 0
            music:play()
        end
    end
end