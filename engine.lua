local engine = {}

local cells = require('cell')

Engine = {
  cell_array_height = 0,
  cell_array_width = 0,
  game_grid = {},
  process_cell = function(row, col, old_grid) end
}

function Engine:New(o)
  o = o or {
    cell_array_height = 0,
    cell_array_width = 0,
    game_grid = {}
  }
  setmetatable(o, self)
  self.__index = self
  return o
end

function Engine:SetCellArrayDimensions(array_height, array_width)
  self.cell_array_height = array_height
  self.cell_array_width = array_width

  for row = 1, array_height do
    self.game_grid[row] = {}
    for col = 1, array_width do
      self.game_grid[row][col] = false
    end
  end
end

function Engine:AddAliveCell(row, col)
  if row > 0 and row <= self.cell_array_height and col > 0 and col <= self.cell_array_width then
    self.game_grid[row][col] = true
  end
end

function Engine:StepSimulation()
  -- construct new grid object
  local next_grid = {}

  -- loop thru and apply rule to each cell
  for row = 1, #self.game_grid do
    next_grid[row] = {}
    for col = 1, #self.game_grid[row] do
      next_grid[row][col] = self.process_cell(row, col, self.game_grid)
    end
  end

  -- set self.game_grid to new object
  self.game_grid = next_grid
end

function Engine:GetAliveCount()
  local alive_count = 0

  for row = 1, #self.game_grid do
    for col = 1, #self.game_grid[row] do
      if self.game_grid[row][col] then
        alive_count = alive_count + 1
      end
    end
  end

  return alive_count
end

return engine
