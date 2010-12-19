module LD19
  class Prop::CaveEntrance < Prop
    trait :bounding_box, :scale => 0.3
    trait :collision_detection
    def build(properties = {})
      @properties = properties
      @image = Image['cave.png']
      @base_type = @properties[:base] || :stone_wall
      @base_image = Image[TerrainProperties[@base_type][:image_file]]
    end
    
    def draw
      @base_image.draw_rot(@x, @y, @zorder, @angle, @center_x, @center_y, @factor_x, @factor_y, @color, @mode)  if @base_image
      super
    end
    
    def player_collision(player)
      details = @properties
      details[:entrance_x] = player.last_x
      details[:entrance_y] = player.last_y
      details[:player] = player
      @parent.cave_transition(details)
    end
    
  end
end