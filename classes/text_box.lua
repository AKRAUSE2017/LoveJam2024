require('helpers.constants')
require('helpers.utils')

TextBox = Class{}

function TextBox:init(x, y, w, h, type, default_text, color, name)
    self.x = x
    self.y = y
    self.w = w
    self.h = h
    self.active = false
    self.type = type

    self.text = default_text
    self.color = color

    self.current_line = ""
    self.name = name
end

function TextBox:render()
    if not self.active or self.type == "static" then
        if self.color == "white" then
            love.graphics.setColor(255/255, 255/255, 255/255)
        else
            love.graphics.setColor(0/255, 0/255, 0/255)
        end
        if self.name == "user" or self.name == "pass" then
            
            love.graphics.print("\n  "..self.text, self.x, self.y)
        else
            love.graphics.print(self.text, self.x, self.y)
        end
        love.graphics.setColor(255/255, 255/255, 255/255)
        love.graphics.rectangle("line", self.x, self.y, self.w, self.h)
    else
        if self.color == "white" then
            love.graphics.setColor(255/255, 255/255, 255/255)
        else
            love.graphics.setColor(0/255, 0/255, 0/255)
        end
        
        if font:getWidth(self.current_line) > 375 and not( #self.text == 0 )then 
            self.current_line = ""
            self.text = self.text.."\n"
        end
        if self.name == "user" or self.name == "pass" then
            
            love.graphics.print("\n  "..self.text.."|", self.x, self.y)
        else
            love.graphics.print(self.text.."|", self.x, self.y)
        end
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
                application.window.screens_display = {0, 0, 1, 0, 0, 0}
                application.window.buttons["web_dark_mode"].visible = true
            elseif self.text == ECHELON_UNKNOWN then
                application.window.screens_display = {0, 0, 0, 0, 1, 0}
                application.window.buttons["web_dark_mode"].visible = true
            end
        end

    end
end
