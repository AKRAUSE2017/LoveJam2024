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

function Button:render()
    if self.image and self.visible then
        love.graphics.setColor(255/255, 255/255, 255/255)
        love.graphics.draw(self.image, self.x, self.y)
    else
        love.graphics.rectangle("line", self.x, self.y, self.w, self.h)
    end
end

function Button:clicked(application_name, application)
    if application_name == "folder" then
        if self.name == "folder_btn_1" then
            print("folder button clicked")
        end
    end

    if application_name == "email" then
        if self.name == "email_button_inbox" then
            application.window.screens_display = {1, 0}
        elseif self.name == "email_button_outbox" then
            application.window.screens_display = {0, 1}
        end
    end

    if application_name == "web" then
        -- dark mode for screens 1 and 2 (default screen)
        if self.name == "web_dark_mode" and application.window.screens_display[1] == 1 and application.window.screens_display[2] == 0 then
            application.window.screens_display = {0, 1, 0, 0}
            self.visible = false
        elseif self.name == "web_dark_mode" and application.window.screens_display[1] == 0 and application.window.screens_display[2] == 1 then
            application.window.screens_display = {1, 0, 0, 0}
            self.visible = true
        end

        -- dark mode for screens 3 and 4 (data portal)
        if self.name == "web_dark_mode" and application.window.screens_display[3] == 1 and application.window.screens_display[4] == 0 then
            application.window.screens_display = {0, 0, 0, 1}
            self.visible = false
        elseif self.name == "web_dark_mode" and application.window.screens_display[3] == 0 and application.window.screens_display[4] == 1 then
            application.window.screens_display = {0, 0, 1, 0}
            self.visible = true
        end

        if self.name == "web_close" then
            application.window.screens_display = {1, 0, 0, 0} -- set back to default
            for _, text_box in pairs(application.window.text_boxes) do
                if text_box.type == "editable" then
                    text_box.text = ""
                end
            end
            application.window.visible = false
    end

        print(application.window.screens_display[1])
        print(application.window.screens_display[2])
        print(application.window.screens_display[3])
        print(application.window.screens_display[4])
        print("=================")
    end
end