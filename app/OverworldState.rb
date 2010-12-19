#require 'TerrainProperties'

module LD19
  class OverworldState < Chingu::GameState
    def initialize(options = {})
      super
      @latitude, @longitude = options[:latitude], options[:longitude] # lat = e/w = x, long = n/s = y
      px, py = *options[:player_pos] || [PlayerStartX, PlayerStartY]
      
      @terrain = TerrainLoader.load_terrain(@latitude,@longitude)
      if options[:player]
        @player = options[:player]
        @player.parent = self;
        @player.x, @player.y = px, py
      else
        @player = PlayerSprite.create(:x => px, :y => py)
      end
      @enemy = Enemy.create(:x => 400, :y => 400, :health => 2)
      
      @HUD = HUD.create(:player => @player)
      
    end
    
    def update
      super
      x, y = @latitude, @longitude
      $window.caption = "FPS:#{$window.fps}, X:#{x} Y:#{y} File:map/y#{y}/x#{x}y#{y}/terrain.yaml"
      
      @player.each_bounding_box_collision(Enemy) do |player, enemy|
        player.hit_by(enemy)
      end
      
      PlayerSword.each_bounding_box_collision(Enemy) do |sword, enemy|
        enemy.hit_by(sword)
      end
    end
    
    def draw
      @terrain.each_with_coords do |type,x,y|
        details = TerrainProperties[type]
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
    
    def transition(direction)
      case direction
      when :west  
        lat, long = @latitude - 1, @longitude
        p_x, p_y = $window.width, @player.y
      when :east  
        lat, long = @latitude + 1, @longitude
        p_x, p_y = 0, @player.y
      when :north 
        lat, long = @latitude, @longitude - 1
        p_x, p_y = @player.x, $window.height
      when :south 
        lat, long = @latitude, @longitude + 1
        p_x, p_y = @player.x, MapYOffset * YFactor
      end

      switch_game_state(OverworldState.new(:latitude => lat, :longitude => long, 
                                           :player_pos => [p_x,p_y], :player => @player))
        
    end
  end
end