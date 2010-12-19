module LD19
  module TerrainCollision
    def colliding_with_terrain?
      box = self.bounding_box
      points = case @moving
      when :west then [box.topleft, box.bottomleft]
      when :east then [box.topright, box.bottomright]
      when :north then [box.topleft, box.topright]
      when :south then [box.bottomleft, box.bottomright]
      end
      
      walkable = points.all? do |point|
        collide_terrain_at_point?(*point)
      end
      
      return !walkable
      
    end
    
    def collide_terrain_at_point?(x_pos,y_pos)
      TerrainProperties[@parent.terrain_at(x_pos,y_pos)][:walkable]
    end
    
    def leaving_screen?
      box = self.bounding_box
      case @moving
      when :west then (box.left <= 0)
      when :east then (box.right >= $window.width)
      when :north then (box.top <= MapYOffset * YFactor)
      when :south then (box.bottom >= $window.height)
      end
    end
    
  end
end