local cell = require('cell')
local polygon = require('polygon')
local engine = require('engine')
local rules = require('rules')

local CELL_PIXEL_SIZE = 3
local CELL_PIXEL_SPACING = 1

local TOTAL_CELL_PIXEL_SIZE = CELL_PIXEL_SIZE + (2 * CELL_PIXEL_SPACING)

local CELL_ARRAY_HEIGHT = 0
local CELL_ARRAY_WIDTH = 0

local game_engine = Engine:New()

local timer = 0

local auto_step = false

function love.load(args)
  CELL_ARRAY_HEIGHT, CELL_ARRAY_WIDTH = cell:GetCellArraySize(
    TOTAL_CELL_PIXEL_SIZE,
    love.graphics.getHeight(),
    love.graphics.getWidth())

  local rule = Conways

  game_engine:SetCellArrayDimensions(CELL_ARRAY_HEIGHT, CELL_ARRAY_WIDTH)
  game_engine.process_cell = rule

  cell.cell_array_height = CELL_ARRAY_HEIGHT
  cell.cell_array_width = CELL_ARRAY_WIDTH

  SeedCells()
end

function love.keypressed(key, scancode, isrepeat)
  if key == "escape" then
    love.event.quit()
  end

  if key == "n" then
    game_engine:StepSimulation()
  end

  if key == "a" then
    auto_step = not auto_step
  end

  if key == "r" then
    game_engine:SetCellArrayDimensions(CELL_ARRAY_HEIGHT, CELL_ARRAY_WIDTH)
    SeedCells()
  end
end

function love.mousepressed(x, y, button, istouch)
  if button == 1 then
    local col = math.floor((x / TOTAL_CELL_PIXEL_SIZE) + 0.5)
    local row = math.floor((y / TOTAL_CELL_PIXEL_SIZE) + 0.5)

    game_engine:ToggleCell(row, col)
  end
end

function love.update(dt)
  timer = timer + dt
end

function love.draw()
  if timer > .25 then
    timer = 0

    if auto_step then
      love.graphics.clear()
      game_engine:StepSimulation()
    end
  end

  -- Generate & draw cells
  for row = 1, CELL_ARRAY_HEIGHT do
    for col = 1, CELL_ARRAY_WIDTH do
      if game_engine.game_grid[row][col] then
        local corner = {
          ((col - CELL_PIXEL_SPACING) * TOTAL_CELL_PIXEL_SIZE) + CELL_PIXEL_SPACING,
          ((row - CELL_PIXEL_SPACING) * TOTAL_CELL_PIXEL_SIZE) + CELL_PIXEL_SPACING
        }
        local corners = polygon:GenerateSquareVerticies(corner, CELL_PIXEL_SIZE)

        love.graphics.polygon('fill', corners)
      end
    end
  end

  love.graphics.print(game_engine:GetAliveCount(), 20, 20, 0, 1, 1, 0, 0)
end

function SeedCells()
  local center_row = math.floor(CELL_ARRAY_HEIGHT / 2)
  local center_col = math.floor(CELL_ARRAY_WIDTH / 2)

  game_engine:AddAliveCell(center_row, center_col)
  game_engine:AddAliveCell(center_row + 1, center_col)
  game_engine:AddAliveCell(center_row + 1, center_col - 1)
  game_engine:AddAliveCell(center_row + 2, center_col)
  game_engine:AddAliveCell(center_row + 2, center_col + 1)
end
