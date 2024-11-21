local cell = require('cell')
local polygon = require('polygon')

local CELL_PIXEL_SIZE = 5
local CELL_PIXEL_SPACING = 1

local TOTAL_CELL_PIXEL_SIZE = CELL_PIXEL_SIZE + (2 * CELL_PIXEL_SPACING)

local CELL_ARRAY_HEIGHT = 0
local CELL_ARRAY_WIDTH = 0

local game_grid = {}
local radius = 0

Cell = {
  row = 0,
  col = 0,
  color = { 1, 1, 1, 1 },
  alive = false
}

function love.load(args)
  CELL_ARRAY_HEIGHT, CELL_ARRAY_WIDTH = cell:GetCellArraySize(
    TOTAL_CELL_PIXEL_SIZE,
    love.graphics.getHeight(),
    love.graphics.getWidth())

  InitializeGameGrid()
end

function love.keypressed(key, scancode, isrepeat)
  if key == "escape" then
    love.event.quit()
  end
end

function love.draw()
  if radius < 20 then
    radius = radius + 1
  else
    radius = 0
  end

  love.graphics.clear()
  InitializeGameGrid()

  game_grid[30][30] = {
    row = 30,
    col = 30,
    color = { 1, 0, 0, 1 },
    alive = true
  }

  local cells = cell:GetSurroundings(30, 30, radius, { 0, 1, 0, 1 })
  for i = 1, #cells do
    local cell = cells[i]

    if cell.row > 0 and cell.row <= CELL_ARRAY_HEIGHT and cell.row > 0 and cell.row <= CELL_ARRAY_WIDTH then
      game_grid[cell.row][cell.col] = cell
    end
  end

  -- Generate & draw cells
  for row = 1, CELL_ARRAY_HEIGHT do
    for col = 1, CELL_ARRAY_WIDTH do
      local corner = {
        ((col - CELL_PIXEL_SPACING) * TOTAL_CELL_PIXEL_SIZE) + CELL_PIXEL_SPACING,
        ((row - CELL_PIXEL_SPACING) * TOTAL_CELL_PIXEL_SIZE) + CELL_PIXEL_SPACING
      }

      local corners = polygon:GenerateSquareVerticies(corner, CELL_PIXEL_SIZE)

      if game_grid[row][col] then
        local cell = game_grid[row][col]
        love.graphics.setColor(cell.color[1], cell.color[2], cell.color[3], cell.color[4])

        love.graphics.polygon('fill', corners)
      end
    end
  end
end

function InitializeGameGrid()
  for row = 1, CELL_ARRAY_HEIGHT do
    game_grid[row] = {}
    for col = 1, CELL_ARRAY_WIDTH do
      local cell = Cell
      cell = {
        row = row,
        col = col,
        color = { 0, 0, 0, 1 },
        alive = false
      }

      game_grid[row][col] = cell
    end
  end
end
