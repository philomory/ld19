module LD19
  class HUD < Chingu::BasicGameObject
    def initialize(options = {})
      super
      @player = options[:player] || @parent.player
    end
    
    def draw
      draw_health
    end
    
    def draw_health
      x = 512 - (8 * XFactor * 10)
      y = 96
      @player.health.times do
        Image["heart.png"].draw(x,y,0,XFactor,YFactor)
        x += (8 * XFactor)
      end
      
      @player.damage_taken.times do
        Image["heart.png"].draw(x,y,0,XFactor,YFactor,0xFFBBBBBB)
        x += (8 * XFactor)
      end
    end
    
    def visible
      true
    end
    
  end
end