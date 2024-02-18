require('helpers.constants')
require('helpers.utils')

Button = Class{}

function Button:init(x, y, w, h, name, image)
    self.x = x
    self.y = y
    self.w = w
    self.h = h

    self.name = name
    self.image = image
end

function Button:render()
    love.graphics.setColor(255/255, 255/255, 255/255)
    love.graphics.draw(self.image, self.x, self.y)
end

function Button:clicked(application_name)
    print("button clicked for application "..application_name)
end