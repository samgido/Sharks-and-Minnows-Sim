local cell = {}

function cell:GetCellArraySize(cell_pixel_size, window_height, window_width)
  local cell_array_height = window_height / cell_pixel_size
  local cell_array_width = window_width / cell_pixel_size

  return math.floor(cell_array_height), math.floor(cell_array_width)
end

function cell:GetSurroundings(current_row, current_col, radius, search_color)
  local cells = {}

  -- Increment height, use two columns
  for i = (current_row - radius), (current_row + radius) do
    local left = Cell
    left = {
      row = i,
      col = current_col + radius,
      color = search_color,
      alive = true
    }

    local right = Cell
    right = {
      row = i,
      col = current_col - radius,
      color = search_color,
      alive = true
    }

    table.insert(cells, left)
    table.insert(cells, right)
  end

  -- Increment width, use two rows
  for i = (current_col - radius), (current_col + radius) do
    local top = Cell
    top = {
      row = current_row + radius,
      col = i,
      color = search_color,
      alive = true
    }

    local bottom = Cell
    bottom = {
      row = current_row - radius,
      col = i,
      color = search_color,
      alive = true
    }

    table.insert(cells, top)
    table.insert(cells, bottom)
  end

  return cells
end

return cell
