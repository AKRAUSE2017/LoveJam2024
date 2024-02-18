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
end

function Button:render()
    if self.image then
        love.graphics.setColor(255/255, 255/255, 255/255)
        love.graphics.draw(self.image, self.x, self.y)
    else
        love.graphics.rectangle("line", self.x, self.y, self.w, self.h)
    end
end

function Button:clicked(application_name, application)
    if application_name == "email" then
        if self.name == "tab button 1" then
            print("button clicked for application "..application_name)
            application.window.screens_display = {0,1,0}
        elseif self.name == "tab button 2" then
            print("button clicked for application "..application_name)
            application.window.screens_display = {0,0,1}
        end
    elseif application_name == "web_browser" then
        if self.name == "blue button" then
            print("button clicked for application "..application_name)
        elseif self.name == "pink button" then
            print("button clicked for application "..application_name)
        end
    end
end