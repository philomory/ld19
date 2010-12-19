module LD19
  class Prop::Coin < Prop::Pickup
    
    def initialize(options ={})
      super
      properties = options[:properties] || {}
      build(properties)
    end
    
    def build(properties = {})
      @value = properties[:value] || 1
      @image = Image['coin.png']
      @sound = Sound['coin.ogg']
    end
    
    def picked_up_by(player)
      player.coins += @value
    end
  end
end