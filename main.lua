local CELL_ARRAY_HEIGHT = 0
local CELL_ARRAY_WIDTH = 0

local CELL_PIXEL_SIZE = 5
local CELL_PIXEL_SPACING = 1

local TOTAL_CELL_PIXEL_SIZE = CELL_PIXEL_SIZE + (2 * CELL_PIXEL_SPACING)

local cell = require('cell')
local polygon = require('polygon')

function love.load(args)
  CELL_ARRAY_HEIGHT, CELL_ARRAY_WIDTH = cell:GetCellArraySize(
    TOTAL_CELL_PIXEL_SIZE,
    love.graphics.getHeight(),
    love.graphics.getWidth())
end

function love.keypressed(key, scancode, isrepeat)
  if key == "escape" then
    love.event.quit()
  end
end

function love.draw()
  for row = 1, CELL_ARRAY_HEIGHT - 1 do
    for col = 1, CELL_ARRAY_WIDTH - 1 do
      local corner = {
        (col * TOTAL_CELL_PIXEL_SIZE) + CELL_PIXEL_SPACING,
        (row * TOTAL_CELL_PIXEL_SIZE) + CELL_PIXEL_SPACING
      }

      local corners = polygon:GenerateSquareVerticies(corner, CELL_PIXEL_SIZE)

      love.graphics.polygon('fill', corners)
    end
  end
end
