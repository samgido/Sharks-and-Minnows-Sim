local cell = {
  cell_array_height = 0,
  cell_array_width = 0
}

function cell:GetCellArraySize(cell_pixel_size, window_height, window_width)
  local cell_array_height = window_height / cell_pixel_size
  local cell_array_width = window_width / cell_pixel_size

  return math.floor(cell_array_height), math.floor(cell_array_width)
end

function GetSurroundings(current_row, current_col, radius)
  local cells = {}

  -- Increment row, use two columns
  for i = (current_row - radius), (current_row + radius) do
    if i > 0 and i <= cell.cell_array_height then
      local right = current_col + radius
      local left = current_col - radius

      if right > 0 and right <= cell.cell_array_width then
        -- table.insert(cells, i)
        -- table.insert(cells, right)
        table.insert(cells, { i, right })
      end

      if left > 0 and left <= cell.cell_array_width then
        -- table.insert(cells, i)
        -- table.insert(cells, left)
        table.insert(cells, { i, left })
      end
    end
  end

  -- Increment width, use two rows
  for i = (current_col - radius + 1), (current_col + radius - 1) do
    if i > 0 and i <= cell.cell_array_width then
      local top = current_row - radius
      local bottom = current_row + radius

      if top > 0 and top <= cell.cell_array_height then
        -- table.insert(cells, top)
        -- table.insert(cells, i)
        table.insert(cells, { top, i })
      end

      if bottom > 0 and bottom <= cell.cell_array_height then
        -- table.insert(cells, bottom)
        -- table.insert(cells, i)
        table.insert(cells, { bottom, i })
      end
    end
  end

  return cells
end

return cell
