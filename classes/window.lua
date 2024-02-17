require('helpers.constants')
require('helpers.utils')

Window = Class{}

function Window:init(x, y, w, h, name)
    self.x = x
    self.y = y
    self.w = w
    self.h = h

    self.name = name
    self.state = "idle"
end

function Window:render()
    love.graphics.setColor(236/255, 243/255, 247/255)
    love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)

    love.graphics.setColor(35/255, 87/255, 218/255)
    love.graphics.rectangle("fill", self.x, self.y, self.w, 20)

    love.graphics.setColor(255/255, 255/255, 255/255)
    love.graphics.print(self.name, self.x + 5, self.y + 2)

    love.graphics.setColor(255/255, 0/255, 0/255)
    love.graphics.rectangle("fill", self.x + self.w - 15, self.y+5, 10, 10)
end

function Window:close(mouse_data)
    local close_button = {x=self.x + self.w - 15, y=self.y+5, w=10, h=10}

    if utils_collision(close_button, mouse_data) and mouse_data.button_1 then
        return true
    else return false end
end

function Window:set_state(mouse_data, last_mouse_data)
    if not mouse_data.button_1 then
        self.state = "idle"
    end

    local window_bar = {x=self.x, y=self.y, w=self.w, h=20}
    if utils_collision(window_bar, mouse_data) and mouse_data.button_1 and (not (last_mouse_data.x == mouse_data.x)) and (not (last_mouse_data.y == mouse_data.y)) then
        self.state = "attached"
    end
end

function Window:update(mouse_data)
    if self.state == "attached" then
        self.x = mouse_data.x - self.w/2
        self.y = mouse_data.y - 20/2
    end
end