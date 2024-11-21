local rules = {}

function Conways(row, col, old_grid)
  local surroundings = GetSurroundings(row, col, 1)

  local neighbor_count = 0

  for i = 1, #surroundings do
    local current = surroundings[i]

    if old_grid[current[1]][current[2]] then
      neighbor_count = neighbor_count + 1
    end
  end

  if old_grid[row][col] then -- current cell is alive
    return neighbor_count == 3 or neighbor_count == 2
  else                       -- current cell is dead
    return neighbor_count == 3
  end
end

function Sam1(row, col, old_grid)
  local surroundings = GetSurroundings(row, col, 1)

  local neighbor_count = 0

  for i = 1, #surroundings do
    local current = surroundings[i]

    if old_grid[current[1]][current[2]] then
      neighbor_count = neighbor_count + 1
    end
  end

  if old_grid[row][col] then
    -- alive
    return neighbor_count == 3 or neighbor_count == 2
  else
    -- dead
    return neighbor_count == 3
  end
end

return rules
