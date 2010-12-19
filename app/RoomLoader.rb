#require 'Grid'

module LD19
  module RoomLoader
    def load_terrain
      grid = Grid.new(MapTilesWide, MapTilesHigh)
      mappings = @yml[:mappings]
      mappings.default = @yml[:default]
           
      @yml[:data].lines.each_with_index do |line,y|
        line[0...MapTilesWide].chars.each_with_index do |char,x|
          grid[x,y] = mappings[char]
        end
      end
      
      grid
    end
    
    def load_props
      return unless @yml[:props]
      @yml[:props].each do |prop|
        Prop.place(prop)
      end
    end
    
    def load_enemies
      return unless @yml[:enemies]
      @yml[:enemies].each do |enemy|
        Enemy.create(enemy)
      end
    end
    
    def load_prize
      @return unless @yml[:prize]
      @prize = @yml[:prize]
    end
    
  end
end