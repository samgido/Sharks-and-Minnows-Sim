local polygon = {}

function polygon:GenerateSquareVerticies(corner, side_length)
  return { corner[1], corner[2], corner[1] + side_length, corner[2], corner[1] + side_length, corner[2] + side_length,
    corner[1], corner[2] + side_length }
end

return polygon
