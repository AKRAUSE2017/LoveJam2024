require('helpers.constants')
require('helpers.utils')

Logout = Class{}

function Logout:init(x, y, w, h, name, image)
    self.x = x
    self.y = y
    self.w = w
    self.h = h

    self.name = name
    self.image = image

    self.visible = true
end

function Logout:render()
    love.graphics.setColor(0/255, 255/255, 255/255)
    love.graphics.rectangle("fill", 0, 695, 1700, 75)

    love.graphics.setColor(255/255, 255/255, 255/255)
    love.graphics.draw(self.image, self.x, self.y)
    love.graphics.rectangle("line", self.x, self.y, self.w, self.h)
end
