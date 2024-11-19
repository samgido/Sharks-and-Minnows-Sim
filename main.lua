local cell = require('cell')
local polygon = require('polygon')

local CELL_PIXEL_SIZE = 5
local CELL_PIXEL_SPACING = 1

local TOTAL_CELL_PIXEL_SIZE = CELL_PIXEL_SIZE + (2 * CELL_PIXEL_SPACING)

local CELL_ARRAY_HEIGHT = 0
local CELL_ARRAY_WIDTH = 0

local game_grid = {}

function love.load(args)
  CELL_ARRAY_HEIGHT, CELL_ARRAY_WIDTH = cell:GetCellArraySize(
    TOTAL_CELL_PIXEL_SIZE,
    love.graphics.getHeight(),
    love.graphics.getWidth())


  for row = 1, CELL_ARRAY_HEIGHT do
    game_grid[row] = {}
    for col = 1, CELL_ARRAY_WIDTH do
      game_grid[row][col] = false
    end
  end
end

function love.keypressed(key, scancode, isrepeat)
  if key == "escape" then
    love.event.quit()
  end
end

function love.draw()
  -- Generate & draw cells
  for row = 1, CELL_ARRAY_HEIGHT do
    for col = 1, CELL_ARRAY_WIDTH do
      local corner = {
        ((col - CELL_PIXEL_SPACING) * TOTAL_CELL_PIXEL_SIZE) + CELL_PIXEL_SPACING,
        ((row - CELL_PIXEL_SPACING) * TOTAL_CELL_PIXEL_SIZE) + CELL_PIXEL_SPACING
      }

      local corners = polygon:GenerateSquareVerticies(corner, CELL_PIXEL_SIZE)

      if game_grid[row][col] then
        love.graphics.polygon('fill', corners)
      end
    end
  end
end
