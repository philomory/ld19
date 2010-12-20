module LD19
  class Prop::BridgeBase < Prop
    trait :timer
    
    def build(properties = {})
      @properties = properties
      @image = Image["bridge_base_#{@properties[:direction]}.png"]
      @bridge_length = @properties[:bridge_length]
      @adj = case @properties[:direction]
      when :east  then [ 1, 0]
      when :west  then [-1, 0]
      when :north then [ 0,-1]
      when :south then [ 0, 1]
      end
      @bridge_activated = false
      @bridge_index = 1
    end
    
    def player_collision(player)
      if player.has_item?(:bridge_builder) and not @bridge_activated
        build_bridge
      end
    end
    
    def build_bridge
      puts "start again"
      @bridge_activated = true
      every(100, :name => :bridge_building) do
        if @bridge_index > @bridge_length
          self.stop_timer(:bridge_building)
          @stop_building = true
        end
        place_bridge_square(@bridge_index) unless @stop_building
        @bridge_index += 1
      end
    end
    
    def place_bridge_square(i)
      place_x = @properties[:grid_x] + (@adj[0] * i)
      place_y = @properties[:grid_y] + (@adj[1] * i)
      @parent.terrain[place_x,place_y] = :bridge
    end
    
  end
end