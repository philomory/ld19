module LD19
  class BasicPlayer < Chingu::BasicGameObject
    attr_reader :health, :coins, :keys, :deciphered
    attr_accessor :max_health, :max_coins
    def initialize(options = {})
      super
      @health = @max_health = 8
      @coins = 0
      @max_coins = 100
      @keys = Array.new(9)
      @deciphered = 0
    end
    
    def get_key(key)
      @keys[key.number-1] = key
    end
    
    def has_key?(num)
      @keys[num]
    end
    
    def coins=(num)
      if num > @max_coins
        @coins = @max_coins
      elsif num <= 0
        @coins = 0
      else
        @coins = num
      end
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