local CELL = 9
local SIZE = CELL - 1
local HEIGHT = love.graphics.getHeight()
local WIDTH = love.graphics.getWidth()


local Conway = {
	rows = math.floor(HEIGHT / CELL),
	cols = math.floor(WIDTH / CELL),
	board = {},

}

function Conway:load()
	math.randomseed(os.time())

	-- Populate matrix with 0
	for row = 1, self.rows do
		self.board[row] = {}
		for col = 1, self.cols do
			self.board[row][col] = 0
		end
	end

	self:reset()
end

function Conway:reset()
	for row, cols in ipairs(self.board) do
		for col, _ in ipairs(cols) do
			self.board[row][col] = love.math.random(0, 1)
		end
	end
end

	



return Conway