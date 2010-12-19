module LD19
  class HUD < Chingu::BasicGameObject
    def initialize(options = {})
      super
      @player = options[:player] || @parent.player
      @font = Font[20]
    end
    
    def draw
      draw_health
      draw_wealth
      draw_keys
    end
    
    def draw_keys
      key_order = ((@player.deciphered == 2) ? [0,1,2,3,4,5,6,7,8] : [5,4,0,9,6,2,1,8,3])
      x = (8 * XFactor * 2)
      y = 96
      9.times do |num|
        if (key = @player.has_key?(key_order[num]))
          angle = @player.deciphered.zero? ? 180 : 0
          key.image.draw_rot(x,y,1,angle,0.5,0.5,XFactor,YFactor,)
        end
        x += 16 * XFactor
      end
    end
    
    def draw_wealth
      x = 512 - (8 * XFactor * 10)
      y = 72
      Image['coin.png'].draw(x,y,0,XFactor,YFactor)
      @font.draw(" x #{@player.coins}",x + 16, y,1)
    end
    
    def draw_health
      x = 512 - (8 * XFactor * 10)
      y = 96
      @player.health.times do
        Image["heart.png"].draw(x,y,0,XFactor,YFactor)
        x += (8 * XFactor)
      end
      
      @player.damage_taken.times do
        Image["heart.png"].draw(x,y,0,XFactor,YFactor,0xFF888888)
        x += (8 * XFactor)
      end
    end
    
    def visible
      true
    end
    
  end
end