require('helpers.constants')
require('helpers.utils')

Button = Class{}

function Button:init(x, y, w, h, name, image)
    self.x = x
    self.y = y
    self.w = w
    self.h = h

    self.name = name
    if image then
        self.image = image
    end

    self.visible = true
end

function Button:render(day)
    if self.image and self.visible then
        love.graphics.setColor(255/255, 255/255, 255/255)
        love.graphics.draw(self.image, self.x, self.y)
    else
        --love.graphics.rectangle("line", self.x, self.y, self.w, self.h)
    end
end

function Button:setDay(day)
    self.day = day
end

function Button:clicked(application_name, application)
    if application_name == "login" then
        if self.name == "login" and application.window.visible then
            if application.window.text_boxes[1].text == "sjones" and application.window.text_boxes[2].text == "p123" then
                applications["login"].window.visible = false
            end
        end
    end

    if application_name == "folder" then
        print("folder icon click", self.name)
        if self.name == "training" and application.window.visible and dialog.prompt_index > 4 then
            print("setting slides to visible")
            applications["slides"].window.visible = true
        end

        if self.name == "data_entry" and application.window.visible then
            print("setting slides to visible")
            applications["notepad"].window.visible = true
        end

        if self.name == "mystery" and application.window.visible and completed_slides == true then
            applications["notepad_readonly"].window.text_boxes[2] = TextBox(446, 134, 390, 460, "static", "www.echelon-unknown.com", "black")
            applications["notepad_readonly"].window.visible = true
        end

        if self.name == "file_explorer_close" and application.window.visible and not (applications["slides"].window.visible) then
            application.window.visible = false
        end
    end

    if application_name == "slides" then
        if self.name == "next_slide" and application.window.visible then
            if current_slide + 1 < 5 then
                current_slide = current_slide + 1
                if current_slide == 2 then
                    application.window.image = love.graphics.newImage("assets/slide_show/slide_2.png")
                elseif current_slide == 3 then
                    application.window.image = love.graphics.newImage("assets/slide_show/slide_3.png")
                    completed_slides = true
                elseif current_slide == 4 then
                    application.window.image = love.graphics.newImage("assets/slide_show/slide_4.png")
                    completed_slides = true
                end
            end
        end

        if self.name == "prev_slide" and application.window.visible then
            if current_slide - 1 > 0 then
                current_slide = current_slide - 1
                if current_slide == 1 then
                    application.window.image = love.graphics.newImage("assets/slide_show/slide_1.png")
                elseif current_slide == 2 then
                    application.window.image = love.graphics.newImage("assets/slide_show/slide_2.png")
                elseif current_slide == 3 then
                    application.window.image = love.graphics.newImage("assets/slide_show/slide_3.png")
                end
            end
        end

        if self.name == "close_slides" and application.window.visible then
            application.window.visible = false
        end
    end

    if application_name == "notepad_desktop" then
        if self.name == "notepad_close" and application.window.visible then
            application.window.visible = false
        end
    end
    
    if application_name == "notepad" then
        if self.name == "notepad_close" and application.window.visible then
            application.window.visible = false
        end
    end

    if application_name == "notepad_readonly" then
        if self.name == "notepad_close" and application.window.visible then
            application.window.visible = false
        end
    end

    if application_name == "email" then
        if self.name == "email_button_inbox" and application.window.visible then
            application.window.image = love.graphics.newImage("assets/email/email_window.png")
            email_tab = "inbox"
            email_message = 1
        elseif self.name == "email_button_outbox" and application.window.visible then
            application.window.image = love.graphics.newImage("assets/email/email_window_outbox.png")
            email_tab = "outbox"
            email_message = 1
        end

        if self.name == "email_message_one" then
            if email_list[current_day].inbox.actives[1] and application.window.visible then
                email_message = 1
            end
        elseif self.name == "email_message_two" then
            if email_list[current_day].inbox.actives[2] and application.window.visible then
                email_message = 2
            end
        elseif self.name == "email_message_three" then
            if email_list[current_day].inbox.actives[3] and application.window.visible then
                email_message = 3
            end
        end

        if self.name == "email_close" and application.window.visible then
            application.window.visible = false
        end
    end

    if application_name == "web" then
        -- dark mode for screens 1 and 2 (default screen)
        if self.name == "web_dark_mode" and application.window.visible and application.window.screens_display[1] == 1 and application.window.screens_display[2] == 0 then
            application.window.screens_display = {0, 1, 0, 0, 0, 0}
            self.visible = false
        elseif self.name == "web_dark_mode" and application.window.visible and application.window.screens_display[1] == 0 and application.window.screens_display[2] == 1 then
            application.window.screens_display = {1, 0, 0, 0, 0, 0}
            self.visible = true
        end

        -- dark mode for screens 3 and 4 (data portal)
        if self.name == "web_dark_mode" and application.window.visible and application.window.screens_display[3] == 1 and application.window.screens_display[4] == 0 then
            application.window.screens_display = {0, 0, 0, 1, 0, 0}
            self.visible = false
        elseif self.name == "web_dark_mode" and application.window.visible and application.window.screens_display[3] == 0 and application.window.screens_display[4] == 1 then
            application.window.screens_display = {0, 0, 1, 0, 0, 0}
            self.visible = true
        end

         -- dark mode for screens 5 and 6 (mystery message)
         if self.name == "web_dark_mode" and application.window.visible and application.window.screens_display[5] == 1 and application.window.screens_display[6] == 0 then
            application.window.screens_display = {0, 0, 0, 0, 0, 1}
            self.visible = false
        elseif self.name == "web_dark_mode" and application.window.visible and application.window.screens_display[5] == 0 and application.window.screens_display[6] == 1 then
            application.window.screens_display = {0, 0, 0, 0, 1, 0}
            self.visible = true
        end

        if self.name == "web_bookmark" and application.window.visible then
            application.window.text_boxes[1].text = CORP_DATA_PORTAL
            application.window.screens_display = {0, 0, 1, 0, 0, 0}
            application.window.buttons["web_dark_mode"].visible = true
        end

        if self.name == "web_close" and application.window.visible then
            application.window.screens_display = {1, 0, 0, 0, 0, 0} -- set back to default
            for _, text_box in pairs(application.window.text_boxes) do
                if text_box.type == "editable" then
                    text_box.text = ""
                end
            end
            application.window.visible = false
    end

    end
end