require('helpers.constants')
require('helpers.utils')

Window = Class{}

function Window:init(x, y, w, h, name, image, screens, buttons, text_boxes)
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
    self.text_boxes = text_boxes -- list of text box objects 

    self.visible = false
end

function Window:render()
    if self.visible then
        love.graphics.setColor(255/255, 255/255, 255/255)
        love.graphics.draw(self.image, self.x, self.y)

        for index, screen in pairs(self.screens) do
            if self.screens_display[index] == 1 then
                love.graphics.setColor(255/255, 255/255, 255/255)
                love.graphics.draw(screen, self.x+4, self.y+65)
            end
        end

        for _, button in pairs(self.buttons) do
            button:render()
        end

        for _, text_box in pairs(self.text_boxes) do
            text_box:render()
        end
    end
end