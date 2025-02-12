local Conway = require("conway")

function love.load()
	Conway:load()
end

function love.draw()
	Conway:draw()
end

function love.keypressed(key)
	if key == 'escape' then
		love.event.quit()
	elseif key == 'r' then
		Conway:reset()
	elseif key == 'c' then
		Conway:clear()
	end
end