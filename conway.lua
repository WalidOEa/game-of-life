local CELL = 9
local SIZE = CELL - 1
local HEIGHT = love.graphics.getHeight()
local WIDTH = love.graphics.getWidth()


local Conway = {
	rows = math.floor(HEIGHT / CELL),
	cols = math.floor(WIDTH / CELL),
	board = {},
	next_board = {}
}

function Conway:load()
	math.randomseed(os.time())

	-- Populate matrix with 0
	for row = 1, self.rows do
		self.board[row] = {}
		self.next_board[row] = {}
		for col = 1, self.cols do
			self.board[row][col] = 0
			self.next_board[row][col] = 0
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

function Conway:clear()
	for row, cols in ipairs(self.board) do
		for col, _ in ipairs(cols) do
			self.board[row][col] = 0
		end
	end
end

function Conway:update()
	for row, cols in ipairs(self.board) do
		for col, value in ipairs(cols) do
			local count = 0

			for y = row - 1, row + 1 do
				for x = col - 1, col + 1 do
					if not (row == y and col == x) then
						local wrapped_row = ((y - 1) % self.rows) + 1
						local wrapped_col = ((x - 1) % self.cols) + 1

						count = count + self.board[wrapped_row][wrapped_col]
					end
				end
			end

			if value == 1 and count > 1 and count < 4 then
				self.next_board[row][col] = 1
			elseif value == 0 and count == 3 then
				self.next_board[row][col] = 1
			else
				self.next_board[row][col] = 0
			end

			local temp = self.board
			self.board = self.next_board
			self.next_board = temp
		end
	end
end

function Conway:draw()
	love.graphics.setColor(0, 0, 0)
	love.graphics.rectangle("fill", 0, 0, WIDTH, HEIGHT)

	love.graphics.setColor(0.5, 0.5, 0.5)

	for row, cols in ipairs(self.board) do
		for col, value in ipairs(cols) do
			if value == 1 then
				local x = (col - 1) * CELL
				local y = (row - 1) * CELL

				love.graphics.rectangle("fill", x, y, SIZE, SIZE)
			end
		end
	end
end

return Conway