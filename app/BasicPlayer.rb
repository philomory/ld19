module LD19
  class BasicPlayer < Chingu::BasicGameObject
    attr_reader :health
    attr_accessor :max_health
    def initialize(options = {})
      super
      @health = @max_health = 8
    end
        
    def health=(num)
      if num > @max_health
        @health = @max_health
      elsif num <= 0
        @health = 0
        die
      else
        @health = num
      end
    end
    
    def damage_taken
      @max_health - @health
    end
    
    def die
      @dead = true
      self.destroy!
    end
    
    def dead?
      @dead
    end
    
  end
end