module LD19
  class Prop < Chingu::GameObject
    traits :bounding_box, :collision_detection
    
    def self.place(options = {})
      klass = self.const_get(options[:klass])
      options[:x] *= (TileWidth * XFactor)
      options[:x] += (TileWidth * XFactor / 2)
      options[:y] *= (TileHeight * YFactor)
      options[:y] += (MapYOffset * YFactor)
      options[:y] += (TileHeight * YFactor / 2)
      instance = klass.create(options)
      instance.build(options[:properties])
      instance
    end
    
    def build(options = {})
    end

    def player_collision(player)
    end
    
    def enemy_collision(enemy)
    end
    
    def weapon_collision(weapon)  
    end
    
    
  end
end