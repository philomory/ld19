#require 'Grid'

module LD19
  module TerrainLoader
    module_function
    def load_terrain(x,y)
      grid = Grid.new(MapTilesWide, MapTilesHigh)
      file = "#{ROOT}/map/y#{y}/x#{x}y#{y}/terrain.yaml"
      yml = YAML.load_file(file)
      mappings = yml[:mappings]
      mappings.default = yml[:default]
           
      yml[:data].lines.each_with_index do |line,y|
        line[0...MapTilesWide].chars.each_with_index do |char,x|
          grid[x,y] = mappings[char]
        end
      end
      
      grid
    end
    
  end
end