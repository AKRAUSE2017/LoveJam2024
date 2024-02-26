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
    if self.prompt_index == 2 and applications["login"].window.visible == false then
        self.active = true
    elseif self.prompt_index == 3 and applications["email"].window.visible then
        self.active = true
    elseif self.prompt_index == 4 and applications["folder"].window.visible then
        self.active = true
    elseif self.prompt_index == 5 and completed_slides and not (applications["slides"].window.visible) then
        self.active = true
    elseif self.prompt_index == 6 and applications["web"].window.visible == true then
        self.active = true
    elseif self.prompt_index == 7 and applications["web"].window.visible == true and applications["web"].window.screens_display[5] == 1 then
        self.active = true
    elseif self.prompt_index == 8 and applications["web"].window.visible == false then
        self.active = true
    elseif self.prompt_index == 9 and applications["login"].window.visible == true then
        self.active = true
    elseif self.prompt_index == 10 and applications["login"].window.visible == false then
        self.active = true
    elseif self.prompt_index == 11 and email_message == 3 then
        self.active = true
    elseif self.prompt_index == 12 and email_tab == "outbox" then
        self.active = true
        love.audio.stop(music)
    elseif self.prompt_index == 13 and email_message == 1 then
        self.active = true
    elseif self.prompt_index == 14 and (email_tab == "inbox" or applications["email"].window.visible == false) then
        music = day_two
        music:play()
        music:setLooping(true)
        self.active = true
    elseif self.prompt_index == 15 and applications["folder"].window.visible then
        self.active = true
    elseif self.prompt_index == 16 and applications["web"].window.visible then
        self.active = true
    elseif self.prompt_index == 17 and applications["web"].window.visible and applications["web"].window.screens_display[3] == 1 then
        self.active = true
    elseif self.prompt_index == 18 and applications["notepad"].window.visible then
        self.active = true
    elseif self.prompt_index == 19 and applications["web"].window.visible and applications["web"].window.screens_display[3] == 1 then
        self.active = true
    end

    
end