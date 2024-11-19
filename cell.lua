local cell = {}

function cell:GetCellArraySize(cell_pixel_size, window_height, window_width)
  local cell_array_height = window_height / cell_pixel_size
  local cell_array_width = window_width / cell_pixel_size

  return math.floor(cell_array_height), math.floor(cell_array_width)
end

return cell
