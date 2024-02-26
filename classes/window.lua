require('helpers.constants')
require('helpers.utils')
require('helpers.email_list')

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

function Window:render(day)
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
            if button.name == "mystery" and completed_slides == true and current_day == 1 and dialog.prompt_index > 4 then
                button:render()
            elseif not (button.name == "mystery") then
                button:render()
            end
        end

        if self.buttons["web_dark_mode"] then 
            if self.buttons["web_dark_mode"].visible == true then
                self.buttons["web_dark_mode"]:render()
            end
        end

        for _, text_box in pairs(self.text_boxes) do
            if text_box.text == "yfnkaoxifa" and completed_slides == true and current_day == 1 and dialog.prompt_index > 4 then
                love.graphics.setColor(255/255, 255/255, 255/255)
                text_box:render()
            elseif text_box.text == "There is data in the clouds. Those who highlight will know the true values." then
                if dialog.prompt_index > 18 and applications["web"].window.screens_display[3] == 1 then
                    text_box:render()
                end
            elseif not (text_box.text == "yfnkaoxifa") then
                text_box:render()
            end
            
        end

        if self.name == "Email" then
            if email_tab == "inbox" then
                for _, image in pairs(email_list[day].inbox.previews.images) do
                    love.graphics.setColor(255/255, 255/255, 255/255)
                    love.graphics.draw(image.image, image.x, image.y)
                end

                for _, text in pairs(email_list[day].inbox.previews.text) do
                    love.graphics.setColor(0/255, 0/255, 0/255)
                    love.graphics.print(text.text, text.x, text.y)
                end

                if email_list[day].inbox.actives[email_message] then
                    for _, image in pairs(email_list[day].inbox.actives[email_message].images) do
                        love.graphics.setColor(255/255, 255/255, 255/255)
                        love.graphics.draw(image.image, image.x, image.y)
                    end

                    for _, text in pairs(email_list[day].inbox.actives[email_message].text) do
                        love.graphics.setColor(0/255, 0/255, 0/255)
                        love.graphics.print(text.text, text.x, text.y)
                    end
                end
            end

            if email_tab == "outbox" and email_list[day].outbox then
                for _, image in pairs(email_list[day].outbox.previews.images) do
                    love.graphics.setColor(255/255, 255/255, 255/255)
                    love.graphics.draw(image.image, image.x, image.y)
                end

                for _, text in pairs(email_list[day].outbox.previews.text) do
                    love.graphics.setColor(0/255, 0/255, 0/255)
                    love.graphics.print(text.text, text.x, text.y)
                end

                if email_list[day].outbox.actives[email_message] then
                    for _, image in pairs(email_list[day].outbox.actives[email_message].images) do
                        love.graphics.setColor(255/255, 255/255, 255/255)
                        love.graphics.draw(image.image, image.x, image.y)
                    end

                    for _, text in pairs(email_list[day].outbox.actives[email_message].text) do
                        love.graphics.setColor(0/255, 0/255, 0/255)
                        love.graphics.print(text.text, text.x, text.y)
                    end
                end
            end
        end
    end
end