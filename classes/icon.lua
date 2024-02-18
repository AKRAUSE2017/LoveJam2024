require('helpers.constants')
require('helpers.utils')

Icon = Class{}

function Icon:init(x, y, w, h, name, image)
    self.x = x
    self.y = y
    self.w = w
    self.h = h

    self.name = name
    self.image = image

    self.state = "idle"
end

function Icon:render()
    love.graphics.setColor(255/255, 255/255, 255/255)
    -- love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)
    love.graphics.draw(self.image, self.x, self.y)

    love.graphics.setColor(255/255, 255/255, 255/255)
    love.graphics.print(self.name, self.x, self.y + self.h + ICON_NAME_OFFSET)
end

function Icon:set_state(mouse_data, last_mouse_data)
    if not mouse_data.button_1 then
        self.state = "idle"
    end

    if utils_collision(self, mouse_data) and mouse_data.button_1 and (not (last_mouse_data.x == mouse_data.x)) and (not (last_mouse_data.y == mouse_data.y)) then
        self.state = "attached"
    end
end

function Icon:update(mouse_data)
    if self.state == "attached" then
        self.x = mouse_data.x - self.w/2
        self.y = mouse_data.y - self.h/2
    end
end