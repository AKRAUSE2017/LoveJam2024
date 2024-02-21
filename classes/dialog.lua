require('helpers.constants')
require('helpers.utils')
require('helpers.dialog_list')

Dialog = Class{}

function Dialog:init(x, y, w, h)
    self.x = x
    self.y = y
    self.w = w
    self.h = h
    
    self.active = true
    self.prompt_index = 1
    self.line_index = 1

    print(dialog_prompts[1][1])
    self.complete_current_list = false
end

function Dialog:render()
    if self.active then
        love.graphics.setColor(0, 0, 0)
        love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)
        love.graphics.setColor(255, 255, 255)
        love.graphics.print(dialog_prompts[self.prompt_index][self.line_index], self.x+20, self.y+20)
    end
end

function Dialog:check_and_set_active(day, applications)
    if self.prompt_index == 2 and applications["email"].window.visible then
        self.active = true
    elseif self.prompt_index == 3 and applications["folder"].window.visible then
        self.active = true
    end
end