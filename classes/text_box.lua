require('helpers.constants')
require('helpers.utils')

TextBox = Class{}

function TextBox:init(x, y, w, h, type, default_text)
    self.x = x
    self.y = y
    self.w = w
    self.h = h
    self.active = false
    self.type = type

    if default_text then
        self.text = default_text
    else
        self.text = ""
    end
end

function TextBox:render()
    if not self.active or self.type == "static" then
        love.graphics.setColor(255/255, 255/255, 255/255)
        love.graphics.print(self.text, self.x, self.y)
        love.graphics.setColor(255/255, 255/255, 255/255)
        love.graphics.rectangle("line", self.x, self.y, self.w, self.h)
    else
        love.graphics.setColor(255/255, 255/255, 255/255)
        love.graphics.print(self.text.."|", self.x, self.y)
        love.graphics.setColor(0/255, 0/255, 255/255)
        love.graphics.rectangle("line", self.x, self.y, self.w, self.h)
    end
end

function TextBox:clicked()
    if self.type == "editable" then
        self.active = true
    end
end

function TextBox:submit(application_name, application)
    if self.type == "editable" then
        self.active = false
        
        if application_name == "web" then
            if self.text == CORP_DATA_PORTAL then
                application.window.screens_display = {0, 0, 1, 0}
                application.window.buttons[2].visible = true
            end
        end

    end
end
