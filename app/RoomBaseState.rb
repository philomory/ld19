module LD19
  class RoomBaseState < Chingu::GameState
    include RoomLoader
    attr_reader :terrain
    def initialize(options = {})
      super
      px, py = *options[:player_pos] || [PlayerStartX, PlayerStartY]
      
      load_room_data
      @terrain = load_terrain
      load_props
      load_enemies
      @player = PlayerSprite.create(:x => px, :y => py, :basic_player => $window.basic_player)      
      @HUD = HUD.create(:player => @player)
    end
    
    def update
      super
      
      @player.each_bounding_box_collision(Enemy) do |player, enemy|
        player.hit_by(enemy)
      end
      
      @player.each_bounding_box_collision(Prop) do |player, prop|
        prop.player_collision(player)
      end
      
      PlayerSword.each_bounding_box_collision(Enemy) do |sword, enemy|
        enemy.hit_by(sword)
      end
      
      Prop.each_bounding_box_collision(Enemy) do |prop, enemy|
          prop.enemy_collision(enemy)
      end
      
      Prop.each_bounding_box_collision(PlayerSword) do |prop, weapon|
          prop.weapon_collision(weapon)
      end
      
    end
    
    def draw
      @terrain.each_with_coords do |type,x,y|
        details = TerrainProperties[type]
        next unless details[:image_file]
        x_pos = x * TileWidth * XFactor
        y_pos = (y * TileHeight + MapYOffset) * YFactor
        Image[details[:image_file]].draw(x_pos,y_pos,0,XFactor,YFactor)
      end
      super
    end
    
    def terrain_at(x_pos,y_pos)
      grid_x = x_pos / (XFactor * TileWidth)
      grid_y = ((y_pos / YFactor) - MapYOffset) / TileHeight
      @terrain[grid_x,grid_y]
    end
    
    private
    def load_room_data
      raise "Child class must define load_room_data!"
    end
    
  end
end