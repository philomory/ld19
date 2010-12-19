module LD19
  class OverworldState < RoomBaseState
    def initialize(options = {})
      @latitude, @longitude = options[:latitude], options[:longitude] # lat = e/w = x, long = n/s = y

      super
      @enemy = Enemy.create(:x => 400, :y => 400, :health => 2)
    end
    
    def update
      super
      x, y = @latitude, @longitude
      $window.caption = "FPS:#{$window.fps}, X:#{x} Y:#{y} File:map/y#{y}/x#{x}y#{y}/terrain.yaml"
    end
    
    def transition(direction)
      case direction
      when :west  
        lat, long = @latitude - 1, @longitude
        p_x, p_y = PlayerXEntryEast, @player.y
      when :east  
        lat, long = @latitude + 1, @longitude
        p_x, p_y = PlayerXEntryWest, @player.y
      when :north 
        lat, long = @latitude, @longitude - 1
        p_x, p_y = @player.x, PlayerYEntrySouth
      when :south 
        lat, long = @latitude, @longitude + 1
        p_x, p_y = @player.x, PlayerYEntryNorth
      end

      switch_game_state(OverworldState.new(:latitude => lat, :longitude => long, 
                                           :player_pos => [p_x,p_y], :player => @player))    
    end
    
    def cave_transition(destination)
      if destination[:type] = :small_cave
        push_game_state(SmallCaveState.new(destination))
      else
      end
    end
    
    private
    def load_room_data
      x, y = @latitude, @longitude
      file = "#{ROOT}/map/y#{y}/x#{x}y#{y}/terrain.yaml"
      @yml = YAML.load_file(file)
    end
  end
end