module LD19
  class Prop::BridgeBuilder < Prop::Pickup
    def build(properties = {})
      destroy! if $window.basic_player.has_item?(:bridge_builder)
      @image = Image["bridge_builder.png"]
    end
    
    def picked_up_by(player)
      @x = @y = 0
      player.get_item(:bridge_builder,self)
    end
  end
end