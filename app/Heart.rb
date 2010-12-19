module LD19
  class Prop::Heart < Prop::Pickup
    def initialize(options ={})
      super
      @image = Image['heart.png']
      @sound = Sound['heart.ogg']
    end
    
    def picked_up_by(player)
      player.health += 1
    end
  end
end