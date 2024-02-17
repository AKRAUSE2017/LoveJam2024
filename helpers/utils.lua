function utils_collision(obj1, obj2)
    obj1_rightEdge = obj1.x + obj1.w
    obj1_leftEdge = obj1.x

    obj2_rightEdge = obj2.x + obj2.w
    obj2_leftEdge = obj2.x

    obj1_bottomEdge = obj1.y + obj1.h
    obj1_topEdge = obj1.y
    
    obj2_bottomEdge = obj2.y + obj2.h
    obj2_topEdge = obj2.y

    collX = obj1_rightEdge >= obj2_leftEdge and obj2_rightEdge >= obj1_leftEdge
    collY = obj1_topEdge <= obj2_bottomEdge and obj2_topEdge <= obj1_bottomEdge

    return collX and collY
end

function utils_get_mouse_data(window_scale_x, window_scale_y)
    x, y = love.mouse.getPosition()
    local mouse_data = {button_1=love.mouse.isDown(1), button_2=love.mouse.isDown(2), x=x*window_scale_x, y=y*window_scale_y, w=1, h=1}

    return mouse_data
end

