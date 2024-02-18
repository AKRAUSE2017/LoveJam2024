require('helpers.constants')
require('helpers.utils')

Window = Class{}

function Window:init(x, y, w, h, name, image, screens, buttons)
    self.x = x
    self.y = y
    self.w = w
    self.h = h

    self.name = name
    self.image = image -- skeleton image

    self.screens = screens -- list of images
    self.screens_display = {}
    for _,_ in pairs (self.screens) do
        table.insert(self.screens_display, 0)
    end
    self.screens_display[1] = 1
    self.buttons = buttons -- list of button objects 

    self.visible = false
end

function Window:render()
    if self.visible then
        love.graphics.setColor(255/255, 255/255, 255/255)
        love.graphics.draw(self.image, self.x, self.y)

        love.graphics.setColor(255/255, 0/255, 0/255)
        love.graphics.rectangle("fill", self.x + self.w - 15, self.y+5, 10, 10)

        for index, screen in pairs(self.screens) do
            if self.screens_display[index] == 1 then
                love.graphics.setColor(255/255, 255/255, 255/255)
                love.graphics.draw(screen, self.x, self.y+20)
            end
        end

        for _, button in pairs(self.buttons) do
            button:render()
        end
    end
end

function Window:close(mouse_data)
    local close_button = {x=self.x + self.w - 15, y=self.y+5, w=10, h=10}

    if utils_collision(close_button, mouse_data) and mouse_data.button_1 then
        return true
    else return false end
end